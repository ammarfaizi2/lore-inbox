Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVFUAFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVFUAFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVFUADs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:03:48 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47374 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261852AbVFTXni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:43:38 -0400
Date: Tue, 21 Jun 2005 01:43:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
Message-ID: <20050620234337.GI3666@stusta.de>
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
 

