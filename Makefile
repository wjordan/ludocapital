PROJ := thesis

SRC	:= $(PROJ).tex
DEP	:= $(wildcard *.tex *.bib) ucithesis.cls

OUT	:= .

PDF	:= $(OUT)/$(PROJ).pdf
BBL	:= $(OUT)/$(PROJ).bbl

TEXLIVE	:= /home/will/texlive/2014/bin/x86_64-linux
TEXCMD  := xelatex

CMDLATEX := $(TEXLIVE)/$(TEXCMD) -output-directory=$(OUT)

PDFVIEWER := evince

all: $(PDF)

$(BBL) :
	$(CMDLATEX) $(SRC)
	$(TEXLIVE)/biber $(OUT)/$(PROJ)

# OUT directory must be ordered before we generate output
$(PDF) : $(BBL) | $(OUT)
	$(CMDLATEX) $(SRC)
	$(CMDLATEX) $(SRC)	# Run LaTeX again to make sure all references are correct

# Create the OUT directory, if it doesn't exist
$(OUT):
	mkdir -p $@

show	: $(PDF)
	$(PDFVIEWER) "$(PDF)"

clean	:
	rm -rf $(OUT)/*.aux
	rm -rf $(OUT)/*.bbl
	rm -rf $(OUT)/*.blg
	rm -rf $(OUT)/*.lof
	rm -rf $(OUT)/*.log
	rm -rf $(OUT)/*.lot
	rm -rf $(OUT)/*.out
	rm -rf $(OUT)/*.toc
	rm -rf $(OUT)/*.pdf
	rm -rf $(OUT)/*.bcf
	rm -rf $(OUT)/*.run.xml
