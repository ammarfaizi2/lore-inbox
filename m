Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbTF3ISZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 04:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbTF3ISZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 04:18:25 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5644 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265460AbTF3ISD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 04:18:03 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Jun_30_08_32_21_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030630083221.690968E7E9@merlin.emma.line.org>
Date: Mon, 30 Jun 2003 10:32:21 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
15 new address -> name mappings (courtesy of Vitezslav Samel again)

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   26 +++++++++++++++++++++++++-
# 1 files changed, 25 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.64    -> 1.65   
#	            shortlog	1.38    -> 1.39   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/30	matthias.andree@gmx.de	1.65
# 15 new addresses (upstream update 0.137 -> 0.140)
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Mon Jun 30 10:32:20 2003
+++ b/shortlog	Mon Jun 30 10:32:20 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.137 2003/06/24 08:59:08 vita Exp $
+# $Id: lk-changelog.pl,v 0.140 2003/06/30 08:22:08 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -112,6 +112,7 @@
 
 my %addresses = (
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
+'abbotti:mev.co.uk' => 'Ian Abbott',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
 'abslucio:terra.com.br' => 'Lucio Maciel',
 'ac9410:attbi.com' => 'Albert Cranford',
@@ -222,6 +223,7 @@
 'bergner:cannon.rchland.ibm.com' => 'Peter Bergner',
 'bergner:vnet.ibm.com' => 'Peter Bergner',
 'bernhard.kaindl:gmx.de' => 'Bernhard Kaindl',
+'bernie:develer.com' => 'Bernardo Innocenti',
 'berny.f:aon.at' => 'Bernhard Fischer',
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
@@ -265,6 +267,7 @@
 'ch:com.rmk.(none)' => 'Christopher Hoover',
 'ch:hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'ch:murgatroid.com' => 'Christopher Hoover',
+'chadt:sgi.com' => 'Chad Talbott',
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'charles.white:hp.com' => 'Charles White',
 'chas:cmd.nrl.navy.mil' => 'Chas Williams',
@@ -335,6 +338,7 @@
 'david-b:pacbell.net' => 'David Brownell',
 'david-b:packbell.net' => 'David Brownell',
 'david.nelson:pobox.com' => 'David Nelson',
+'david:csse.uwa.edu.au' => 'David Glance',
 'david:gibson.dropbear.id.au' => 'David Gibson',
 'david_jeffery:adaptec.com' => 'David Jeffery',
 'davidel:xmailserver.org' => 'Davide Libenzi',
@@ -469,6 +473,7 @@
 'greg:kroah.com' => 'Greg Kroah-Hartman',
 'greg:soap.kroah.net' => 'Greg Kroah-Hartman',
 'gregkh:kernel.bkbits.net' => 'Greg Kroah-Hartman',
+'grigouze:noos.fr' => 'Mickaël Grigouze',
 'gronkin:nerdvana.com' => 'George Ronkin',
 'grundler:cup.hp.com' => 'Grant Grundler',
 'grundym:us.ibm.com' => 'Michael Grundy',
@@ -477,6 +482,7 @@
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
+'hall:vdata.com' => 'Jeff Hall',
 'hannal:us.ibm.com' => 'Hanna V. Linder',
 'hanno:gmx.de' => 'Hanno Böck',
 'harald:gnumonks.org' => 'Harald Welte',
@@ -495,6 +501,7 @@
 'hch:sgi.com' => 'Christoph Hellwig',
 'heiko.carstens:de.ibm.com' => 'Heiko Carstens',
 'helgaas:fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
+'henk:god.dyndns.org' => 'Henk Vergonet',
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
 'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
 'henrique:cyclades.com' => 'Henrique Gobbi',
@@ -617,6 +624,7 @@
 'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
 'jtyner:cs.ucr.edu' => 'John Tyner',
+'judd:jpilot.org' => 'Judd Montgomery',
 'jun.nakajima:intel.com' => 'Jun Nakajima',
 'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
@@ -658,6 +666,7 @@
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
 'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
 'komujun:nifty.com' => 'Jun Komuro', # google
+'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
 'kraxel:bytesex.org' => 'Gerd Knorr',
 'kraxel:suse.de' => 'Gerd Knorr',
 'krkumar:us.ibm.com' => 'Krishna Kumar',
@@ -696,6 +705,7 @@
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
+'lord:jen.americas.sgi.com' => 'Stephen Lord',
 'lord:sgi.com' => 'Stephen Lord',
 'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
@@ -751,6 +761,7 @@
 'mdiehl:mdiehl.de' => 'Martin Diehl',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
+'mgreer:mivsta.com' => 'Mark A. Greer', # typo
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
@@ -900,6 +911,7 @@
 'proski:gnu.org' => 'Pavel Roskin',
 'proski:org.rmk.(none)' => 'Pavel Roskin',
 'pwaechtler:mac.com' => 'Peter Wächtler',
+'qboosh:pld.org.pl' => 'Jakub Bogusz',
 'quinlan:transmeta.com' => 'Daniel Quinlan',
 'quintela:mandrakesoft.com' => 'Juan Quintela',
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
@@ -996,6 +1008,7 @@
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'sfbest:us.ibm.com' => 'Steve Best',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
+'sfrost:snowman.net' => 'Stephen Frost',
 'shaggy:austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:kleikamp.austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
@@ -1084,6 +1097,7 @@
 'tomlins:cam.org' => 'Ed Tomlinson',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
+'tonyb:cybernetics.com' => 'Tony Battersby',
 'torben.mathiasen:hp.com' => 'Torben Mathiasen',
 'torvalds:linux.local' => 'Linus Torvalds',
 'trevor.pering:intel.com' => 'Trevor Pering',
@@ -1133,6 +1147,7 @@
 'whydoubt:yahoo.com' => 'Jeff Smith',
 'will:sowerbutts.com' => 'William R. Sowerbutts',
 'willschm:us.ibm.com' => 'Will Schmidt',
+'willy:org.rmk.(none)' => 'Matthew Wilcox',
 'willy:debian.org' => 'Matthew Wilcox',
 'willy:fc.hp.com' => 'Matthew Wilcox',
 'willy:w.ods.org' => 'Willy Tarreau',
@@ -1749,6 +1764,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.140  2003/06/30 08:22:08  vita
+# 3 new addresses
+#
+# Revision 0.139  2003/06/27 08:22:15  vita
+# 10 new addresses
+#
+# Revision 0.138  2003/06/25 08:55:55  vita
+# 2 new addresses
+#
 # Revision 0.137  2003/06/24 08:59:08  vita
 # 3 new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.65
## Wrapped with gzip_uu ##


begin 600 bkpatch5423
M'XL(`)3U_SX``\U5VV[;.!!]CKYB@!1(B\8**5F21<!!<^DF;AJT2-O=9UJD
M9542Z14I.R[\Q_L3.Y2<N$Y;%-W=A[4%P]*<<SAS-$,>PB<C&W90<VOG!3<^
M5Z*1TCN$:VTL.\CK>U^XVSNM\?;$M$:>E+)1LCHYO\%KT-\,K-:5\1#XGMML
M#DO9&'9`_?#QB5TO)#NX>WWUZ>W9G>>-QW`QYRJ7'Z2%\=BSNEGR2IA7"ZGR
MME"^;;@RM;3<SW2]><1N`D("_-(@)'&4;H(TCJ*-#&0494/*I\DHD5G@/:GG
M55_'O@P*!$-*\4^X(30)0N\2J!]'0,(3$I^$!"AA(64D>4D"1@A\7Q1>4A@0
M[QS^XQ(NO`QH!$JN@`M<SQAIX'F[,+:1O(9V(;B50'P:)C`X=7^&Y(5W`UC)
MR'N_<]<;_.+'\P@GWNFNGKFNY9-BS%PWMM)Y7TM$1R09)G2T"6F21IN93/DL
M2TC*B11\*G[@W)X*>A$2,@HI&6ZB"'6Z'GE`[+7(O\[G1^WQ))]M=U#,A\9Q
MUQUA^DUW#'_2'4$$`_K_:8_>VW<P:%;W[AK<8[,\%/X/>N624J#>I/L]A&<3
MP:`J!UE7#2KZB^IXV:\.SM6M=V3$`G1M!,O"<GA]OX!G3F.((D=\.M76%JR6
M2W3&;\LC&)_"T80K..M"1\?>)`@Z[!1WGT(R(9>RDHTSL@>?XW/>"`T3I70F
ME2TZ4IPX$B8G+#-YL<.C^P(^\NI!/@P[I.#+0K`,O?7;%?>E:'W>]HQ+%X*K
MBJM,.@:VFV/D39'K]HMD2FOCSYH>?%MD)?^K@JMMM">DCC#G5<66^++X+ILW
M<C:#:PQTN+1+92Y5R7(M?+%60AE?-WD/OL8`_"Z;7"O9Y1[33OAS*P3[O"@J
M;7?@-_@0;K6R.<Y0L^[@,7'P<I$-6C-%)QF^.&[1^*+-7,D]\T8N"P47;K<O
M95=`G(X<L=(-KB.5SU&QR'``]IS]8.4"<X>W"'.L)`H=J\YQ1AI6%TOS=>6W
MO"GAS$>C,'IT#(?NW-#>)"6!8_TY15?G;%$)5Q+VUK8J7K93.-=Y:[ZX-=(^
M,S-KW"%FE%[57/G.GKV4?G-AAZ=D%#N"U6H]9=G:=96T169VB7W$$)SCB./!
M-NU\HS2,'&E55-6:N72:NO2?*WP-+QZ*P1T!Y_./HLKT?<=)(@JI.T[135-H
MM9V,[XY&-QN(#?>'W#M\PL<]Z9$?)%L^;@T/?$I^)C#Z2B!R`E&$UZ-`\`W_
9\53/YC(K35N/:1#/(B*(]S=(B,8(4@@`````
`
end

