Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVAWKXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVAWKXx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVAWKXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:23:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:520 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261290AbVAWKRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:17:50 -0500
Date: Sun, 23 Jan 2005 11:17:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/moxa.c: #if 0 an unused function
Message-ID: <20050123101743.GM3212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch #if 0's an unused global function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Dec 2004

--- linux-2.6.10-rc2-mm4-full/drivers/char/moxa.c.old	2004-12-06 01:30:18.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/char/moxa.c	2004-12-06 01:30:39.000000000 +0100
@@ -3090,6 +3090,7 @@
 	return (0);
 }
 
+#if 0
 long MoxaPortGetCurBaud(int port)
 {
 
@@ -3097,6 +3098,7 @@
 		return (0);
 	return (moxaCurBaud[port]);
 }
+#endif  /*  0  */
 
 static void MoxaSetFifo(int port, int enable)
 {



