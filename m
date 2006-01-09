Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWAIWXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWAIWXT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWAIWXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:23:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1292 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751572AbWAIWXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:23:18 -0500
Date: Mon, 9 Jan 2006 23:23:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-h8300/page.h: remove unused KTHREAD_SIZE #define
Message-ID: <20060109222318.GU3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unused #define.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Jan 2006

--- linux-2.6.15-mm1-full/include/asm-h8300/page.h.old	2006-01-06 16:44:15.000000000 +0100
+++ linux-2.6.15-mm1-full/include/asm-h8300/page.h	2006-01-06 16:44:25.000000000 +0100
@@ -13,12 +13,6 @@
 
 #include <asm/setup.h>
 
-#if !defined(CONFIG_SMALL_TASKS) && PAGE_SHIFT < 13
-#define KTHREAD_SIZE (8192)
-#else
-#define KTHREAD_SIZE PAGE_SIZE
-#endif
- 
 #ifndef __ASSEMBLY__
  
 #define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)

