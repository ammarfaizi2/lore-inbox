Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTL3CSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbTL3CSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:18:24 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:33476 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264364AbTL3CR4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:17:56 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Dec_30_02_16_40_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031230021640.B5C6BA0C93@merlin.emma.line.org>
Date: Tue, 30 Dec 2003 03:16:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.109, 2003-12-30 03:12:49+01:00, matthias.andree@gmx.de
  Fix --noobfuscate option, some parts spat out obfuscated addresses.
  Add four new addresses.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   17 +++++++++++++++--
# 1 files changed, 15 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.108   -> 1.109  
#	            shortlog	1.81    -> 1.82   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/30	matthias.andree@gmx.de	1.109
# Fix --noobfuscate option, some parts spat out obfuscated addresses.
# Add four new addresses.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Dec 30 03:16:40 2003
+++ b/shortlog	Tue Dec 30 03:16:40 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.208 2003/12/22 01:17:09 emma Exp $
+# $Id: lk-changelog.pl,v 0.210 2003/12/30 02:11:39 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -566,6 +566,7 @@
 'grigouze:noos.fr' => 'Mickaël Grigouze',
 'gronkin:nerdvana.com' => 'George Ronkin',
 'grundler:cup.hp.com' => 'Grant Grundler',
+'grundler:parisc-linux.org' => 'Grant Grundler', # lbdb
 'grundym:us.ibm.com' => 'Michael Grundy',
 'gsromero:alumnos.euitt.upm.es' => 'Guillermo S. Romero',
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
@@ -927,6 +928,7 @@
 'maxk:viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
 'maxk:viper.qualcomm.com' => 'Maksim Krasnyanskiy',
 'mb:ozaba.mine.nu' => 'Magnus Boden',
+'mbp:samba.org' => 'Martin Pool', # lbdb
 'mbligh:aracnet.com' => 'Martin J. Bligh',
 'mcp:linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
@@ -943,6 +945,7 @@
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michaelw:foldr.org' => 'Michael Weber', # google
+'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
 'michel:daenzer.net' => 'Michel Dänzer',
@@ -1073,6 +1076,7 @@
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
+'pavlin:icir.org' => 'Pavlin Radoslavov',
 'pazke:donpac.ru' => 'Andrey Panin',
 'pazke:orbita1.ru' => 'Andrey Panin',
 'pbadari:us.ibm.com' => 'Badari Pulavarty',
@@ -1095,6 +1099,7 @@
 'petkan:mastika.' => 'Petko Manolov',
 'petkan:mastika.dce.bg' => 'Petko Manolov',
 'petkan:mastika.lnxw.com' => 'Petko Manolov',
+'petkan:nucleusys.com' => 'Petko Manolov',
 'petkan:rakia.dce.bg' => 'Petko Manolov',
 'petkan:rakia.hell.org' => 'Petko Manolov',
 'petkan:tequila.dce.bg' => 'Petko Manolov',
@@ -1915,7 +1920,9 @@
 	}
       } else { # $havename
 	# must obfuscate name since it contains an address still
-	$name = obfuscate $name;
+	if ($opt{obfuscate}) {
+	    $name = obfuscate $name;
+	}
 	$author = '<' . $address . '>';
       }
       $first = 1;
@@ -2156,6 +2163,12 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.210  2003/12/30 02:11:39  emma
+# 4 new addresses.
+#
+# Revision 0.209  2003/12/30 02:07:39  emma
+# Bugfix, --noobfuscate wasn't complete.
+#
 # Revision 0.208  2003/12/22 01:17:09  emma
 # Only print ignoremerge warning if ignoremerge is really enabled.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.109
## Wrapped with gzip_uu ##


M'XL(  C@\#\  ]5576_:,!1]QK_B2B"QJ238#B$D$U7;M>M05PTQ];DRB8&(
MQ(YB!ZA*__N<\%G4/G3;RT)"8OO>DWON.7+J\*!X'M12IO4L9LIF(LHY1W7X
M+I4.:M-T94?E<"2E&;95H7A[SG/!D_;5G3FMS<#24B8*F< AT^$,%CQ708W8
MSGY&/V4\J(UN;A]^7(X0ZO?AZXR)*?_%-?3[2,M\P9)(761<3(M8V#IG0J5<
M,SN4Z7H?NZ884_,CU,%=UU]3O^NZ:TZYZX8=PL9>S^,A12=\+C8\7L,XA%(#
M1+Q.=VWP"$770&R"?<!.F]"V@\U#0&C0\<\P"3"&MU'AC("%T17\8PY?40C?
MXA58EI!R/"E4R#0'F>E8BA8HF7+(6*X5J(QID(6Y=E$1L,A4J!17MD&YC"*8
MR"('P9?'*W= */;0\" %LCYX((091N<'[C-3UPEQ-9.Y3N1TP]LE/>QU/-);
M.\3SW?6$^VP2>MAGF$=L'+W3Y5<H3MDZ;"3KF.YAO]NM#+6+>.6GOZ[G/2^=
MU+.UDKMVG8[7JZS4HQ]WD@L6_3^MM-'A)UCY<E6>ULH8:]>D/_#5-2% T*#Z
MKT-C$ 60S*VP8FX0[2QI+0#;E& H%=CUF0:$!(X//$T9W*PR:*"!V^T9D.8T
M+T24F.W.<(U5:"6Q*%:VS*=-Z)]#\]:T6,/M-JC9@CHDXVB,!C[UR_1TG 6*
MI6-V2+DW38L%#,WF=QS?<:OXV!3+DT?^.,[E4@013Y)2O6WJ9A5N;+@JEX_R
M"?8J@(PM3(E!',;YX97#:A)&+)(J80NY:+;*#-^K,KB>,Q&((DQXH9[4X75#
MLR+AG@F95"G7Q">]JK_EW4&U> *?&L81SWOE7S[#,ZJ!.1J"&8?T#Z;8S'Q!
MM1<TH,3M0;?\1/!%K(RAMJ*\J4HEBXGMG/JG?@)@=N$3 .P= UP5TTF\:ITX
F>LF4:&HPK+.$:U["[C] X8R'<U6D_9!P9^)Z/OH-85R>O?T&    
 

