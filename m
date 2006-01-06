Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWAFQTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWAFQTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWAFQTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:19:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42507 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751545AbWAFQTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:19:51 -0500
Date: Fri, 6 Jan 2006 17:19:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-h8300/page.h: remove unused KTHREAD_SIZE #define
Message-ID: <20060106161946.GI12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unused #define.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

