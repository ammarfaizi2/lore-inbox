Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbUKTFCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbUKTFCK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUKTCjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:39:20 -0500
Received: from baikonur.stro.at ([213.239.196.228]:32417 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S262858AbUKTC32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:29:28 -0500
Subject: [patch 1/8]  fs/super.c: docbook comment fix
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:29:26 +0100
Message-ID: <E1CVL0B-0000Np-5D@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Parameter name in comment was wrong.

Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc2-bk4-max/fs/super.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/super.c~docs-fs_super fs/super.c
--- linux-2.6.10-rc2-bk4/fs/super.c~docs-fs_super	2004-11-20 03:04:39.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/fs/super.c	2004-11-20 03:04:39.000000000 +0100
@@ -141,7 +141,7 @@ int __put_super_and_need_restart(struct 
 
 /**
  *	put_super	-	drop a temporary reference to superblock
- *	@s: superblock in question
+ *	@sb: superblock in question
  *
  *	Drops a temporary reference, frees superblock if there's no
  *	references left.
_
