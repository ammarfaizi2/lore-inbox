Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbVKBGFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbVKBGFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 01:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbVKBGFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 01:05:40 -0500
Received: from xenotime.net ([66.160.160.81]:36022 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932682AbVKBGFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 01:05:39 -0500
Date: Tue, 1 Nov 2005 21:57:50 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: fix warnings in vmalloc.c
Message-Id: <20051101215750.6750af15.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix new kernel-doc errors in vmalloc.c.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 mm/vmalloc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp linux-2614-g4/mm/vmalloc.c~kdoc_vmalloc linux-2614-g4/mm/vmalloc.c
--- linux-2614-g4/mm/vmalloc.c~kdoc_vmalloc	2005-11-01 20:35:15.000000000 -0800
+++ linux-2614-g4/mm/vmalloc.c	2005-11-01 21:55:44.000000000 -0800
@@ -457,7 +457,7 @@ void *__vmalloc_area(struct vm_struct *a
  *	@size:		allocation size
  *	@gfp_mask:	flags for the page level allocator
  *	@prot:		protection mask for the allocated pages
- *	@node		node to use for allocation or -1
+ *	@node:		node to use for allocation or -1
  *
  *	Allocate enough pages to cover @size from the page level
  *	allocator with @gfp_mask flags.  Map them into contiguous
@@ -507,7 +507,7 @@ EXPORT_SYMBOL(vmalloc);
  *	vmalloc_node  -  allocate memory on a specific node
  *
  *	@size:		allocation size
- *	@node;		numa node
+ *	@node:		numa node
  *
  *	Allocate enough pages to cover @size from the page level
  *	allocator and map them into contiguous kernel virtual space.


---
