Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbULVW0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbULVW0N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 17:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbULVW0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 17:26:13 -0500
Received: from mail.dif.dk ([193.138.115.101]:3800 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262068AbULVW0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 17:26:01 -0500
Date: Wed, 22 Dec 2004 23:36:45 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: PATCH] m32r: add missing Kconfig help text
Message-ID: <Pine.LNX.4.61.0412222335360.3497@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's no help text for CONFIG_DEBUG_STACKOVERFLOW - add one.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk15-orig/arch/m32r/Kconfig.debug	2004-12-06 22:24:16.000000000 +0100
+++ linux-2.6.10-rc3-bk15/arch/m32r/Kconfig.debug	2004-12-22 23:28:32.000000000 +0100
@@ -5,6 +5,9 @@
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
+	help
+	  This option will cause messages to be printed if free stack space
+	  drops below a certain limit.
 
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"


