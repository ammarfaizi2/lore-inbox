Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVAQIXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVAQIXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 03:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVAQIRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 03:17:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32013 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262728AbVAQIOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 03:14:03 -0500
Date: Mon, 17 Jan 2005 09:13:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] lib/kernel_lock.c: make kernel_sem static
Message-ID: <20050117081358.GD4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes kernel_sem static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/lib/kernel_lock.c.old	2004-12-12 03:44:02.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/lib/kernel_lock.c	2004-12-12 03:44:09.000000000 +0100
@@ -79,7 +79,7 @@
  *
  * Don't use in new code.
  */
-DECLARE_MUTEX(kernel_sem);
+static DECLARE_MUTEX(kernel_sem);
 
 /*
  * Re-acquire the kernel semaphore.

