Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVKANfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVKANfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVKANfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:35:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19218 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750746AbVKANfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:35:42 -0500
Date: Tue, 1 Nov 2005 14:35:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/hugetlbfs/inode.c: make a function static
Message-ID: <20051101133538.GO8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/fs/hugetlbfs/inode.c.old	2005-10-31 17:32:34.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/hugetlbfs/inode.c	2005-10-31 17:32:58.000000000 +0100
@@ -63,7 +63,7 @@
  *
  * Result is in bytes to be compatible with is_hugepage_mem_enough()
  */
-unsigned long
+static unsigned long
 huge_pages_needed(struct address_space *mapping, struct vm_area_struct *vma)
 {
 	int i;

