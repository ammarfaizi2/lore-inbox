Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbUKIFy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUKIFy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUKIFvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:51:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:1183 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261389AbUKIFZB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:25:01 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778554@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:16 -0800
Message-Id: <1099977856124@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.10, 2004/11/05 13:43:41-08:00, bunk@stusta.de

[PATCH] i2c it87.c: remove an unused function

The patch below removes an unused function from drivers/i2c/chips/it87.c


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |    7 -------
 1 files changed, 7 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-11-08 18:55:38 -08:00
+++ b/drivers/i2c/chips/it87.c	2004-11-08 18:55:38 -08:00
@@ -56,13 +56,6 @@
 #define PME	0x04	/* The device with the fan registers in it */
 #define	DEVID	0x20	/* Register: Device ID */
 
-static inline void
-superio_outb(int reg, int val)
-{
-	outb(reg, REG);
-	outb(val, VAL);
-}
-
 static inline int
 superio_inb(int reg)
 {

