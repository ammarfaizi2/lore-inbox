Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbUJ3W3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUJ3W3R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUJ3W3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:29:16 -0400
Received: from baikonur.stro.at ([213.239.196.228]:17821 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261361AbUJ3W3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:29:08 -0400
Subject: [patch 1/2]  jbd: remove comment in journal.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sun, 31 Oct 2004 00:29:00 +0200
Message-ID: <E1CO1iX-0001KP-HR@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

Remove doubled comment, fix typo.

Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>

---

 linux-2.6.10-rc1-max/fs/jbd/journal.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

diff -puN fs/jbd/journal.c~fix-comment-fs_jbd_journal fs/jbd/journal.c
--- linux-2.6.10-rc1/fs/jbd/journal.c~fix-comment-fs_jbd_journal	2004-10-24 17:06:15.000000000 +0200
+++ linux-2.6.10-rc1-max/fs/jbd/journal.c	2004-10-24 17:06:15.000000000 +0200
@@ -1575,11 +1575,7 @@ int journal_blocks_per_page(struct inode
 }
 
 /*
- * Simple support for retying memory allocations.  Introduced to help to
- * debug different VM deadlock avoidance strategies. 
- */
-/*
- * Simple support for retying memory allocations.  Introduced to help to
+ * Simple support for retrying memory allocations.  Introduced to help to
  * debug different VM deadlock avoidance strategies. 
  */
 void * __jbd_kmalloc (const char *where, size_t size, int flags, int retry)
_
