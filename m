Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbULPADz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbULPADz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbULPADx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:03:53 -0500
Received: from mail.dif.dk ([193.138.115.101]:23203 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262330AbULPABx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:01:53 -0500
Date: Thu, 16 Dec 2004 01:12:23 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 4/30] return statement cleanup - kill pointless parentheses
 in fs/efs/inode.c
Message-ID: <Pine.LNX.4.61.0412160109370.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/efs/inode.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/efs/inode.c	2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/efs/inode.c	2004-12-15 22:33:18.000000000 +0100
@@ -183,7 +183,7 @@ efs_extent_check(efs_extent *ptr, efs_bl
 	offset = ptr->cooked.ex_offset;
 
 	if ((block >= offset) && (block < offset+length)) {
-		return(sb->fs_start + start + block - offset);
+		return (sb->fs_start + start + block - offset);
 	} else {
 		return 0;
 	}


