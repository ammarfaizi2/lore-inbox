Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbULPA4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbULPA4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbULPAzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:55:40 -0500
Received: from mail.dif.dk ([193.138.115.101]:61092 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262551AbULPAax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:30:53 -0500
Date: Thu, 16 Dec 2004 01:41:21 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 27/30] return statement cleanup - kill pointless parentheses
 in kernel/panic.c
Message-ID: <Pine.LNX.4.61.0412160140380.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
kernel/panic.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/kernel/panic.c	2004-12-06 22:24:56.000000000 +0100
+++ linux-2.6.10-rc3-bk8/kernel/panic.c	2004-12-15 23:58:34.000000000 +0100
@@ -148,7 +148,7 @@ const char *print_tainted(void)
 	}
 	else
 		snprintf(buf, sizeof(buf), "Not tainted");
-	return(buf);
+	return buf;
 }
 
 void add_taint(unsigned flag)



