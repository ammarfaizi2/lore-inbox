Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTBDOg4>; Tue, 4 Feb 2003 09:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTBDOg4>; Tue, 4 Feb 2003 09:36:56 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:65164 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S267265AbTBDOgz>; Tue, 4 Feb 2003 09:36:55 -0500
Date: Tue, 4 Feb 2003 15:46:23 +0100 (CET)
From: fcorneli@elis.rug.ac.be
To: linux-kernel@vger.kernel.org
Subject: slab doc fix
Message-ID: <Pine.LNX.4.44.0302041543150.1740-100000@tom.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Little fix. The kernel seems to change very fast... or is it just mine :)

--- slab.c.2.4.20	2003-02-04 15:39:49.000000000 +0100
+++ slab.c	2003-02-04 15:40:08.000000000 +0100
@@ -1731,7 +1731,7 @@
  * kmem_cache_reap - Reclaim memory from caches.
  * @gfp_mask: the type of memory required.
  *
- * Called from do_try_to_free_pages() and __alloc_pages()
+ * Called from shrink_caches()
  */
 int kmem_cache_reap (int gfp_mask)
 {

