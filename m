Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbULPAJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbULPAJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbULPAJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:09:18 -0500
Received: from mail.dif.dk ([193.138.115.101]:34979 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262539AbULPAG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:06:26 -0500
Date: Thu, 16 Dec 2004 01:16:55 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 7/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_fsops.c
Message-ID: <Pine.LNX.4.61.0412160115370.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_fsops.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_fsops.c	2004-10-18 23:55:06.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_fsops.c	2004-12-15 22:44:07.000000000 +0100
@@ -520,7 +520,7 @@ xfs_reserve_blocks(
 	if (inval == (__uint64_t *)NULL) {
 		outval->resblks = mp->m_resblks;
 		outval->resblks_avail = mp->m_resblks_avail;
-		return(0);
+		return 0;
 	}
 
 	request = *inval;
@@ -556,7 +556,7 @@ xfs_reserve_blocks(
 	outval->resblks = mp->m_resblks;
 	outval->resblks_avail = mp->m_resblks_avail;
 	XFS_SB_UNLOCK(mp, s);
-	return(0);
+	return 0;
 }
 
 void


