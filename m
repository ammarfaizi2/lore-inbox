Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261811AbTCGWH4>; Fri, 7 Mar 2003 17:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261813AbTCGWH4>; Fri, 7 Mar 2003 17:07:56 -0500
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:19075 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S261811AbTCGWHx>; Fri, 7 Mar 2003 17:07:53 -0500
To: marcelo@connectiva.com.br
Subject: [PATCH] Add COMPATIBLE_IOCTL for AutoFS4 and SPARC64
Cc: linux-kernel@vger.kernel.org
Message-Id: <E18rQ9n-0007ID-00@pegasus.local>
From: Marcel Holtmann <marcel@holtmann.org>
Date: Fri, 07 Mar 2003 23:17:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1010, 2003-03-07 23:06:07+01:00, marcel@holtmann.org
  [PATCH] Add COMPATIBLE_IOCTL for AutoFS4 and SPARC64
  
  This patch adds the missing COMPATIBLE_IOCTL for the
  AUTOFS_IOC_EXPIRE_MULTI on SPARC64.


 ioctl32.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/arch/sparc64/kernel/ioctl32.c b/arch/sparc64/kernel/ioctl32.c
--- a/arch/sparc64/kernel/ioctl32.c	Fri Mar  7 23:09:18 2003
+++ b/arch/sparc64/kernel/ioctl32.c	Fri Mar  7 23:09:18 2003
@@ -37,6 +37,7 @@
 #include <linux/cdrom.h>
 #include <linux/loop.h>
 #include <linux/auto_fs.h>
+#include <linux/auto_fs4.h>
 #include <linux/devfs_fs.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
@@ -4881,6 +4882,7 @@
 COMPATIBLE_IOCTL(AUTOFS_IOC_CATATONIC)
 COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOVER)
 COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE)
+COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE_MULTI)
 /* DEVFS */
 COMPATIBLE_IOCTL(DEVFSDIOC_GET_PROTO_REV)
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch27905
M'XL(`(X8:3X``[54;6O;,!#^'/V*@W[9*+'U9CLQ2TF:I6MH2D)>8#!&T"2E
M]F);P5;:#?SCIZ;T95N7K*.3#H1.=P^GYQ[I"!:5+N-&+DJI,W0$YZ:R<2,Q
MF<U%47BFO'+.J3'.Z2<FU_[]D?\EM6NM-[KT\Z1)/8Y<X$18F<"U+JNX03SV
MX+'?-SIN3`<?%J/>%*%.!_J)**[T3%OH=)`UY;7(5-45-LE,X=E2%%6NK?"D
MR>N'T)IB3-T,2,1P$-8DQ#RJ)5&$"$ZTPI2W0HYR3WJ;[HW)ULU-:;YJ:3VE
M?T9AF-((!YQ@XE!XT$;O@7ANAP$S_]8BH"S&88RC8TQBC.&.H>Y39N"80!.C
M4WC=^OM(PJ=);]X__PP]I:`_OG2[X>EHL!R.^_,1K$P)O:TU9S,.HE`PF_2F
M?9<HP=D\22O8[%@72E5@$PUY6E5I<?4\D@MP:;W%?'PVNW4O!Q\GP^E@>;D8
MS8=@BGMX#UV`XZI%T.2Q>ZCYPH$0%AB='*#,<9WXU<8M(??7NBQTYJ=&VHQ1
M3SZAD6/:K@FAV)$9$*&XPB$G;1XR_5S##N,R-R/J\'!0.R#*=F+=FW98P*]P
M&V2ER#)Q([JE5HFP?X?+,*&$1`%CK&8A;0<[F;/V;R(/]HF<_B^1OTC<%W#7
MCS$TRYN=.3%-]K?F']0Y=.P0=)06,MLJ#>^RM-A^\X4K:+FJN)><H"%OM9B+
B^;7R-W]X0F\?/T:9:+FNMGE'!'05J56(?@!K*O1L@`4`````
`
end
