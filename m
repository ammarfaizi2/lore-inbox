Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbTGONGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267590AbTGONGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:06:05 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:63756 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S267548AbTGONF6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:05:58 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Jul_15_13_20_45_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20030715132045.5B5D189D4B@merlin.emma.line.org>
Date: Tue, 15 Jul 2003 15:20:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
7 new address -> name mappings.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   18 +++++++++++++++++-
# 1 files changed, 17 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.67    -> 1.68   
#	            shortlog	1.41    -> 1.42   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/15	matthias.andree@gmx.de	1.68
# Upstream update 0.145 -> 0.148
# 7 new addresses
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Jul 15 15:20:44 2003
+++ b/shortlog	Tue Jul 15 15:20:44 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.145 2003/07/11 08:37:05 vita Exp $
+# $Id: lk-changelog.pl,v 0.148 2003/07/15 12:59:09 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -193,6 +193,7 @@
 'arndb:de.ibm.com' => 'Arnd Bergmann',
 'arndt:lin02384n012.mc.schoenewald.de' => 'Arndt Schoenewald',
 'arun.sharma:intel.com' => 'Arun Sharma',
+'arzie:dds.nl' => 'Robert Zwerus',
 'aschultz:warp10.net' => 'Andreas Schultz',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
@@ -282,6 +283,7 @@
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
 'christopher.leech:intel.com' => 'Christopher Leech',
 'christopher:intel.com' => 'Christopher Goldfarb',
+'chyang:clusterfs.com' => 'Chen Yang',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clemens:ladisch.de' => 'Clemens Ladisch',
@@ -536,6 +538,7 @@
 'j-nomura:ce.jp.nec.com' => 'Junichi Nomura',
 'j.dittmer:portrix.net' => 'Jan Dittmer',
 'jack:suse.cz' => 'Jan Kara',
+'jack:ucw.cz' => 'Jan Kara',
 'jack_hammer:adaptec.com' => 'Jack Hammer',
 'jackson:realtek.com.tw' => 'Ian Jackson',
 'jaharkes:cs.cmu.edu' => 'Jan Harkes',
@@ -558,6 +561,7 @@
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
 'jblack:linuxguru.net' => 'James Blackwell',
 'jbm:joshisanerd.com' => 'Josh Myer',
+'jbourne:hardrock.org' => 'James Bourne',
 'jcdutton:users.sourceforge.net' => 'James Courtier-Dutton',
 'jdavid:farfalle.com' => 'David Ruggiero',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
@@ -779,6 +783,7 @@
 'mikael.starvik:axis.com' => 'Mikael Starvik',
 'mikal:stillhq.com' => 'Michael Still',
 'mike:aiinc.ca' => 'Michael Hayes',
+'mike.miller:hp.com' => 'Mike Miller',
 'mikenc:us.ibm.com' => 'Mike Christie',
 'mikep:linuxtr.net' => 'Mike Phillips',
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
@@ -1153,6 +1158,7 @@
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
 'wd:denx.de' => 'Wolfgang Denk',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
+'wensong:linux-vs.org' => 'Wensong Zhang',
 'wes:infosink.com' => 'Wes Schreiner',
 'wesolows:foobazco.org' => 'Keith M. Wesolowski',
 'wg:malloc.de' => 'Wolfram Gloger', # lbdb
@@ -1177,6 +1183,7 @@
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
 'ya:slamail.org' => 'Yaacov Akiba Slama',
+'yinah:couragetech.com.cn' => 'Yin Aihua',
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
@@ -1777,6 +1784,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.148  2003/07/15 12:59:09  vita
+# added 4 names for new addresses
+#
+# Revision 0.147  2003/07/14 15:31:34  vita
+# added 2 names for new addresses
+#
+# Revision 0.146  2003/07/13 09:25:39  emma
+# add 1 address
+#
 # Revision 0.145  2003/07/11 08:37:05  vita
 # add 4 names for new addresses; resort address->name hash
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.68
## Wrapped with gzip_uu ##


begin 600 bkpatch12326
M'XL(`*S_$S\``\U576_;-A1]#G_%!5+`#ZUD4A^F1<!!F[38LJQHD2(8VC>:
MNK8T2Y1!4K93Z,>/DN*D,5I@W?8P6S!$\MS#>XZ.J7.XLVC$62V=*TII0ZES
M@TC.X=?&.G&VK@]AW@]OF\8/I[:U.-V@T5A-+V_\%8R#P#5-98D'?I1.%;!#
M8\49"^/'&7>_17%V^^Z7N]_?W!*R6,!5(?4:/Z&#Q8*XQNQDE=O76]3KMM2A
M,U+;&IT,55-WC]@NHC3R7Q;%=)9F793-TK3#"--4)4PN^9RCBLB)GM>CCN<T
M,>6,L8BQE'>4<38G;X&%LSG0>$KYE*7`4L$RD;"7-!*4PO=)X26#@))+^(\E
M7!$%=UOK#,H:VFTN'0(-69)"<#'<S#V`@\8]R-SW8RU:<@.,QYQ\?#*7!#_Y
M(81*2BZ>Y!1-C2=:;-$85S7K44K*YI0GWL`N9CQ+NQ5F<J4XS23%7"[S'QCW
MC*5_&"F+69:P+I[%"1\B<D0\2\B_[N='Z3CM9PQ'TLT2%M$A'$GT\^'@$+#_
M33I&:S]`8/:'_@H./BM'W?\@*F\9`T:NA]]S>'&="Z@V@1K$>,9P6[W:C>U`
M;^K1NDBDF:`9[$HGX=UA"R\\1^87R$2:KR6*/+>AKB:PN(#);;-$X^#+'DUK
M)Z_(=31/>J0J[OTV0E6M=6A6MO=QK+@J4,-GO]BCTWC>H_^4:B-:M0_5UQ'T
MF]1P(XT<,#,Z8)9-ZT\S44B3FT9MPL:LC^`:+5P.RWT!G_>*)W6YP;`NJ\J?
MH<7VJ8'W?A[>#_,]VJ=HT+9';1O?<E7J]A#L[!/_'^,*?"D>NF8^N7W)?:EE
M(93?6*[1H2KZ34*EQ[+/I88W9=$.(ACW)5E_5N.NM&6C'XS_KO.#]1[KPX$Y
M)*`'@:O&G$3F_)2/?\.7]'^"F(DX.>&+_C[?[!N^&&@F(D_I^\.Z?N`#=JSW
;U8_O$U6@VMBV7BPSMLJS&2=_`1RT]:/,!@``
`
end

