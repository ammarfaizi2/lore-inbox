Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTIVOy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTIVOy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:54:56 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:46313 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263172AbTIVOyf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:54:35 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Sep_22_14_54_32_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030922145432.977BD935C8@merlin.emma.line.org>
Date: Mon, 22 Sep 2003 16:54:32 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
ChangeSet@1.87, 2003-09-22 16:54:09+02:00, matthias.andree@gmx.de
  26 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   40 +++++++++++++++++++++++++++++++++++++++-
# 1 files changed, 39 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.86    -> 1.87   
#	            shortlog	1.59    -> 1.60   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/22	matthias.andree@gmx.de	1.87
# 26 new addresses
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Mon Sep 22 16:54:32 2003
+++ b/shortlog	Mon Sep 22 16:54:32 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.176 2003/09/11 09:11:48 vita Exp $
+# $Id: lk-changelog.pl,v 0.180 2003/09/22 14:13:31 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -166,6 +166,7 @@
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akpm:digeo.com' => 'Andrew Morton',
+'akpm:org.rmk.(none)' => 'Andrew Morton',
 'akpm:osdl.org' => 'Andrew Morton', # guessed
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
@@ -197,6 +198,7 @@
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andrea:suse.de' => 'Andrea Arcangeli',
+'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
 'andrew.wood:ivarch.com' => 'Andrew Wood',
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
@@ -229,6 +231,7 @@
 'aziz:hp.com' => 'Khalid Aziz', # Alan
 'b.zolnierkiewicz:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
 'baccala:vger.freesoft.org' => 'Brent Baccala',
+'baldrick:free.fr' => 'Duncan Sands',
 'baldrick:wanadoo.fr' => 'Duncan Sands',
 'ballabio_dario:emc.com' => 'Dario Ballabio',
 'barrow_dj:yahoo.com' => 'D. J. Barrow',
@@ -302,6 +305,7 @@
 'chad_smith:hp.com' => 'Chad Smith',
 'chadt:sgi.com' => 'Chad Talbott',
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
+'char:cmf.nrl.navy.mil' => 'Chas Williams', # typo ???
 'charles.white:hp.com' => 'Charles White',
 'chas:cmd.nrl.navy.mil' => 'Chas Williams',
 'chas:cmf.nrl.navy.mil' => 'Chas Williams',
@@ -315,6 +319,7 @@
 'christophe:saout.de' => 'Christophe Saout',
 'christopher.leech:intel.com' => 'Christopher Leech',
 'christopher:intel.com' => 'Christopher Goldfarb',
+'chrisw:osdl.org' => 'Chris Wright',
 'chyang:clusterfs.com' => 'Chen Yang',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
@@ -352,8 +357,10 @@
 'dale:farnsworth.org' => 'Dale Farnsworth',
 'dalecki:evision-ventures.com' => 'Martin Dalecki',
 'dalecki:evision.ag' => 'Martin Dalecki',
+'damien.morange:hp.com' => 'Damien Morange',
 'dan.zink:hp.com' => 'Dan Zink',
 'dan:debian.org' => 'Daniel Jacobowitz',
+'dan:reactivated.net' => 'Daniel Drake',
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
 'daniel.ritz:ch.rmk.(none)' => 'Daniel Ritz',
@@ -456,11 +463,14 @@
 'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
 'engebret:us.ibm.com' => 'David Engebretsen',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
+'eranian:hpl.hp.co' => 'Stéphane Eranian', # typo
 'eranian:hpl.hp.com' => 'Stéphane Eranian',
 'eric.piel:bull.net' => 'Eric Piel',
+'eric:lammerts.org' => 'Eric Lammerts',
 'erik:aarg.net' => 'Erik Arneson',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'erikj:subway.americas.sgi.com' => 'Erik Jacobson',
+'erlend-a:us.his.no' => 'Erlend Aasland',
 'ernstp:mac.com' => 'Ernst Persson', # lbdb
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
@@ -756,6 +766,7 @@
 'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
 'komujun:nifty.com' => 'Jun Komuro', # google
 'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
+'kpfleming:cox.net' => 'Kevin P. Fleming',
 'kraxel:bytesex.org' => 'Gerd Knorr',
 'kraxel:suse.de' => 'Gerd Knorr',
 'krishnakumar:naturesoft.net' => 'Krishna Kumar',
@@ -775,6 +786,7 @@
 'laurent:latil.nom.fr' => 'Laurent Latil',
 'lavarre:iomega.com' => 'Pat LaVarre',
 'lawrence:the-penguin.otak.com' => 'Lawrence Walton',
+'lcapitulino:prefeitura.sp.gov.br' => 'Luiz Capitulino',
 'ldb:ldb.ods.org' => 'Luca Barbieri',
 'ldl:aros.net' => 'Lou Langholtz',
 'ldm.adm:hostme.bitkeeper.com' => 'Patrick Mochel', # self
@@ -783,6 +795,7 @@
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
 'len.brown:intel.com' => 'Len Brown',
+'lenb:dhcppc11.' => 'Len Brown',
 'lenb:dhcppc3.' => 'Len Brown',
 'lenb:dhcppc6.' => 'Len Brown',
 'lenehan:twibble.org' => 'Jamie Lenehan',
@@ -790,6 +803,7 @@
 'lethal:unusual.internal.linux-sh.org' => 'Paul Mundt',
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
+'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
@@ -808,6 +822,7 @@
 'lord:jen.americas.sgi.com' => 'Stephen Lord',
 'lord:laptop.americas' => 'Stephen Lord',
 'lord:laptop.americas.sgi.com' => 'Stephen Lord',
+'lord:penguin.americas.sgi.com' => 'Stephen Lord',
 'lord:sgi.com' => 'Stephen Lord',
 'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
@@ -833,6 +848,7 @@
 'marc:mbsi.ca' => 'Marc Boucher',
 'marcel:holtmann.org' => 'Marcel Holtmann', # sent by himself
 'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
+'marcelo.tosatti:cyclades.com.br' => 'Marcelo Tosatti',
 'marcelo:freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo:logos.cnet' => 'Marcelo Tosatti', # guessed
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
@@ -923,6 +939,7 @@
 'moz:compsoc.man.ac.uk' => 'John Levon',
 'mporter:cox.net' => 'Matt Porter',
 'mporter:kernel.crashing.org' => 'Matt Porter',
+'mroos:linux.ee' => 'Meelis Roos',
 'mrr:nexthop.com' => 'Mathew Richardson',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
@@ -947,6 +964,7 @@
 'nicolas.aspert:epfl.ch' => 'Nicolas Aspert',
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
 'nicolas:dupeux.net' => 'Nicolas Dupeux',
+'nikai:nikai.net' => 'Nicolas Kaiser',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
@@ -1028,6 +1046,7 @@
 'petrides:redhat.com' => 'Ernie Petrides',
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
+'piggin:cyberone.com.au' => 'Nick Piggin',
 'pixi:burble.org' => 'Maurice S. Barnum',
 'pkot:linuxnews.pl' => 'Pawel Kot',
 'pkot:ziew.org' => 'Pawel Kot',
@@ -1045,6 +1064,7 @@
 'proski:org.rmk.(none)' => 'Pavel Roskin',
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
+'q:kampsax.dtu.dk' => 'Dennis Jørgensen',
 'qboosh:pld.org.pl' => 'Jakub Bogusz',
 'quade:hsnr.de' => 'Jürgen Quade',
 'quinlan:transmeta.com' => 'Daniel Quinlan',
@@ -1150,6 +1170,7 @@
 'sct:redhat.com' => 'Stephen C. Tweedie',
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
 'sds:tislabs.com' => 'Stephen D. Smalley',
+'sean.mcgoogan:superh.com' => 'Sean McGoogan',
 'seanlkml:rogers.com' => 'Sean Estabrooks',
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'set:pobox.com' => 'Paul Thompson',
@@ -1212,6 +1233,7 @@
 'stevef:steveft21.ltcsamba' => 'Steve French',
 'stewart:inverse.wetlogic.net' => 'Paul Stewart',
 'stewart:wetlogic.net' => 'Paul Stewart',
+'stuart_hayes:dell.com' => 'Stuart Hayes',
 'stuartm:connecttech.com' => 'Stuart MacDonald',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
@@ -1231,6 +1253,7 @@
 'taral:taral.net' => 'Jean-Philippe Sugarbroad', # Muli Ben-Yehuda on lk
 'tausq:debian.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
+'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'tgraf:suug.ch' => 'Thomas Graf',
 'th122948:scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
@@ -1274,6 +1297,7 @@
 'tytso:mit.edu' => "Theodore Y. T'so", # web.mit.edu/tytso/www/home.html
 'tytso:snap.thunk.org' => "Theodore Y. T'so",
 'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
+'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
 'uzi:uzix.org' => 'Joshua Uziel',
 'valdis.kletnieks:vt.edu' => 'Valdis Kletnieks',
@@ -1285,6 +1309,7 @@
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
 'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
+'vinay.nallamothu:gsecone.com' => 'Vinay K. Nallamothu',
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
@@ -1342,6 +1367,7 @@
 'ysato:users.sourceforge.jp' => 'Yoshinori Sato', # lbdb
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',
+'zecke:flint.arm.linux.org.uk' => 'Holger Freyther',
 'zecke:org.rmk.(none)' => 'Holger Freyther',
 'zinx:epicsol.org' => 'Zinx Verituse',
 'zippel:linux-m68k.org' => 'Roman Zippel',
@@ -2036,6 +2062,18 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.180  2003/09/22 14:13:31  vita
+# 8 new addresses
+#
+# Revision 0.179  2003/09/19 09:40:52  vita
+# 6 new addresses
+#
+# Revision 0.178  2003/09/18 10:55:48  vita
+# 4 new addresses
+#
+# Revision 0.177  2003/09/15 13:04:41  vita
+# 8 new addresses
+#
 # Revision 0.176  2003/09/11 09:11:48  vita
 # 4 new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.87
## Wrapped with gzip_uu ##


M'XL( "@-;S\  [U66V_;-A1^CGX%T13(AM:,J(ME$4BO2=,N:1<T[?HXT!(M
M$:9(E:3LN/ ?WC_8XXXH7Y*LW=!M6.(8,<_W'9[SG8M\B#Y:;NA!PYRK!;.8
MJ=)P'ARBU]HZ>E U-[CL/[[7&CX>V\[RXSDWBLOC%Q?P&@T?1DYK:0, 7C%7
MU&C!C:4'!,>[$[=J.3UX?W;^\?+Y^R X.4$O:Z8J?LT=.CD)G#8+)DO[K.6J
MZH3"SC!E&^X8+G2SWF'741A&\$NB.!RG^3K*QVFZYA%/TR(A;)I-,EY$P;U\
MG@UYW'43ASDA\#>.XC7X(WEPB@B>9"B,C\/\.(H0&=,TH6'^*(QH&**O.T6/
M"!J%P0OT'Z?P,BA0-$:*+Q$KX3YKN0TN$(FB++C:BQ>,OO,G"$(6!D_VX=:Z
MX?=BM;4V3NIJ"#4EDS!+,C)9QR3+T_6,YVQ69&'.0EZR:?D-8>YX ;&CB"1I
M$N9K,LG3B6^!+>).!_SK>+Y5_7OQ;(H?K>'_///%'X??7?PX1R/R_U7?2_<S
M&IGE3?\:W4 O;//Z!ZUP2@@BP1O_?H@>OBDIDO-1X8,%C[B5CQ<HQ" XZD7;
M2I-0$M.8H(5P#)W=M.@A^!A/P,D1F[<-U:;"IIGC'Y16_,<C=/($'3WO=5NB
MMQ"K5D>/@9#GGN#/<64T+ TJE..R5VQ'6J%S;SIZC [1@_[@ 8C=UP.VRDR;
MAAO$E3,"!'H3Q7TF1U.HA!'%G,Z@5'AF!F>GG2J80M=PH^T#B,.D!T.VAA;-
M#"LCL6*+%6Z$'!A0-8L^"2D%:ZP/ -:81D^?/@4VR0:V$79)M2TEAK2W/#A$
MGXRH:N=O2OU-)6L$5[C1IM>7UNT^T5-OZM7I30-G/' 4-9P53BR8XR56W&T9
M2G")3@V;>WR2>OTY.!# J5N)_04#^MK]UD)5.3H;[+MD@ A=[XFBH)(UH*>S
M^U3.X!A=;H[]/>-X@$NNRA&CG<6UL%CI+;X_1\^9E:!S3\B&P.;M3/)&J(H6
M^F:?Q@5?"(6N,'HU6#TC\]+*@K7"=5(H35O#9QP^&(9MBRN]P---52\[\06]
MW"$]?Y)Z/E=36M9%VQ:$X T:1'YA]-)W8)9''@?5Q94PY5+KDBZUG%FM&E$8
MO:_/)6#0^0;3<R?$JR:U*>EVY%G3BP@[PE9B3[UVO*WAVDN >F;LHVN8*6#&
ML-,65HN@Q:J0K.2V)^Z2>SN T(<!U-/S:* ;K2V%C+L;S/D&S;F$OH-GM:]4
MGO@!4V+.!/7O>]G?B4)+:.X+)FP_6S".L!-[>"NJ2B@(9\H-3*\/AW4[UAQ=
M><! 27RA/M,Y:UK+8".Z#I?S38-RI2":GWXW%5>6#PR2>LDM9S '1:5U!;UJ
MNY:;^I9B8$5OBW-O]31X='B:ZYAQO]9LQ2TMN92W5>Y-Z'5O&BBQ[U,'R#OE
M^" :[>H5NJY%TVSRB#(_:YV90EA+44)MYI0KV<_O7K./O1G6@3</O(G/'SJ8
MK6!U2!@?\-W1RO)BH]U _:5'H N,WNU WD&<^+R^\&+.Z0RJZ3 S#1[*VF_1
M;B/F:RTK6'2O#%^Y>BA8%,8P6%'_Y0QFR JM-IOZJZO:[VK 3NX]4P[O\;-\
MSR<Y"G.:A!2*MN7??R;]B3^YQ8?X@)S29++C)W_'SV[QH=-C&B8T^:OX=U\Q
7BQIDM%USDI)Q3G@<!G\ +<JCJM\*    
 

