Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVAMPdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVAMPdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVAMPb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:31:29 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:54020 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261653AbVAMPbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:31:01 -0500
Subject: [patch 4/8] uml: drop unused buffer_head.h header from hostfs
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 06:13:32 +0100
Message-Id: <20050113051332.4F4AA6324F@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Drop that header inclusion - I discovered this header was unused while
checking whether I can use the __set_page_dirty_nobuffers speedup suggested by
Andrew Morton.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-drop-buffer_head-header-from-hostfs fs/hostfs/hostfs_kern.c
--- linux-2.6.11/fs/hostfs/hostfs_kern.c~uml-drop-buffer_head-header-from-hostfs	2005-01-13 01:57:47.533076768 +0100
+++ linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c	2005-01-13 01:57:47.564072056 +0100
@@ -15,7 +15,6 @@
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 #include <linux/list.h>
-#include <linux/buffer_head.h>
 #include <linux/root_dev.h>
 #include <linux/statfs.h>
 #include <linux/kdev_t.h>
_
