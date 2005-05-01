Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVEAPuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVEAPuO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 11:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVEAPs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:48:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50440 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261677AbVEAPnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:43:07 -0400
Date: Sun, 1 May 2005 17:43:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/fbmem.c: make a function static
Message-ID: <20050501154305.GR3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 18 Apr 2005

--- linux-2.6.12-rc2-mm3-full/drivers/video/fbmem.c.old	2005-04-18 00:39:21.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/fbmem.c	2005-04-18 00:39:34.000000000 +0200
@@ -1312,7 +1312,7 @@
  *	Returns zero.
  *
  */
-int __init video_setup(char *options)
+static int __init video_setup(char *options)
 {
 	int i, global = 0;
 

