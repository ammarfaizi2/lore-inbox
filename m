Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVEON3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVEON3G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 09:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVEON3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 09:29:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25361 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261615AbVEON3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 09:29:03 -0400
Date: Sun, 15 May 2005 15:28:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
Message-ID: <20050515132856.GV16549@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any modular usage of kmem_cache_alloc_node.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm1-full/mm/slab.c.old	2005-03-06 15:40:38.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/slab.c	2005-03-06 15:41:06.000000000 +0100
@@ -2431,7 +2440,6 @@
 					__builtin_return_address(0));
 	return objp;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
 
 #endif
 

