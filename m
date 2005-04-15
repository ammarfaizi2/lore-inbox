Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVDOPYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVDOPYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 11:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVDOPWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 11:22:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33810 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261839AbVDOPKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 11:10:46 -0400
Date: Fri, 15 Apr 2005 17:10:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport is_console_locked
Message-ID: <20050415151045.GK5456@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Mar 2005

--- linux-2.6.11-rc5-mm1-full/kernel/printk.c.old	2005-03-04 00:58:16.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/printk.c	2005-03-04 00:58:22.000000000 +0100
@@ -675,7 +675,6 @@
 {
 	return console_locked;
 }
-EXPORT_SYMBOL(is_console_locked);
 
 /**
  * release_console_sem - unlock the console system

