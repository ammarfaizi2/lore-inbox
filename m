Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263098AbUKTCzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbUKTCzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbUKTCtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:49:50 -0500
Received: from baikonur.stro.at ([213.239.196.228]:20711 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263091AbUKTCq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:46:59 -0500
Subject: [patch 2/4]  jbd: remove comment in journal.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:46:57 +0100
Message-ID: <E1CVLH7-0002Rg-Op@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

Remove doubled comment, fix typo.

Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>

---

 linux-2.6.10-rc2-bk4-max/fs/jbd/journal.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

diff -puN fs/jbd/journal.c~fix-comment-fs_jbd_journal fs/jbd/journal.c
--- linux-2.6.10-rc2-bk4/fs/jbd/journal.c~fix-comment-fs_jbd_journal	2004-11-20 00:29:48.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/fs/jbd/journal.c	2004-11-20 00:29:48.000000000 +0100
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
