Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVG0TwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVG0TwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVG0TwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:52:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27145 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262446AbVG0TvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:51:19 -0400
Date: Wed, 27 Jul 2005 21:51:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
Message-ID: <20050727195107.GC29092@stusta.de>
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
 

