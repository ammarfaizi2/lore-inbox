Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267555AbSKQTMO>; Sun, 17 Nov 2002 14:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267556AbSKQTMO>; Sun, 17 Nov 2002 14:12:14 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:28943 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267555AbSKQTMN>; Sun, 17 Nov 2002 14:12:13 -0500
Date: Sun, 17 Nov 2002 17:18:58 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Kernel Janitors Project 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] xd: fixup after header files cleanups: add include <linux/interrupt.h>
Message-ID: <20021117191858.GO28227@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Janitors Project <kernel-janitor-discuss@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	This is the only outstanding changeset there now.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.855, 2002-11-17 17:09:57-02:00, acme@conectiva.com.br
  o xd: fixup after header files cleanups: add include <linux/interrupt.h>
  
  request_irq/free_irq are now in linux/interrupt.h


 xd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/block/xd.c b/drivers/block/xd.c
--- a/drivers/block/xd.c	Sun Nov 17 17:10:19 2002
+++ b/drivers/block/xd.c	Sun Nov 17 17:10:19 2002
@@ -35,7 +35,7 @@
 
 #include <linux/module.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -44,6 +44,7 @@
 #include <linux/hdreg.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/wait.h>
 #include <linux/devfs_fs_kernel.h>
 
 #include <asm/system.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.855
## Wrapped with gzip_uu ##


begin 664 bkpatch22873
M'XL(`)OIUST``]V4T6K;,!2&KZ.G.)#+85N2Y=@R2\G:CJUTL)#1JS&&(BFS
MJ6VELIRDX(>?XFW9:-*6E5W-$I;P.?IUI/_#8[AIM<U'0M8:C>&]:5T^DJ;1
MTI4;$4I3ATOK`PMC?"`J3*VC\^NH;&35*=T&-$R0#\^%DP5LM&WS$0GCPQ=W
MO];Y:/'VW<V'-PN$IE.X*$3S37_2#J93Y(S=B$JU,^&*RC2ALZ)I:^V&C?M#
M:D\QIKXE)(UQ,NG)!+.TET01(AC1"E.631C:GV'VL/8'*H20U#?,6(\YCC&Z
M!!)F20*81H1$)`62YICG21I@FF,,)T7A%8$`HW/XMP>X0!(,[%0.JW+7K4&L
MG+90:*'\L"HKW8*LM&BZ=9N#4`I^V@"OJ[+I=MX5GV^[M0N+,R_EN]5WG6[=
MU]+>12NK]7X"PFIHS-:OAJ-UZ!JRF%`T_VT4"O[R00@+C,Z>N1QERSTOT;(R
M\C;:J5#^<4L,8]:3C&>L%Y2D*J8BB8F:8'[:D,?4!KLYYDG<$Q[C;$#P./=Y
M%E]8+=J4ULQJ+QFNVR[4JOO\:Y\OC]:,*?=`<,8])Y.,#XBR](C0^&E"*03D
M/R7TAY4?(;#;H7ODYB=<?0&XEW$&!%T-[_%3M5^QR8F4K2B'Z.'_)PLM;]NN
1GK*8+S--,_0=,EQS<7$%````
`
end
