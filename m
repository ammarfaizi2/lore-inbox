Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVCFOjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVCFOjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 09:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVCFOjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 09:39:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22032 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261413AbVCFOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 09:39:09 -0500
Date: Sun, 6 Mar 2005 15:39:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport hugetlb_total_pages
Message-ID: <20050306143908.GF5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm1-full/mm/hugetlb.c.old	2005-03-04 15:47:11.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/hugetlb.c	2005-03-04 15:47:29.000000000 +0100
@@ -230,7 +230,6 @@
 {
 	return nr_huge_pages * (HPAGE_SIZE / PAGE_SIZE);
 }
-EXPORT_SYMBOL(hugetlb_total_pages);
 
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause

