Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSFITWO>; Sun, 9 Jun 2002 15:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSFITWM>; Sun, 9 Jun 2002 15:22:12 -0400
Received: from mail315.mail.bellsouth.net ([205.152.58.175]:9950 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S314885AbSFITVl>; Sun, 9 Jun 2002 15:21:41 -0400
Message-ID: <3D03AABD.FB9BD518@bellsouth.net>
Date: Sun, 09 Jun 2002 15:21:33 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.21 i2c updates 4/4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4/4 updates I2C for 2.5.21
--- linux/drivers/i2c/i2c-elektor.c.orig	2002-05-14 23:14:40.000000000 -0400
+++ linux/drivers/i2c/i2c-elektor.c	2002-05-16 09:38:09.000000000 -0400
@@ -160,7 +160,7 @@
 }
 
 
-static void __exit pcf_isa_exit(void)
+static void pcf_isa_exit(void)
 {
 	if (irq > 0) {
 		disable_irq(irq);

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
