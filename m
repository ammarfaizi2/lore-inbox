Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVCYBNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVCYBNe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCYBN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:13:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34833 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261388AbVCYBL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:11:28 -0500
Date: Fri, 25 Mar 2005 02:11:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport slab_reclaim_pages
Message-ID: <20050325011126.GY3966@stusta.de>
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

--- linux-2.6.11-mm1-full/mm/slab.c.old	2005-03-04 16:14:03.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/slab.c	2005-03-04 16:14:17.000000000 +0100
@@ -558,7 +558,6 @@
  * SLAB_RECLAIM_ACCOUNT turns this on per-slab
  */
 atomic_t slab_reclaim_pages;
-EXPORT_SYMBOL(slab_reclaim_pages);
 
 /*
  * chicken and egg problem: delay the per-cpu array allocation

