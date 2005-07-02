Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVGBLlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVGBLlu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 07:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVGBLlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 07:41:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9478 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261175AbVGBLht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 07:37:49 -0400
Date: Sat, 2 Jul 2005 13:37:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
Message-ID: <20050702113747.GM3592@stusta.de>
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
- 21 Jun 2005
- 30 May 2005
- 15 May 2005

--- linux-2.6.11-mm1-full/mm/slab.c.old	2005-03-06 15:40:38.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/slab.c	2005-03-06 15:41:06.000000000 +0100
@@ -2431,7 +2440,6 @@
 					__builtin_return_address(0));
 	return objp;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
 
 #endif
 

