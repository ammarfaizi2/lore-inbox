Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVCFOuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVCFOuk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 09:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVCFOuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 09:50:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31248 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261417AbVCFOs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 09:48:59 -0500
Date: Sun, 6 Mar 2005 15:48:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/swapfile.c: unexport total_swap_pages
Message-ID: <20050306144856.GK5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm1-full/mm/swapfile.c.old	2005-03-04 16:23:03.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/swapfile.c	2005-03-04 16:23:18.000000000 +0100
@@ -37,8 +37,6 @@
 long total_swap_pages;
 static int swap_overflow;
 
-EXPORT_SYMBOL(total_swap_pages);
-
 static const char Bad_file[] = "Bad swap file entry ";
 static const char Unused_file[] = "Unused swap file entry ";
 static const char Bad_offset[] = "Bad swap offset entry ";

