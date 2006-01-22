Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWAVEhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWAVEhE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 23:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWAVEhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 23:37:04 -0500
Received: from xenotime.net ([66.160.160.81]:43231 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751257AbWAVEhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 23:37:02 -0500
Date: Sat, 21 Jan 2006 20:37:09 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: tali@admingilde.org, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/slab: add kernel-doc for one function
Message-Id: <20060121203709.76613d31.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc for calculate_slab_order().

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 mm/slab.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

--- linux-2616-rc1-secur.orig/mm/slab.c
+++ linux-2616-rc1-secur/mm/slab.c
@@ -1490,8 +1490,13 @@ static inline void set_up_list3s(kmem_ca
 }
 
 /**
- * calculate_slab_order - calculate size (page order) of slabs and the number
- *                        of objects per slab.
+ * calculate_slab_order - calculate size (page order) of slabs
+ * @cachep: pointer to the cache that is being created
+ * @size: size of objects to be created in this cache.
+ * @align: required alignment for the objects.
+ * @flags: slab allocation flags
+ *
+ * Also calculates the number of objects per slab.
  *
  * This could be made much more intelligent.  For now, try to avoid using
  * high order pages for slabs.  When the gfp() functions are more friendly


---
