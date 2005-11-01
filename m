Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVKAUyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVKAUyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVKAUyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:54:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22023 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751182AbVKAUyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:54:09 -0500
Date: Tue, 1 Nov 2005 21:54:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/vgastate.c: kill dead code
Message-ID: <20051101205406.GA8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch kills some dead code.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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
 

