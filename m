Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbSKSSoj>; Tue, 19 Nov 2002 13:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbSKSSn7>; Tue, 19 Nov 2002 13:43:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:15232 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267187AbSKSSnM>;
	Tue, 19 Nov 2002 13:43:12 -0500
Date: Tue, 19 Nov 2002 10:50:15 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Remove unused function from radeon_mem.c
Message-ID: <20021119185015.GG1986@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/char/drm/radeon_mem.c b/drivers/char/drm/radeon_mem.c
--- a/drivers/char/drm/radeon_mem.c	Tue Nov 19 10:31:17 2002
+++ b/drivers/char/drm/radeon_mem.c	Tue Nov 19 10:31:17 2002
@@ -130,16 +130,6 @@
 	}
 }
 
-static void print_heap( struct mem_block *heap )
-{
-	struct mem_block *p;
-
-	for (p = heap->next ; p != heap ; p = p->next) 
-		DRM_DEBUG("0x%x..0x%x (0x%x) -- owner %d\n",
-			  p->start, p->start + p->size,
-			  p->size, p->pid);
-}
-
 /* Initialize.  How to check for an uninitialized heap?
  */
 static int init_heap(struct mem_block **heap, int start, int size)

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
