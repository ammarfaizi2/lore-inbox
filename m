Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWGSIeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWGSIeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 04:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWGSIeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 04:34:00 -0400
Received: from mgate03.necel.com ([203.180.232.83]:62458 "EHLO
	mgate03.necel.com") by vger.kernel.org with ESMTP id S932527AbWGSId7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 04:33:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Remove symbol exports which duplicate global ones
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
From: Miles Bader <miles@gnu.org>
Message-Id: <20060719083330.849C3481@dhapc248.dev.necel.com>
Date: Wed, 19 Jul 2006 17:33:30 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/v850_ksyms.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff -ruN -X../cludes linux-2.6.17-uc0/arch/v850/kernel/v850_ksyms.c linux-2.6.17-uc0-v850-20060718/arch/v850/kernel/v850_ksyms.c
--- linux-2.6.17-uc0/arch/v850/kernel/v850_ksyms.c	2006-07-18 11:25:31.759850000 +0900
+++ linux-2.6.17-uc0-v850-20060718/arch/v850/kernel/v850_ksyms.c	2006-07-18 15:46:03.008350000 +0900
@@ -22,9 +22,6 @@
 
 /* platform dependent support */
 EXPORT_SYMBOL (kernel_thread);
-EXPORT_SYMBOL (enable_irq);
-EXPORT_SYMBOL (disable_irq);
-EXPORT_SYMBOL (disable_irq_nosync);
 EXPORT_SYMBOL (__bug);
 
 /* Networking helper routines. */
@@ -34,22 +31,9 @@
 EXPORT_SYMBOL (ip_fast_csum);
 
 /* string / mem functions */
-EXPORT_SYMBOL (strcpy);
-EXPORT_SYMBOL (strncpy);
-EXPORT_SYMBOL (strcat);
-EXPORT_SYMBOL (strncat);
-EXPORT_SYMBOL (strcmp);
-EXPORT_SYMBOL (strncmp);
-EXPORT_SYMBOL (strchr);
-EXPORT_SYMBOL (strlen);
-EXPORT_SYMBOL (strnlen);
-EXPORT_SYMBOL (strrchr);
-EXPORT_SYMBOL (strstr);
 EXPORT_SYMBOL (memset);
 EXPORT_SYMBOL (memcpy);
 EXPORT_SYMBOL (memmove);
-EXPORT_SYMBOL (memcmp);
-EXPORT_SYMBOL (memscan);
 
 /* semaphores */
 EXPORT_SYMBOL (__down);
