Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVCYBNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVCYBNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVCYBND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:13:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35345 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261391AbVCYBLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:11:31 -0500
Date: Fri, 25 Mar 2005 02:11:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/page_alloc.c: unexport nr_swap_pages
Message-ID: <20050325011129.GZ3966@stusta.de>
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
- 6 Mar 2005

--- linux-2.6.11-mm1-full/mm/page_alloc.c.old	2005-03-04 16:00:09.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/page_alloc.c	2005-03-04 16:00:20.000000000 +0100
@@ -60,7 +60,6 @@
 int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 32 };
 
 EXPORT_SYMBOL(totalram_pages);
-EXPORT_SYMBOL(nr_swap_pages);
 
 /*
  * Used by page_zone() to look up the address of the struct zone whose

