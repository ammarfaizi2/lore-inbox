Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVEBCwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVEBCwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVEBBwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:52:36 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43024 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261698AbVEBBr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:47:28 -0400
Date: Mon, 2 May 2005 03:47:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cdrom/sbpcd.c: make a function static
Message-ID: <20050502014721.GF3592@stusta.de>
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
- 10 Apr 2005

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
 	

