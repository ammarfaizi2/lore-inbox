Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVFSThh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVFSThh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 15:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVFSThh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 15:37:37 -0400
Received: from mail.dif.dk ([193.138.115.101]:64696 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261205AbVFSThc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 15:37:32 -0400
Date: Sun, 19 Jun 2005 21:42:56 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] modules, small codingstyle cleanup, one statement/expression
 pr line
Message-ID: <Pine.LNX.4.62.0506192138110.2832@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small patch to make kernel/module.c a little more readable and a little 
more CodingStyle conforming.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 kernel/module.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.12-orig/kernel/module.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/kernel/module.c	2005-06-19 21:24:26.000000000 +0200
@@ -1731,8 +1731,10 @@ static struct module *load_module(void _
 	kfree(args);
  free_hdr:
 	vfree(hdr);
-	if (err < 0) return ERR_PTR(err);
-	else return ptr;
+	if (err < 0)
+		return ERR_PTR(err);
+	else
+		return ptr;
 
  truncated:
 	printk(KERN_ERR "Module len %lu truncated\n", len);



