Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTLTXg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 18:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTLTXg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 18:36:27 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2734 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261807AbTLTXgW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 18:36:22 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Dec_20_23_36_11_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031220233611.A60CF96FFD@merlin.emma.line.org>
Date: Sun, 21 Dec 2003 00:36:11 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.103, 2003-12-06 17:40:47+01:00, matthias.andree@gmx.de
  Add two addresses.
  Support parsing the output of bk changes -L and bk changes -R.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   25 +++++++++++++++++++++----
# 1 files changed, 21 insertions(+), 4 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.104   -> 1.105  
#	            shortlog	1.77    -> 1.78   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/21	matthias.andree@gmx.de	1.105
# Marcus Alanen: Fix Kai Mäkisara's name spelling.
# Vitezslav Samel: Eight new mappings.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sun Dec 21 00:36:10 2003
+++ b/shortlog	Sun Dec 21 00:36:10 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.203 2003/12/06 16:40:13 emma Exp $
+# $Id: lk-changelog.pl,v 0.206 2003/12/20 23:32:45 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -234,6 +234,7 @@
 'aschultz:warp10.net' => 'Andreas Schultz',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
+'aspicht:arkeia.com' => 'Arnaud Spicht',
 'atulm:lsil.com' => 'Atul Mukker',
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
@@ -309,6 +310,9 @@
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'car.busse:gmx.de' => 'Carsten Busse',	# verified by Greg KH
 'cat:zip.com.au' => 'CaT',
+'cattelan:lupo.thebarn.com' => 'Russell Cattelan',
+'cattelan:naboo.americas.sgi.com' => 'Russell Cattelan',
+'cattelan:naboo.eagan' => 'Russell Cattelan',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'ccaputo:alt.net' => 'Chris Caputo',
 'ccheney:cheney.cx' => 'Christopher L. Cheney',
@@ -740,7 +744,8 @@
 'jsimmons:kozmo.(none)' => 'James Simmons',
 'jsimmons:maxwell.earthlink.net' => 'James Simmons',
 'jsimmons:transvirtual.com' => 'James Simmons',
-'jsm:udlkern.fc.hp.com' => 'John Marvin',
+'jsm:fc.hp.com' => 'John S. Marvin',
+'jsm:udlkern.fc.hp.com' => 'John S. Marvin',
 'jsun:mvista.com' => 'Jun Sun',
 'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
@@ -754,7 +759,7 @@
 'kaber:trash.net' => 'Patrick McHardy',
 'kadlec:blackhole.kfki.hu' => 'Jozsef Kadlecsik',
 'kai-germaschewski:uiowa.edu' => 'Kai Germaschewski',
-'kai.makisara:kolumbus.fi' => 'Kai Makisara',
+'kai.makisara:kolumbus.fi' => 'Kai Mäkisara',
 'kai.reichert:udo.edu' => 'Kai Reichert',
 'kai:chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai:germaschewski.name' => 'Kai Germaschewski',
@@ -813,6 +818,7 @@
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
 'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess
 'kyle:debian.org' => 'Kyle McMartin',
+'kyle:engsoc.carleton.ca' => 'Kyle McMartin',
 'l.s.r:web.de' => 'René Scharfe',
 'ladis:psi.cz' => 'Ladislav Michl',
 'laforge:gnumonks.org' => 'Harald Welte',
@@ -873,7 +879,7 @@
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
-'makisara:abies.metla.fi' => 'Kai Makisara',
+'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
 'manand:us.ibm.com' => 'Mala Anand',
@@ -998,6 +1004,7 @@
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
 'n0ano:n0ano.com' => 'Don Dugger',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
+'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
 'neilb:cse.unsw.edu.au' => 'Neil Brown',
 'neilt:slimy.greenend.org.uk' => 'Neil Turton',
@@ -1412,6 +1419,7 @@
 'wensong:linux-vs.org' => 'Wensong Zhang',
 'wes:infosink.com' => 'Wes Schreiner',
 'wesolows:foobazco.org' => 'Keith M. Wesolowski',
+'wessmith:sgi.com' => 'Wesley Smith',
 'wg:malloc.de' => 'Wolfram Gloger', # lbdb
 'whitney:math.berkeley.edu' => 'Wayne Whitney',
 'whydoubt:yahoo.com' => 'Jeff Smith',
@@ -2142,6 +2150,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.206  2003/12/20 23:32:45  emma
+# Resolve conflict with Linus' version.
+#
+# Revision 0.205  2003/12/11 14:08:38  vita
+# new translations to cover 2.4.24-pre1
+#
+# Revision 0.204  2003/12/07 18:30:25  emma
+# Fix Kai Mäkisara's name. Patch by Marcus Alanen.
+#
 # Revision 0.203  2003/12/06 16:40:13  emma
 # Add two addresses, three still nknown since 2.4.23.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.103
## Wrapped with gzip_uu ##


M'XL( .O<Y#\  ]55VV[B,!!]KK]B)"H!"PFV<X-H0;VJBUII*ZH^]2*9Q)"(
M)(YB<UDU_/L:6.A"6ZWV\K*.E<2C\9R9,R=.!>XE+_RCE"D5Q4R:+ L+SE$%
MO@BI_*-QNC##U7(@A%ZVY%3RUH07&4]:9]=Z&IN%H81()-*.MTP%$<QX(?TC
M8EH[B_J6<_]H<'EU?W,Z0*C;A?.(96-^QQ5TNTB)8L:24)[D/!M/X\Q4!<MD
MRA4S Y&6.]^28DSU1:B%7:=3TH[K."6GW'$"F["AU_9X0-%!/2>;.O;#6(10
MCQ!,;:?4\3!!%T!,@BW 5HO0%G:!>+Z-?=MK8.)C#.]'A08! Z,S^,<UG*, 
M3L,0U%P "S6@E%R:VG@WS7-1*,A9(>-L#"KB(*8JGRH0(QA.(%@C23!N0&>Z
M9QF8Z!H()13=OC8 &;\Y$,(,H]YKQ9%(^4&Y,M(Y)F*\J=8A;>S9'FF7%O$Z
M3CGB'38*/-QAF(=L&'[ [5X42S?)):Z-;;>T<:>#US+:>NRIZ*_S^4A!^_EL
M!627Q*.XO1:0Y[[1C_LK_6 PZ/\DH W[7\$HYHO5-!9:3EMJ_D!-%X0 0?WU
MO0+'_="'9&)L,'5$,T^:,\ FU=_FBO<MN^Z*76(!3U,&EXL<CE'?I5@'J<8B
MQ#CTHWS%7!6Z/:A>:3(57!73+$QX46U"!9)A.-2PV/56>W(V2^+,CX.X,$4Q
MWNRZ71MAP$(A$S83L]>-%Z3=]M9Y;YZ@QQ)X(N,1U-*7Y\^UA^?>4Z/>6X(H
M0!MV#3QYP$;'?&HT'^6G!T._^PW8K&J/=XWZL@XOJ$^)3<%=G;U\%LM89#\8
M>)>"-0?:]TV_F[J[6FL@59PDD$TR,<] =SW@0$W;I):)*H<8]!##LGT+[S"V
M\OE)%B_&36D,EEL5C42AM0ZU>:PB+6]/GX_ 1HH7V[SJ*]3=OR&(>#"1T[3+
/G9"'!#/T'1#_P["8!@  
 

