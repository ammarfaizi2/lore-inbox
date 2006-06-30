Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWF3Lcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWF3Lcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWF3Lcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:32:35 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14088 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751065AbWF3Lc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:32:29 -0400
Date: Fri, 30 Jun 2006 13:32:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/bootmem.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630113227.GO19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks an unused export as EXPORT_UNUSED_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm4-full/mm/bootmem.c.old	2006-06-30 02:50:17.000000000 +0200
+++ linux-2.6.17-mm4-full/mm/bootmem.c	2006-06-30 02:50:41.000000000 +0200
@@ -29,9 +29,7 @@
 unsigned long min_low_pfn;
 unsigned long max_pfn;
 
-EXPORT_SYMBOL(max_pfn);		/* This is exported so
-				 * dma_get_required_mask(), which uses
-				 * it, can be an inline function */
+EXPORT_UNUSED_SYMBOL(max_pfn);  /*  June 2006  */
 
 static LIST_HEAD(bdata_list);
 #ifdef CONFIG_CRASH_DUMP

