Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbSKUA5X>; Wed, 20 Nov 2002 19:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266237AbSKUA5W>; Wed, 20 Nov 2002 19:57:22 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:17167 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266233AbSKUA5U>; Wed, 20 Nov 2002 19:57:20 -0500
Date: Wed, 20 Nov 2002 23:04:21 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] hd: fix up header cleanups: add include <linux/interrupt.h>
Message-ID: <20021121010421.GC28717@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

	Now there just this outstanding changeset.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.922, 2002-11-20 23:01:13-02:00, acme@conectiva.com.br
  hd: fix up header cleanup: add include <linux/interrupt.h>


 hd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/ide/legacy/hd.c b/drivers/ide/legacy/hd.c
--- a/drivers/ide/legacy/hd.c	Wed Nov 20 23:02:46 2002
+++ b/drivers/ide/legacy/hd.c	Wed Nov 20 23:02:46 2002
@@ -26,9 +26,10 @@
 /* Uncomment the following if you want verbose error reports. */
 /* #define VERBOSE_ERRORS */
 
+#include <linux/blk.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -45,7 +46,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <linux/blk.h>
 
 #ifdef __arm__
 #undef  HD_IRQ

===================================================================


This BitKeeper patch contains the following changesets:
1.922
## Wrapped with gzip_uu ##


begin 664 bkpatch3815
M'XL(`+8PW#T``\U4P8K;,!0\1U_Q(,=B64^V'-LT2[J;TBY;:$C94^E!D92U
MB6,'V4ZSX(]?.6D3$KJ!ECWT2>B@)X]&,X.'\%@;FPZD6ALRA,]5W:0#595&
M-?E64E6MZ<*ZQKRJ7,//JK7Q;Q_\O%1%JTWM<2J(:\]DHS+8&ENG`Z3!<:=Y
MWIAT,/_XZ?'+ASDAXS'<9;)\,M],`^,Q:2J[E86N)[+)BJJDC95EO3;-_N+N
M>+3CC'$W!(X")J(.(Q:..H4:489H-.-A'(4GM)[E52Q$WB\Q2SH>)G%"IH`T
MX1P8]Q%]SH`'*<,4`X_QE#'HY9E<R@+O$#Q&;N%MGW%'%&0ZA66^@W8#F9':
M6%"%D66[24%J#;_DA_=%7K8[YT9CK&TW#<UNR`/PD`M!9B>IB?>710B3C-R`
MW"TJ,UFTMJSI7M25L:4IJ%YUVN:]W7ZNC9]IJ@Z/BS%RTHXPZ,(@&HE.F`4F
MB6!*B.4R%-&?A3P#*\R35,\G3.<5,F2NNL"5V*?HE0_Z3+TY9[+-;359.V_I
MIFZIT>WWWX;_N,Z<\81QP5!T`8_#0\IP=!XRYN;UD''P^/\7LH,77\&S/_?3
MA6;VFBW_D+]['@.2X06'1;'J;Y\&Z)KW^_7RR!G-:=BC'/]&*C-J5;?KL1+(
-(PP4>0$0FVJM_P0`````
`
end
