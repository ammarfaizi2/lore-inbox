Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbTHTIDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTHTICQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:02:16 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:39629 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261792AbTHTIBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:01:47 -0400
Date: Wed, 20 Aug 2003 18:02:56 +1000
Message-Id: <200308200802.h7K82uDd011712@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 9/16] C99: 2.6.0-t3-bk7/arch/ppc
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/arch/ppc/syslib/of_device.c linux/arch/ppc/syslib/of_device.c
--- linux.backup/arch/ppc/syslib/of_device.c	Tue Aug 19 20:56:52 2003
+++ linux/arch/ppc/syslib/of_device.c	Wed Aug 20 16:40:22 2003
@@ -52,8 +52,8 @@
 }
 
 struct bus_type of_platform_bus_type = {
-       name:	"of_platform",
-       match:	of_platform_bus_match,
+       .name	= "of_platform",
+       .match	= of_platform_bus_match,
 };
 
 static int __init
