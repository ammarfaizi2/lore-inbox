Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVCFOhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVCFOhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 09:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVCFOhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 09:37:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20752 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261405AbVCFOhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 09:37:02 -0500
Date: Sun, 6 Mar 2005 15:36:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport clear_page_dirty_for_io
Message-ID: <20050306143659.GE5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm1-full/mm/page-writeback.c.old	2005-03-04 16:11:21.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/page-writeback.c	2005-03-04 16:11:35.000000000 +0100
@@ -752,7 +752,6 @@
 	}
 	return TestClearPageDirty(page);
 }
-EXPORT_SYMBOL(clear_page_dirty_for_io);
 
 int test_clear_page_writeback(struct page *page)
 {

