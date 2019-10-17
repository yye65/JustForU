#!/bin/bash

if [[ $# -eq 0 || $# -gt 2 ]]; then
    echo 'usage: mean.sh <column> [file.csv], that reads the column specified by <column> (a number) from the comma-separated-values file (with header) specified by [file.csv] (or from stdin if no [file.csv] is specified) and writes its mean.'
    exit 0
fi

column=$1

if [[ $# -eq 1 ]]; then
    file='/dev/stdin'
else
    file=$2
fi


cut -d "," -f $column $file | tail -n +2 | {
    sum=0
    line_count=0
    while read n; do
	sum=$(echo "$sum+$n" | bc)
	line_count=$(echo "$line_count+1" | bc)
    done
    mean=$(bc -l <<<"${sum}/${line_count}")
    printf "mean of column $column: %.4f\n" $mean
}

