Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTBTB73>; Wed, 19 Feb 2003 20:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbTBTB72>; Wed, 19 Feb 2003 20:59:28 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:51973 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265065AbTBTB7G>; Wed, 19 Feb 2003 20:59:06 -0500
Subject: [PATCH] Spelling fixes for handeling -> handling and others in 25
	files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 19 Feb 2003 19:00:26 -0700
Message-Id: <1045706428.10680.492.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the following spelling fixes:

handel      -> handle
handeling   -> handling
handeled    -> handled
handeler    -> handler

 arch/mips/math-emu/dp_add.c             |    4 ++--
 arch/mips/math-emu/dp_div.c             |    4 ++--
 arch/mips/math-emu/dp_mul.c             |    2 +-
 arch/mips/math-emu/dp_sub.c             |    4 ++--
 arch/mips/math-emu/ieee754dp.c          |    2 +-
 arch/mips/math-emu/ieee754sp.c          |    2 +-
 arch/mips/math-emu/sp_add.c             |    4 ++--
 arch/mips/math-emu/sp_div.c             |    4 ++--
 arch/mips/math-emu/sp_mul.c             |    2 +-
 arch/mips/math-emu/sp_sub.c             |    4 ++--
 arch/mips64/math-emu/dp_add.c           |    4 ++--
 arch/mips64/math-emu/dp_div.c           |    4 ++--
 arch/mips64/math-emu/dp_mul.c           |    2 +-
 arch/mips64/math-emu/dp_sub.c           |    4 ++--
 arch/mips64/math-emu/ieee754dp.c        |    2 +-
 arch/mips64/math-emu/ieee754sp.c        |    2 +-
 arch/mips64/math-emu/sp_add.c           |    4 ++--
 arch/mips64/math-emu/sp_div.c           |    4 ++--
 arch/mips64/math-emu/sp_mul.c           |    2 +-
 arch/mips64/math-emu/sp_sub.c           |    4 ++--
 drivers/char/epca.c                     |    6 +++---
 drivers/char/ftape/zftape/zftape-vtbl.h |    2 +-
 drivers/media/radio/radio-terratec.c    |    2 +-
 drivers/net/wan/sdla_x25.c              |    2 +-
 net/wanrouter/af_wanpipe.c              |    2 +-
 25 files changed, 39 insertions(+), 39 deletions(-)

diff -ur linux-2.5-current/arch/mips/math-emu/dp_add.c linux/arch/mips/math-emu/dp_add.c
--- linux-2.5-current/arch/mips/math-emu/dp_add.c	Wed Feb 19 07:34:51 2003
+++ linux/arch/mips/math-emu/dp_add.c	Wed Feb 19 07:59:31 2003
@@ -73,7 +73,7 @@
 		return x;
 

-		/* Inifity handeling 
+		/* Inifity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -92,7 +92,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return x;
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips/math-emu/dp_div.c linux/arch/mips/math-emu/dp_div.c
--- linux-2.5-current/arch/mips/math-emu/dp_div.c	Wed Feb 19 07:34:41 2003
+++ linux/arch/mips/math-emu/dp_div.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Infinity handeling 
+		/* Infinity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -89,7 +89,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return ieee754dp_inf(xs ^ ys);
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips/math-emu/dp_mul.c linux/arch/mips/math-emu/dp_mul.c
--- linux-2.5-current/arch/mips/math-emu/dp_mul.c	Wed Feb 19 07:34:57 2003
+++ linux/arch/mips/math-emu/dp_mul.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Infinity handeling */
+		/* Infinity handling */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
diff -ur linux-2.5-current/arch/mips/math-emu/dp_sub.c linux/arch/mips/math-emu/dp_sub.c
--- linux-2.5-current/arch/mips/math-emu/dp_sub.c	Wed Feb 19 07:35:07 2003
+++ linux/arch/mips/math-emu/dp_sub.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Inifity handeling 
+		/* Inifity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -91,7 +91,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return x;
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips/math-emu/ieee754dp.c linux/arch/mips/math-emu/ieee754dp.c
--- linux-2.5-current/arch/mips/math-emu/ieee754dp.c	Wed Feb 19 07:35:06 2003
+++ linux/arch/mips/math-emu/ieee754dp.c	Wed Feb 19 07:59:31 2003
@@ -99,7 +99,7 @@
 }
 

-/* generate a normal/denormal number with over,under handeling
+/* generate a normal/denormal number with over,under handling
  * sn is sign
  * xe is an unbiased exponent
  * xm is 3bit extended precision value.
diff -ur linux-2.5-current/arch/mips/math-emu/ieee754sp.c linux/arch/mips/math-emu/ieee754sp.c
--- linux-2.5-current/arch/mips/math-emu/ieee754sp.c	Wed Feb 19 07:34:52 2003
+++ linux/arch/mips/math-emu/ieee754sp.c	Wed Feb 19 07:59:31 2003
@@ -100,7 +100,7 @@
 }
 

-/* generate a normal/denormal number with over,under handeling
+/* generate a normal/denormal number with over,under handling
  * sn is sign
  * xe is an unbiased exponent
  * xm is 3bit extended precision value.
diff -ur linux-2.5-current/arch/mips/math-emu/sp_add.c linux/arch/mips/math-emu/sp_add.c
--- linux-2.5-current/arch/mips/math-emu/sp_add.c	Wed Feb 19 07:35:16 2003
+++ linux/arch/mips/math-emu/sp_add.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Inifity handeling 
+		/* Inifity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -91,7 +91,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return x;
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips/math-emu/sp_div.c linux/arch/mips/math-emu/sp_div.c
--- linux-2.5-current/arch/mips/math-emu/sp_div.c	Wed Feb 19 07:35:16 2003
+++ linux/arch/mips/math-emu/sp_div.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Infinity handeling 
+		/* Infinity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -89,7 +89,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return ieee754sp_inf(xs ^ ys);
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips/math-emu/sp_mul.c linux/arch/mips/math-emu/sp_mul.c
--- linux-2.5-current/arch/mips/math-emu/sp_mul.c	Wed Feb 19 07:35:03 2003
+++ linux/arch/mips/math-emu/sp_mul.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Infinity handeling */
+		/* Infinity handling */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
diff -ur linux-2.5-current/arch/mips/math-emu/sp_sub.c linux/arch/mips/math-emu/sp_sub.c
--- linux-2.5-current/arch/mips/math-emu/sp_sub.c	Wed Feb 19 07:34:53 2003
+++ linux/arch/mips/math-emu/sp_sub.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Inifity handeling 
+		/* Inifity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -91,7 +91,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return x;
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips64/math-emu/dp_add.c linux/arch/mips64/math-emu/dp_add.c
--- linux-2.5-current/arch/mips64/math-emu/dp_add.c	Wed Feb 19 07:35:22 2003
+++ linux/arch/mips64/math-emu/dp_add.c	Wed Feb 19 07:59:31 2003
@@ -73,7 +73,7 @@
 		return x;
 

-		/* Inifity handeling 
+		/* Inifity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -92,7 +92,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return x;
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips64/math-emu/dp_div.c linux/arch/mips64/math-emu/dp_div.c
--- linux-2.5-current/arch/mips64/math-emu/dp_div.c	Wed Feb 19 07:34:37 2003
+++ linux/arch/mips64/math-emu/dp_div.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Infinity handeling 
+		/* Infinity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -89,7 +89,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return ieee754dp_inf(xs ^ ys);
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips64/math-emu/dp_mul.c linux/arch/mips64/math-emu/dp_mul.c
--- linux-2.5-current/arch/mips64/math-emu/dp_mul.c	Wed Feb 19 07:35:23 2003
+++ linux/arch/mips64/math-emu/dp_mul.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Infinity handeling */
+		/* Infinity handling */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
diff -ur linux-2.5-current/arch/mips64/math-emu/dp_sub.c linux/arch/mips64/math-emu/dp_sub.c
--- linux-2.5-current/arch/mips64/math-emu/dp_sub.c	Wed Feb 19 07:34:58 2003
+++ linux/arch/mips64/math-emu/dp_sub.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Inifity handeling 
+		/* Inifity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -91,7 +91,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return x;
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips64/math-emu/ieee754dp.c linux/arch/mips64/math-emu/ieee754dp.c
--- linux-2.5-current/arch/mips64/math-emu/ieee754dp.c	Wed Feb 19 07:35:16 2003
+++ linux/arch/mips64/math-emu/ieee754dp.c	Wed Feb 19 07:59:31 2003
@@ -99,7 +99,7 @@
 }
 

-/* generate a normal/denormal number with over,under handeling
+/* generate a normal/denormal number with over,under handling
  * sn is sign
  * xe is an unbiased exponent
  * xm is 3bit extended precision value.
diff -ur linux-2.5-current/arch/mips64/math-emu/ieee754sp.c linux/arch/mips64/math-emu/ieee754sp.c
--- linux-2.5-current/arch/mips64/math-emu/ieee754sp.c	Wed Feb 19 07:35:03 2003
+++ linux/arch/mips64/math-emu/ieee754sp.c	Wed Feb 19 07:59:31 2003
@@ -100,7 +100,7 @@
 }
 

-/* generate a normal/denormal number with over,under handeling
+/* generate a normal/denormal number with over,under handling
  * sn is sign
  * xe is an unbiased exponent
  * xm is 3bit extended precision value.
diff -ur linux-2.5-current/arch/mips64/math-emu/sp_add.c linux/arch/mips64/math-emu/sp_add.c
--- linux-2.5-current/arch/mips64/math-emu/sp_add.c	Wed Feb 19 07:34:52 2003
+++ linux/arch/mips64/math-emu/sp_add.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Inifity handeling 
+		/* Inifity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -91,7 +91,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return x;
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips64/math-emu/sp_div.c linux/arch/mips64/math-emu/sp_div.c
--- linux-2.5-current/arch/mips64/math-emu/sp_div.c	Wed Feb 19 07:35:22 2003
+++ linux/arch/mips64/math-emu/sp_div.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Infinity handeling 
+		/* Infinity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -89,7 +89,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return ieee754sp_inf(xs ^ ys);
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/arch/mips64/math-emu/sp_mul.c linux/arch/mips64/math-emu/sp_mul.c
--- linux-2.5-current/arch/mips64/math-emu/sp_mul.c	Wed Feb 19 07:34:52 2003
+++ linux/arch/mips64/math-emu/sp_mul.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Infinity handeling */
+		/* Infinity handling */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_INF):
diff -ur linux-2.5-current/arch/mips64/math-emu/sp_sub.c linux/arch/mips64/math-emu/sp_sub.c
--- linux-2.5-current/arch/mips64/math-emu/sp_sub.c	Wed Feb 19 07:34:56 2003
+++ linux/arch/mips64/math-emu/sp_sub.c	Wed Feb 19 07:59:31 2003
@@ -72,7 +72,7 @@
 		return x;
 

-		/* Inifity handeling 
+		/* Inifity handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
@@ -91,7 +91,7 @@
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 		return x;
 
-		/* Zero handeling 
+		/* Zero handling
 		 */
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
diff -ur linux-2.5-current/drivers/char/epca.c linux/drivers/char/epca.c
--- linux-2.5-current/drivers/char/epca.c	Wed Feb 19 07:35:02 2003
+++ linux/drivers/char/epca.c	Wed Feb 19 07:59:31 2003
@@ -2743,11 +2743,11 @@
 
 		/* ---------------------------------------------------------------
 			Command sets channels iflag structure on the board. Such things 
-			as input soft flow control, handeling of parity errors, and
-			break handeling are all set here.
+			as input soft flow control, handling of parity errors, and
+			break handling are all set here.
 		------------------------------------------------------------------- */
 
-		/* break handeling, parity handeling, input stripping, flow control chars */
+		/* break handling, parity handling, input stripping, flow control chars */
 		fepcmd(ch, SETIFLAGS, (unsigned int) ch->fepiflag, 0, 0, 0);
 	}
 
diff -ur linux-2.5-current/drivers/char/ftape/zftape/zftape-vtbl.h linux/drivers/char/ftape/zftape/zftape-vtbl.h
--- linux-2.5-current/drivers/char/ftape/zftape/zftape-vtbl.h	Wed Feb 19 07:34:55 2003
+++ linux/drivers/char/ftape/zftape/zftape-vtbl.h	Wed Feb 19 07:59:31 2003
@@ -176,7 +176,7 @@
 				      const zft_position *pos);
 
 /* this function decrements the zft_seg_pos counter if we are right
- * at the beginning of a segment. This is to handel fsfm/bsfm -- we
+ * at the beginning of a segment. This is to handle fsfm/bsfm -- we
  * need to position before the eof mark.  NOTE: zft_tape_pos is not
  * changed 
  */
diff -ur linux-2.5-current/drivers/media/radio/radio-terratec.c linux/drivers/media/radio/radio-terratec.c
--- linux-2.5-current/drivers/media/radio/radio-terratec.c	Wed Feb 19 07:34:56 2003
+++ linux/drivers/media/radio/radio-terratec.c	Wed Feb 19 07:59:31 2003
@@ -129,7 +129,7 @@
 	long rest;
      
 	unsigned char buffer[25];		/* we have to bit shift 25 registers */
-	freq = freq1/160;			/* convert the freq. to a nice to handel value */
+	freq = freq1/160;			/* convert the freq. to a nice to handle value */
 	for(i=24;i>-1;i--)
 		buffer[i]=0;
 
diff -ur linux-2.5-current/drivers/net/wan/sdla_x25.c linux/drivers/net/wan/sdla_x25.c
--- linux-2.5-current/drivers/net/wan/sdla_x25.c	Wed Feb 19 07:35:06 2003
+++ linux/drivers/net/wan/sdla_x25.c	Wed Feb 19 07:59:31 2003
@@ -3064,7 +3064,7 @@
 
 		/* Bug Fix: Mar 14 2000
                  * The Protocol violation error conditions were  
-                 * not handeled previously */
+                 * not handled previously */
 
 		switch (mb->cmd.pktType & 0x7F){
 
diff -ur linux-2.5-current/net/wanrouter/af_wanpipe.c linux/net/wanrouter/af_wanpipe.c
--- linux-2.5-current/net/wanrouter/af_wanpipe.c	Wed Feb 19 07:35:21 2003
+++ linux/net/wanrouter/af_wanpipe.c	Wed Feb 19 07:59:31 2003
@@ -674,7 +674,7 @@
 /*============================================================
  * wanpipe_delayed_tarnsmit
  *
- *	Transmit bottom half handeler. It dequeues packets
+ *	Transmit bottom half handler. It dequeues packets
  *      from sk->write_queue and passes them to the 
  *      driver.  If the driver is busy, the packet is 
  *      re-enqueued.  




