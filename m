Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVAJSwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVAJSwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVAJSu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:50:28 -0500
Received: from coderock.org ([193.77.147.115]:55740 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262435AbVAJSpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:45:43 -0500
Subject: [patch 5/5] fs/super.c: docbook comment fix
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Mon, 10 Jan 2005 19:45:36 +0100
Message-Id: <20050110184537.4FDBF1F1ED@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Parameter name in comment was wrong.

Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/fs/super.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/super.c~docs-fs_super fs/super.c
--- kj/fs/super.c~docs-fs_super	2005-01-10 18:00:27.000000000 +0100
+++ kj-domen/fs/super.c	2005-01-10 18:00:27.000000000 +0100
@@ -143,7 +143,7 @@ int __put_super_and_need_restart(struct 
 
 /**
  *	put_super	-	drop a temporary reference to superblock
- *	@s: superblock in question
+ *	@sb: superblock in question
  *
  *	Drops a temporary reference, frees superblock if there's no
  *	references left.
_
