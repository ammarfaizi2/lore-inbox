Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVAJWHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVAJWHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVAJWHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:07:05 -0500
Received: from mail.dif.dk ([193.138.115.101]:43210 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262703AbVAJWDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:03:20 -0500
Date: Mon, 10 Jan 2005 23:05:49 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: [patch] remove bouncing email address of Olaf Kirch
Message-ID: <Pine.LNX.4.61.0501102259090.2987@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The email address for Olaf Kirch listed in net/sunrpc/auth.c bounces, so 
remove it and leave just the name. He's listed with the same email in 
CREDITS, should the address stay or would a patch to remove it there as 
well be appreciated?  I've been unable to find a working address for him 
(if someone knows of one, then changing the address would probably be 
better), and it doesn't seem logical to keep bouncing addresses around.  
What's the general opinion on this?


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk13-orig/net/sunrpc/auth.c linux-2.6.10-bk13/net/sunrpc/auth.c
--- linux-2.6.10-bk13-orig/net/sunrpc/auth.c	2005-01-10 22:09:22.000000000 +0100
+++ linux-2.6.10-bk13/net/sunrpc/auth.c	2005-01-10 22:59:03.000000000 +0100
@@ -3,7 +3,7 @@
  *
  * Generic RPC client authentication API.
  *
- * Copyright (C) 1996, Olaf Kirch <okir@monad.swb.de>
+ * Copyright (C) 1996, Olaf Kirch
  */
 
 #include <linux/types.h>
 


