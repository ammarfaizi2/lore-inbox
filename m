Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbTH2NAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 09:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbTH2NAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 09:00:52 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:48580 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261154AbTH2NAb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 09:00:31 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Aug_29_13_00_28_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20030829130028.C0C3993116@merlin.emma.line.org>
Date: Fri, 29 Aug 2003 15:00:28 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
  Fix merge error that resulted in duplicate entry.
  Add one new address.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    7 +++++--
# 1 files changed, 5 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.80    -> 1.81   
#	            shortlog	1.53    -> 1.54   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/29	matthias.andree@gmx.de	1.81
# Fix merge error that resulted in duplicate entry.
# Add one new address.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Fri Aug 29 15:00:28 2003
+++ b/shortlog	Fri Aug 29 15:00:28 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.164 2003/08/27 13:34:29 vita Exp $
+# $Id: lk-changelog.pl,v 0.165 2003/08/29 11:56:43 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -327,6 +327,7 @@
 'ctindel:cup.hp.com' => 'Chad N. Tindel',
 'cubic:miee.ru' => 'Ruslan U. Zakirov',
 'cw:f00f.org' => 'Chris Wedgwood',
+'cw:sgi.com' => 'Chris Wedgwood',
 'cweidema:indiana.edu' => 'Christoph Weidemann',
 'cwf:sgi.com' => 'Charles Fumuso',
 'cyeoh:samba.org' => 'Christopher Yeoh',
@@ -1227,7 +1228,6 @@
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
 'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
-'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
 'vnuorval:tcs.hut.fi' => 'Ville Nuorvala',
 'vojta:math.berkeley.edu' => 'Paul Vojta',
 'vojtech:kernel.bkbits.net' => 'Vojtech Pavlik',
@@ -1877,6 +1877,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.165  2003/08/29 11:56:43  vita
+# 1 new address
+#
 # Revision 0.164  2003/08/27 13:34:29  vita
 # 1 new address
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.81
## Wrapped with gzip_uu ##


M'XL( &Q.3S\  \U4:VO;,!3]'/V*"RGD0VM'LJWX 2E]KBL=K&24?5:M6]O4
MMH*D/ K^\9.3M5VREK''A]G"<.VK<^XY/F@(=P9U-FB$M64EC"]:J1')$#XJ
M8[-!T:Q]V9<SI5PY-@N#XT?4+=;CLQNWO&WA6:5J0USCK;!Y"4O4)ALP/WQY
M8Y_FF UFEU=WGTYGA$RG<%Z*ML O:&$Z)5;II:BE.9EC6RRJUK=:M*9!*_Q<
M-=U+;Q=0&KB;!2&=\+0+T@GG'0;(>1XQ<1\G,>8!V=-SLM6Q"Q/2)$C8)$@<
M@,-C*;D YB<,:#BFR3A(@4493[.0'=(@HQ3>!H5#!AXE9_"/)9R3'#Y4:VA0
M%PBHM=)@2V%!HUG4%B54+<C%O*YR85U#:_63[_:<2@FJ16AQ!4*Z08WQR0TX
M@9S<OII.O-^\"*&"DN-7F:5J<$^C*96VM2JV$CE+:!S%+.E"%J>\>\!4/.0Q
M305%*>[E.X;NH/0_*64!3T/J4"B/-]%Y[MA)SE_/\UYJ]N?9AB;J0AJ%?!,:
M'OT4&OJ+T'#P@O\^-%O'/X.G5^M^>6L7H6<[_B!!%XP!(]>;YQ .KF4&]:.7
M;T0Z1']>'RV!^FS"H??ZV5&6\4D6A;"LK(#+]1P.R'78?R"C?)69HNJ]&L'T
M&$;GI:X,?$59K)22HR-'Z1S;D"9Q"OUY-,-E92K5?B=ZDVE#Y7K9CXZ0X>L!
7EY>8/YI%,\WC/D(T)-\ ZC_/(DL%    
 

