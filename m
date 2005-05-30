Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVE3Aeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVE3Aeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 20:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVE3Acs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 20:32:48 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18448 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261483AbVE3A2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 20:28:38 -0400
Date: Mon, 30 May 2005 02:28:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
Message-ID: <20050530002836.GM10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any modular usage of kmem_cache_alloc_node.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 15 May 2005

--- linux-2.6.11-mm1-full/mm/slab.c.old	2005-03-06 15:40:38.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/slab.c	2005-03-06 15:41:06.000000000 +0100
@@ -2431,7 +2440,6 @@
 					__builtin_return_address(0));
 	return objp;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
 
 #endif
 

