Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbULVLum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbULVLum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 06:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbULVLum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 06:50:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57873 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261881AbULVLuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 06:50:02 -0500
Date: Wed, 22 Dec 2004 12:50:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/esp.c: make a function static (fwd)
Message-ID: <20041222115000.GL5217@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 5 Dec 2004 17:57:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/esp.c: make a function static

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

