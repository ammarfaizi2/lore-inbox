Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTGFV3y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 17:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTGFV3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 17:29:54 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:15876 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263749AbTGFV3v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 17:29:51 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sun_Jul__6_21_44_21_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030706214421.A138F613DF@merlin.emma.line.org>
Date: Sun,  6 Jul 2003 23:44:21 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
5 new addresses (upstream update 0.140 -> 0.142)
"Bash Marcelo unless he updates this week." edition.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   13 ++++++++++++-
# 1 files changed, 12 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.65    -> 1.66   
#	            shortlog	1.39    -> 1.40   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/06	matthias.andree@gmx.de	1.66
# Add 5 new addresses. (Upstream update 0.140 -> 0.142)
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sun Jul  6 23:44:20 2003
+++ b/shortlog	Sun Jul  6 23:44:20 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.140 2003/06/30 08:22:08 vita Exp $
+# $Id: lk-changelog.pl,v 0.142 2003/07/03 12:29:27 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -70,6 +70,7 @@
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
 [ 'kuznet@[^.]+\.inr.ac.ru' => 'Alexey Kuznetsov', ],
 [ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
+[ 'torvalds@([^.]+\.)?osdl\.org' => 'Linus Torvalds', ],
 [ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' => '~~~~~~~~' ]);
 
 sub obfuscate(@) {
@@ -149,6 +150,7 @@
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akpm:digeo.com' => 'Andrew Morton',
+'akpm:osdl.org' => 'Andrew Morton', # guessed
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
@@ -267,6 +269,7 @@
 'ch:com.rmk.(none)' => 'Christopher Hoover',
 'ch:hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'ch:murgatroid.com' => 'Christopher Hoover',
+'chad_smith:hp.com' => 'Chad Smith',
 'chadt:sgi.com' => 'Chad Talbott',
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'charles.white:hp.com' => 'Charles White',
@@ -516,6 +519,7 @@
 'hunold:convergence.de' => 'Michael Hunold',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
+'ilmari:ilmari.org' => 'Dagfinn Ilmari Mannsåker',
 'info:usblcd.de' => 'Adams IT Services',
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
@@ -563,6 +567,7 @@
 'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
 'jeffs:accelent.com' => 'Jeff Sutherland', # lbdb
+'jejb:jet.(none)' => 'James Bottomley', # wild guess
 'jejb:malley.(none)' => 'James Bottomley',
 'jejb:mulgrave.(none)' => 'James Bottomley', # from shortlog
 'jejb:raven.il.steeleye.com' => 'James Bottomley',
@@ -1764,6 +1769,12 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.142  2003/07/03 12:29:27  vita
+# 3 new addresses
+#
+# Revision 0.141  2003/07/01 09:11:52  vita
+# 2 new addresses
+#
 # Revision 0.140  2003/06/30 08:22:08  vita
 # 3 new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.66
## Wrapped with gzip_uu ##


begin 600 bkpatch17497
M'XL(`#68"#\``\U46T_;,!A]KG_%)Q6I($AJ.[<F4AE7;1V@(1A/P"8W,6UH
M$D>Q>T'*W]W_F)-`NW:@:9>')5$26^=\_L[QD=MP(WD1M%*FU#AFTF195'".
MVO!!2!6T1NG"C*KAE1!ZV)53R;L37F0\Z1Z=Z<=H!H82(I%(`R^9"L<PXX4,
M6L2TEC/J*>=!Z^KT_<WYX15"_3X<CUDVXM=<0;^/E"AF+(GD0<ZST33.3%6P
M3*9<,3,4:;G$EA1CJF]"+>PZ?DE]UW%*3KGCA#9A0Z_G\9"B#3T'C8[U,KJ`
MA7'/(M@K,?%H#YT`,5T7L-7%7A>[0*W`IH'M[6(:8`RO%X5=`@9&1_"/)1RC
M$`ZC"!S(^!Q8I)>4DDL3MF]RJ0K.4ICF$5,<L$EL#,9^_4-WT!D0S\+H<N4P
M,G[S0@@SC/97FL8BY1N"Y%@4*A&C1H]#>MBS/=(K+>+Y3OG`??80>MAGF$=L
M&+WAWEH5"WO8I5J#;9>DY]BXSLD+8BTF?]W/6Q%9[^<E(7;I.+I.G1#M]69"
M[%\EA()!_K.(U/Y^`J.8+ZK'6.C`O(C_@[R<$`($#>IW&[8&40#)Q`AK1;JB
MF2=[LV9UJ)RM_;.`T(#Z`?5@%BL&IXL<MM#`H[K&+726;FW??C'O=^_,G7="
M1LF=*8I1!_K[T#F/LZF$S\^XSA[<[^D6G*J'#IOD:5#A5_##:E?F<*%%BDRC
MVS":5HY%:$!=OR+I?J.O,HW5.!CGU9XT1+TQ$5Q7TQV]@(Y6A8V3E!5QT'Q6
MBYRPT4.<93"HY^&"99G\ID_)FNDZ%?.1/PZ#1Z[,[4QD?*?A?60IEW`DE!)I
MPI_J]N9Q$C4]:EF>/IK<ZBCFLUC&(GMV\U4[:S\UUEI/!FIO\LD/?`+8#P@)
@'+KDTY_XRP,]'/-P(J=IG_=L;^@X/OH.[?I,Q$T&````
`
end

