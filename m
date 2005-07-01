Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVGAVzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVGAVzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVGAVzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:55:36 -0400
Received: from mail.dif.dk ([193.138.115.101]:59289 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262765AbVGAVzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:55:17 -0400
Date: Sat, 2 Jul 2005 00:01:20 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       trivial@rustcorp.com.au
Subject: [PATCH] Spelling fix for connector Kconfig entry
Message-ID: <Pine.LNX.4.62.0507012356450.2664@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a small spelling error in drivers/connector/Kconfig

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/connector/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.13-rc1-mm1-orig/drivers/connector/Kconfig	2005-07-01 23:46:15.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/connector/Kconfig	2005-07-01 23:55:09.000000000 +0200
@@ -18,8 +18,8 @@
 	  It adds a connector in kernel/exit.c:do_exit() function. When a exit
 	  occurs, netlink is used to transfer information about the process and
 	  its parent. This information can be used by a user space application.
-	  The exit connector can be enable/disable by sending a message to the
-	  connector with the corresponding group id.
+	  The exit connector can be enabled/disabled by sending a message to
+	  the connector with the corresponding group id.
 
 config FORK_CONNECTOR
 	bool "Enable fork connector"


