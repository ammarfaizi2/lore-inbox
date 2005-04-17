Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVDQXYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVDQXYX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVDQXYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:24:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44037 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261549AbVDQXYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:24:21 -0400
Date: Mon, 18 Apr 2005 01:24:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/fbmem.c: make a function static
Message-ID: <20050417232419.GU3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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
 

