Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277353AbRKFB4H>; Mon, 5 Nov 2001 20:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277371AbRKFBz6>; Mon, 5 Nov 2001 20:55:58 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:29056 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S277353AbRKFBzu>; Mon, 5 Nov 2001 20:55:50 -0500
Date: Mon, 5 Nov 2001 17:55:43 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.4.14 trivial CONFIG typo in drivers/i2c/i2c-core.c
Message-ID: <Pine.LNX.4.33.0111051738520.5257-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[whitney@pizza linux-2.4.14]$ grep -r CONFIG_I2C_CONFIG_I2C .
./drivers/i2c/i2c-core.c:#ifdef CONFIG_I2C_CONFIG_I2C_PHILIPSPAR
[whitney@pizza linux-2.4.14]$ cd ..
[whitney@pizza src]$ diff -ru linux-2.4.14/drivers/i2c linux-2.4.13-ac8/drivers/i2c
diff -ru linux-2.4.14/drivers/i2c/i2c-core.c linux-2.4.13-ac8/drivers/i2c/i2c-core.c
--- linux-2.4.14/drivers/i2c/i2c-core.c	Sun Oct 28 07:02:34 2001
+++ linux-2.4.13-ac8/drivers/i2c/i2c-core.c	Mon Nov  5 14:44:34 2001
@@ -1284,7 +1284,7 @@
 #ifdef CONFIG_I2C_ALGOBIT
 	extern int i2c_algo_bit_init(void);
 #endif
-#ifdef CONFIG_I2C_CONFIG_I2C_PHILIPSPAR
+#ifdef CONFIG_I2C_PHILIPSPAR
 	extern int i2c_bitlp_init(void);
 #endif
 #ifdef CONFIG_I2C_ELV

