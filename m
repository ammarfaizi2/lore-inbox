Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTHTH6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 03:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTHTH6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:58:24 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:14029 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261763AbTHTH6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:58:20 -0400
Date: Wed, 20 Aug 2003 17:59:26 +1000
Message-Id: <200308200759.h7K7xQ4U011622@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/16] C99: 2.6.0-t3-bk7/arch/alpha
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/arch/alpha/kernel/core_titan.c linux/arch/alpha/kernel/core_titan.c
--- linux.backup/arch/alpha/kernel/core_titan.c	Wed Aug 20 16:38:52 2003
+++ linux/arch/alpha/kernel/core_titan.c	Wed Aug 20 16:40:22 2003
@@ -717,12 +717,12 @@
 
 struct alpha_agp_ops titan_agp_ops =
 {
-	setup:		titan_agp_setup,
-	cleanup:	titan_agp_cleanup,
-	configure:	titan_agp_configure,
-	bind:		titan_agp_bind_memory,
-	unbind:		titan_agp_unbind_memory,
-	translate:	titan_agp_translate
+	.setup		= titan_agp_setup,
+	.cleanup	= titan_agp_cleanup,
+	.configure	= titan_agp_configure,
+	.bind		= titan_agp_bind_memory,
+	.unbind		= titan_agp_unbind_memory,
+	.translate	= titan_agp_translate
 };
 
 alpha_agp_info *
