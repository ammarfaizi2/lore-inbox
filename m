Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVDJSSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVDJSSf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVDJSR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:17:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29457 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261548AbVDJSQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:16:03 -0400
Date: Sun, 10 Apr 2005 20:16:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cdrom/sbpcd.c: make a function static
Message-ID: <20050410181602.GH4204@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm2-full/drivers/cdrom/sbpcd.c.old	2005-04-10 02:19:08.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/cdrom/sbpcd.c	2005-04-10 02:19:56.000000000 +0200
@@ -5895,7 +5895,7 @@
 }
 /*==========================================================================*/
 #ifdef MODULE
-void sbpcd_exit(void)
+static void sbpcd_exit(void)
 {
 	int j;
 	

