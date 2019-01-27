#!/usr/bin/env bash

SRC=content/invoice
DEST=examples/invoice

# Ensure Examples Folder Exists
mkdir examples >> /dev/null

# Generate PDF
# https://emacs.stackexchange.com/a/10428/18882
yes | emacs \
    -u "$(id -un)" \
    --batch \
    --eval '(load user-init-file)' \
    $SRC.org \
    -f org-latex-export-to-pdf


# Move PDF
mv $SRC.pdf $DEST.pdf

# Convert to PNG
convert -density 300 -background white -alpha off $DEST.pdf $DEST.png
convert -geometry 800x +repage $DEST.png $DEST.png
convert $DEST.png +repage -gravity North -crop 800x950+0+0 +repage $DEST.png
