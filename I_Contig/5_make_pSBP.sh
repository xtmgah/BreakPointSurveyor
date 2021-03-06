# See README for details of processing here.
# From, /gscuser/mwyczalk/projects/Virus/Virus_2013.9a/analysis/UnifiedVirus2/U_SAMBreakpoints/2_make_pSBP.sh

source ./BPS_Stage.config
BIN="$PYTHON $BPS_CORE/src/contig/SAMReader.py"

DATD="$OUTD/SAM" 
OUTDD="$OUTD/pSBP"
mkdir -p $OUTDD

function process {
    BAR=$1

    DAT="$DATD/${BAR}.QMD5.sam"
    OUT="$OUTDD/${BAR}.pSBP.dat"

    $BIN -o $OUT $DAT
    echo Written to $OUT
}

while read l; do  # iterate over all rows of samples.dat

    # Skip comments and header
    [[ $l = \#* ]] && continue
    [[ $l = barcode* ]] && continue

    BAR=`echo $l | awk '{print $1}'`

    process $BAR

done < $SAMPLE_LIST

