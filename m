Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVKGVTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVKGVTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVKGVTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:19:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16132 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965109AbVKGVTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:19:09 -0500
Date: Mon, 7 Nov 2005 22:19:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/vgastate.c: kill dead code
Message-ID: <20051107211908.GE3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch kills some dead code.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked by: Antonino Daplas <adaplas@pol.net>

---

This patch was already sent on:
- 1 Nov 2005

--- linux-2.6.14-rc5-mm1-full/drivers/video/vgastate.c.old	2005-11-01 20:40:29.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/vgastate.c	2005-11-01 20:40:37.000000000 +0100
@@ -485,11 +485,6 @@
 	return 0;
 }
 
-#ifdef MODULE
-int init_module(void) { return 0; };
-void cleanup_module(void) {};
-#endif
-
 EXPORT_SYMBOL(save_vga);
 EXPORT_SYMBOL(restore_vga);
 

