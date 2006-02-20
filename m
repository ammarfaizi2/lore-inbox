Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWBTWgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWBTWgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWBTWgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:36:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62220 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932690AbWBTWgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:36:15 -0500
Date: Mon, 20 Feb 2006 23:36:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
Message-ID: <20060220223613.GL4661@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any modular usage of kmem_cache_alloc_node.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 27 Jul 2005
- 2 Jul 2005
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
 

