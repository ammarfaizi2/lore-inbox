Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVAJTfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVAJTfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVAJStU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:49:20 -0500
Received: from coderock.org ([193.77.147.115]:53692 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262427AbVAJSph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:45:37 -0500
Subject: [patch 3/5] jbd: remove comment in journal.c
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Mon, 10 Jan 2005 19:45:30 +0100
Message-Id: <20050110184531.323671F1ED@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

Remove doubled comment, fix typo.

Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/fs/jbd/journal.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

diff -puN fs/jbd/journal.c~fix-comment-fs_jbd_journal fs/jbd/journal.c
--- kj/fs/jbd/journal.c~fix-comment-fs_jbd_journal	2005-01-10 18:00:21.000000000 +0100
+++ kj-domen/fs/jbd/journal.c	2005-01-10 18:00:21.000000000 +0100
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
