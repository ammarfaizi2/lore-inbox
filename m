Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSDETdo>; Fri, 5 Apr 2002 14:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313309AbSDETdf>; Fri, 5 Apr 2002 14:33:35 -0500
Received: from backtop.namesys.com ([212.16.7.71]:28289 "EHLO
	bitshadow.namesys.com") by vger.kernel.org with ESMTP
	id <S312983AbSDETda>; Fri, 5 Apr 2002 14:33:30 -0500
Date: Sat, 6 Apr 2002 00:30:52 +0400
Message-Id: <200204052030.g35KUqE02899@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: ReiserFS Bug Fixes 5 of 6 (Please apply all 6) [PATCH]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apologies for forgetting magic incantations of "please apply" and
"[PATCH]" in previous 4 members of set.  Hopefully these will penetrate
your mail defenses anyway.:-)

This changeset is changing some documentation bits for reiserfs.
You can get it by piping this message through bk receive

Diffstat:
 Documentation/Changes |    2 +-
 fs/Config.help        |   12 ++++++------
 fs/Config.in          |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

Patch and Changelog:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.589   -> 1.590  
#	        fs/Config.in	1.18    -> 1.19   
#	      fs/Config.help	1.4     -> 1.5    
#	Documentation/Changes	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/05	green@angband.namesys.com	1.590
# Config.in:
#   Rename REISERFS_CHECK option to show it's true meaning
# Config.help:
#   Rewrite REISERFS_PROC_INFO comment to make it more clear
# Changes:
#   Corrected URL to latest reiserfsprogs.
# --------------------------------------------
#
diff -Nru a/Documentation/Changes b/Documentation/Changes
--- a/Documentation/Changes	Fri Apr  5 14:19:48 2002
+++ b/Documentation/Changes	Fri Apr  5 14:19:48 2002
@@ -320,7 +320,7 @@
 
 Reiserfsprogs
 -------------
-o  <ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.x.0b.tar.gz>
+o  <ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.x.1b.tar.gz>
 
 LVM toolset
 -----------
diff -Nru a/fs/Config.help b/fs/Config.help
--- a/fs/Config.help	Fri Apr  5 14:19:48 2002
+++ b/fs/Config.help	Fri Apr  5 14:19:48 2002
@@ -59,12 +59,12 @@
   everyone should say N.
 
 CONFIG_REISERFS_PROC_INFO
-  Create under /proc/fs/reiserfs hierarchy of files, displaying
-  various ReiserFS statistics and internal data on the expense of
-  making your kernel or module slightly larger (+8 KB).  This also
-  increases amount of kernel memory required for each mount.  Almost
-  everyone but ReiserFS developers and people fine-tuning reiserfs or
-  tracing problems should say N.
+  Create under /proc/fs/reiserfs a hierarchy of files, displaying
+  various ReiserFS statistics and internal data at the expense of
+  making your kernel or module slightly larger (+8 KB). This also
+  increases the amount of kernel memory required for each mount.
+  Almost everyone but ReiserFS developers and people fine-tuning
+  reiserfs or tracing problems should say N.
 
 CONFIG_EXT2_FS
   This is the de facto standard Linux file system (method to organize
diff -Nru a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Fri Apr  5 14:19:48 2002
+++ b/fs/Config.in	Fri Apr  5 14:19:48 2002
@@ -9,7 +9,7 @@
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
 
 tristate 'Reiserfs support' CONFIG_REISERFS_FS
-dep_mbool '  Have reiserfs do extra internal checking' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
+dep_mbool '  Enable reiserfs debug mode' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
 dep_mbool '  Stats in /proc/fs/reiserfs' CONFIG_REISERFS_PROC_INFO $CONFIG_REISERFS_FS
 
 dep_tristate 'ADFS file system support' CONFIG_ADFS_FS $CONFIG_EXPERIMENTAL


BK changeset:

This BitKeeper patch contains the following changesets:
1.590
## Wrapped with gzip_uu ##


begin 664 bkpatch2373
M'XL(`%.YK3P``\56:V^C1A3]''[%E;926J6&&=ZVFE5VG60WRBJ)G.9S-(:+
M30,S=`;BN.+']X+SM)S'IKLJMD#`S)ES[]QS+A_@PJ`>;<TTHK0^P%=EZM&6
MD+.ID*DM18EF:>Q$E?1NHA2]<^:J1*<?[TRO+A=*7SD:<T+Q!D4NFYN!:P<6
M#3\3=3*':]1FM,5M[_Y)O:QPM#4Y^'+Q[=/$LG9W83RG!?$<:]C=M6JEKT61
MFCU1SPLE[5H+:4JL1<>BO1_:NHRY]`MXY+$@;'G(_*A->,JY\#FFS/7CT+=Z
MGGL;XEE'\EG`AH'/HY9S+XJM?>!V,&3`7(?Y#@N`>Z,@&@5LA_DCQN!98-CQ
M8,"LS_!C`QE;"8R5S/*9G<L1W0!,L%L6)@='YP>3P_/+\=>#\3&HJLZ5I-7!
MS-4"\GK;0*T;A!*%S.7L`6>.176'M-!Y_0CJ;'(ZOCPZ.3P%XEJBK#N\4EPA
MX4&I-$)2H-`=5A^'6>&,E=:8U)C"Q>1;-Z40-9H:5O61F4JKF;&M8^!^Y,?6
MV</.6X/O/"R+"69]?"7+^RII.OJBRXESR_51QGWFA2UCPV'<^BP;BBP*@X0E
MD1B*YW?X)=15&06!VW(WY$,B6'5%OYE=9IQ'6W%'*V2,1]RC0O!9V$:<8S#U
MP@2GL:`"?8'6)K@5GX@1GX!Q_FK"'C!R^;@RAU[<NIX7LM;C09QET=3E0S8-
MX_!-A.[`;NEX;NL%/`Y[]3^EW5G`#TZ9E>@](ZIGYWLD.3HH0NZ'C*^DORY\
MYKXN_!`&X4\1_KOU24KKM_T4!GK1_TDY9VLI?X?V]D,70NLHC.A,LM=(.H=&
MIJC!(9$G#JUP)WH0,,]1"YW,EZ`RR/("S>^0YJ8JQ+)S)(!KH7/5&`JTFW-X
M#J83EZGSA*;+%')9HY:B@%34`@2%.T?`FPJE0<(D!`J>H&"I&@U7-!8+4)I2
MD38%@BGRV;PNEN1'>D8<?]V)X?CS;S;\.<]I@<(H0LAE0G$8-#VX*%5#:26^
MMV@E4EZ79&5_-[DFA\L('@7ULWZ@30"?BI*Z)R"UO*62"-.F?@@HI<>%JJ@;
M]@%5J"HBEN42!W4C5UFXSQA!4]$D74"4S6F!I>G<O"E2,&())W8OG(TV]'H+
M_0^>:*7B&O_:,XU!.\67?=#C0[=38^>#JW;*AT]%%8R"-XB*PX#_I&[ZUF;5
M._F:A#;&_AXE>:X'W#I:713`'UE=C1R'SH_SX%3-U'G"[.G=P+-O;#ZU:Z'M
MV3\?UXPUEZ^7Q?<[OY4NRH6[E\M,BQ1%:BL]VP#C<9?'+/#CU@N#T-M8"M'(
M^S]+X9U?4L>PZF+/NFLNWU,1W.T*HC^G6%V64Z4*V`8XD(*LX,$E4IPVL\[B
K<!O&IR>'1U\NUR+X9?WQX?G#EWDRQ^3*-.4N0Y<-W2RV_@62<+6[#0P`````
`
end
