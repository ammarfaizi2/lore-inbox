Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVCFOpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVCFOpG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 09:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVCFOpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 09:45:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27920 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261412AbVCFOpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 09:45:00 -0500
Date: Sun, 6 Mar 2005 15:44:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/page_alloc.c: unexport nr_swap_pages
Message-ID: <20050306144459.GH5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm1-full/mm/page_alloc.c.old	2005-03-04 16:00:09.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/page_alloc.c	2005-03-04 16:00:20.000000000 +0100
@@ -60,7 +60,6 @@
 int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 32 };
 
 EXPORT_SYMBOL(totalram_pages);
-EXPORT_SYMBOL(nr_swap_pages);
 
 /*
  * Used by page_zone() to look up the address of the struct zone whose

