Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbULPBFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbULPBFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbULPBDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:03:10 -0500
Received: from mail.dif.dk ([193.138.115.101]:34724 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262546AbULPAYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:24:03 -0500
Date: Thu, 16 Dec 2004 01:34:29 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 20/30] return statement cleanup - kill pointless parentheses
 in fs/coda/dir.c
Message-ID: <Pine.LNX.4.61.0412160133370.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/coda/dir.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/coda/dir.c	2004-10-18 23:53:21.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/coda/dir.c	2004-12-15 23:48:48.000000000 +0100
@@ -349,7 +349,7 @@ static int coda_link(struct dentry *sour
         
 out:
 	unlock_kernel();
-	return(error);
+	return error;
 }
 
 

