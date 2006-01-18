Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbWASABd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbWASABd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWARX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:59:40 -0500
Received: from [151.97.230.9] ([151.97.230.9]:12265 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030482AbWARX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:59:36 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/8] uml: fix "apples/bananas" typo
Date: Thu, 19 Jan 2006 00:55:08 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118235506.4626.40389.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix stupid typo.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/physmem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index f3b583a..544665e 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -265,7 +265,7 @@ int init_maps(unsigned long physmem, uns
 	highmem_len = highmem_pages * sizeof(struct page);
 
 	total_pages = phys_pages + iomem_pages + highmem_pages;
-	total_len = phys_len + iomem_pages + highmem_len;
+	total_len = phys_len + iomem_len + highmem_len;
 
 	if(kmalloc_ok){
 		map = kmalloc(total_len, GFP_KERNEL);

