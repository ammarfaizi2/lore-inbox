Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbULEQ5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbULEQ5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 11:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbULEQ5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 11:57:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13322 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261318AbULEQ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 11:57:37 -0500
Date: Sun, 5 Dec 2004 17:57:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/esp.c: make a function static
Message-ID: <20041205165735.GM2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/esp.c.old	2004-11-07 00:09:28.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/esp.c	2004-11-07 00:09:39.000000000 +0100
@@ -2401,7 +2401,7 @@
 /*
  * The serial driver boot-time initialization code!
  */
-int __init espserial_init(void)
+static int __init espserial_init(void)
 {
 	int i, offset;
 	struct esp_struct * info;

