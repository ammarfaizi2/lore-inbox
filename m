Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTHXLDF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 07:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTHXLDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 07:03:05 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:31390 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263447AbTHXLC5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 07:02:57 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sun_Aug_24_11_02_54_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030824110254.740B59000F@merlin.emma.line.org>
Date: Sun, 24 Aug 2003 13:02:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
  Add 8 new mappings from vita (merging Linus' additions back
  into upstram), correct 3 mappings.

  The BK (1.79) and CVS (0.160) versions are back in synch now.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   33 ++++++++++++++++++++++++++++-----
# 1 files changed, 28 insertions(+), 5 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.78    -> 1.79   
#	            shortlog	1.51    -> 1.52   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/24	matthias.andree@gmx.de	1.79
# Add 8 new mappings from vita (merging Linus' additions back
# into upstram), correct 3 mappings.
# emacs' ediff rules.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sun Aug 24 13:02:54 2003
+++ b/shortlog	Sun Aug 24 13:02:54 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.154 2003/08/08 22:40:06 emma Exp $
+# $Id: lk-changelog.pl,v 0.159 2003/08/22 08:11:41 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -255,6 +255,7 @@
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
+'bos:camp4.serpentine.com' => 'Bryan O\'Sullivan',
 'braam:clusterfs.com' => 'Peter Braam',
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brihall:pcisys.net' => 'Brian Hall', # google
@@ -579,9 +580,10 @@
 'jan:zuchhold.com' => 'Jan Zuchhold',
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
-'janiceg:us.ibm.com' => 'Janice Girouard',
+'janiceg:us.ibm.com' => 'Janice M. Girouard',
 'jasper:vs19.net' => 'Jasper Spaans',
 'javaman:katamail.com' => 'Paulo Ornati',
+'javier:tudela.mad.ttd.net' => 'Javier Achirica',
 'jay.estabrook:compaq.com' => 'Jay Estabrook',
 'jb:jblache.org' => 'Julien Blache',
 'jbarnes:sgi.com' => 'Jesse Barnes',
@@ -643,6 +645,7 @@
 'joe:wavicle.org' => 'Joe Burks',
 'joel.buckley:sun.com' => 'Joel Buckley',
 'joergprante:netcologne.de' => 'Jörg Prante',
+'joern:infradead.org' => 'Jörn Engel',
 'joern:wohnheim.fh-wedel.de' => 'Jörn Engel',
 'johan.adolfsson:axis.com' => 'Johan Adolfsson',
 'johann.deneux:it.uu.se' => 'Johann Deneux',
@@ -699,6 +702,7 @@
 'kernel:jsl.com' => 'Jeffrey S. Laing',
 'kernel:steeleye.com' => 'Paul Clements',
 'kettenis:gnu.org' => 'Mark Kettenis',
+'kevino:asti-usa.com' => 'Kevin Owen',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
 'khali:linux-fr.org' => 'Jean Delvare', # lbdb
@@ -709,7 +713,7 @@
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
-'klassert:mathematik.ru-chemnitz.de' => '',
+'klassert:mathematik.ru-chemnitz.de' => 'Steffen Klassert',
 'kmsmith:umich.edu' => 'Kendrick M. Smith',
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
 'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
@@ -739,6 +743,7 @@
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
 'len.brown:intel.com' => 'Len Brown',
+'lenb:dhcppc3.' => 'Len Brown',
 'lenb:dhcppc6.' => 'Len Brown',
 'lenehan:twibble.org' => 'Jamie Lenehan',
 'lethal:linux-sh.org' => 'Paul Mundt',
@@ -754,6 +759,7 @@
 'lists:mdiehl.de' => 'Martin Diehl',
 'liyang:nerv.cx' => 'Liyang Hu',
 'lkml001:vrfy.org' => 'Kay Sievers',
+'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
 'lkml:shemesh.biz' => 'Shachar Shemesh',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
@@ -796,6 +802,7 @@
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'markh:osdl.org' => 'Mark Haverkamp',
+'markhe:veritas.com' => 'Mark Hemment',
 'martin.bene:icomedias.com' => 'Martin Bene',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
 'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
@@ -828,7 +835,7 @@
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
-'michel:daenzer.net' => 'Michel Daenzer',
+'michel:daenzer.net' => 'Michel Dänzer',
 'mikael.starvik:axis.com' => 'Mikael Starvik',
 'mikal:stillhq.com' => 'Michael Still',
 'mike.miller:hp.com' => 'Mike Miller',
@@ -925,6 +932,7 @@
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'paubert:iram.es' => 'Gabriel Paubert',
+'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
@@ -1861,7 +1869,22 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
-# Revision 0.154  2003/08/08 22:40:06  emma
+# Revision 0.159  2003/08/22 08:11:41  vita
+# 8 new addresses
+#
+# Revision 0.158  2003/08/19 12:51:54  vita
+# 8 new addresses
+#
+# Revision 0.157  2003/08/18 13:23:53  vita
+# 7 new addresses
+#
+# Revision 0.156  2003/08/18 11:25:11  vita
+# Merge Linus' additions
+#
+# Revision 0.155  2003/08/09 22:30:17  emma
+# Merge Linus' changes.
+#
+# Revision 0.154  2003/08/09 22:29:38  emma
 # Bugfix: treat change sets that contain only blank lines.
 # Print each input line in $debug mode.
 # 16 new address mappings.

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.79
## Wrapped with gzip_uu ##


M'XL( %Z;2#\  ]56VV[;.!!]CKYB@!3P+AHK(G4GX**YH<TF08($?=L76AK;
MK'4#23E)X<_=;]CG'4F)'2=;=&\O:PLF1,XYY)PY)+T/7PQJL5=*:Q=*&E=6
MN49T]N%S;:S8FY</;MZ]WM8UO1Z:UN#A$G6%Q>'Q!3WCX65LZ[HP#@7>2)LM
M8(7:B#WF^IL>^]B@V+L]^_3E\NC6<283.%G(:HYW:&$R<6RM5[+(S<<&JWFK
M*M=J69D2K72SNEQO8M?<\SA]&?>]*$S7/(W"<(T<PS +F)S&28P9W](MZA+=
MVN2%6^OY+HWO)9QSWX\"?TU\4>*< G/C%#S_T$L.>0",BS 5+'CO<>%Y\$JD
MCX,X\)[!V'..X3].X<3)X"C/(8$*[VGNIE'5W,!,UR6LE)7P4XEZ3GUPJ:K6
MC$#FN;*JK@Q,9;8DM*IL#6UC:!WESP>0U5IC9L'?D+D4A*7,"(RYFLU MP52
M[P5ESIASLRV1,_Z;'\?QI.=\@-U"["IB%K6V13T?! E9XL5!S)*US^(T7,\P
ME;,L]E+I82ZG^7?DWV'I2AHP+TC\:,UCYH6]T9XC=GSVK]?S/8^]7L^SQ?R$
M15%OL9#O6"Q(A!_]P&(\@7'X/_78!0REN(:QOG_HGO$#>>M9IW]@K5/&@#GG
M_>\^O#O/!13+<=8G3XQN4QRLP'-9F$)7A%YJTCP1C(F #9F=/33PSCGG84PD
MHVEM1";+)G#I."1MK:JP4W0$DP\P.M:/LH+K7T=W;5&HE:Q&!\YIF/!N$4,S
M^BHKE>%<M,95TW(+_:7OARL7/BE=MU+GA"50,(!6BDY?V^982+>4N6MM[E9H
MG['=,!QE"Z55)CM@%(0]L*935ZAJIF6.!"/?/4%^UQ6<=3)TT;'7*31:XDI5
MM9#&JG%KY'9Q%]T 7-]CGU#,^H2&9K0LI"$MK"!++NB0L&KIZI9$QK)2]ANY
M<N"XLSB;80473_']O$$_;X'55.2+K&DRWQVB+RGR6-?W51\61GW8LBSZ66:J
M*,C+]\HNYAJE_5H_;M=ZI:B^6,!-T99-CTZ3#EU*O5R@H N'JFI>Q%,_?,:R
MI&)VV25^[YFA&97$AH7()5;?4&\EO^K[X?2WKKN;)>6]/QK9%FY68,=FA+&(
M!3Z^<,@-C</)TW@W'4NBH/=HWT;=#4IB&]HZ3\;\4V?VUJ3883_29M-(HAIG
M_S4^V>)9VM]33(3!7\?'+_ DHR^X+T)_@X]_A(]V\4SPD%+8X*_HU, W9\9;
MFG!+X]%>Y<+W!*.U4=G>T S;F\Z3-RS!:Q:>"C]Y8MG\ :'"9DO3EA/N<YG$
,L]#Y ]C=%7S]"   
 

