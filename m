Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbUKOL7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUKOL7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 06:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbUKOL7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 06:59:16 -0500
Received: from hera.cwi.nl ([192.16.191.8]:14798 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261575AbUKOL6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 06:58:55 -0500
Date: Mon, 15 Nov 2004 12:58:44 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200411151158.iAFBwi613920@apps.cwi.nl>
To: akpm@osdl.org, hch@lst.de, torvalds@osdl.org
Subject: [PATCH] appletalk Makefile
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no dev.c in net/appletalk.

diff -uprN -X /linux/dontdiff a/net/appletalk/Makefile b/net/appletalk/Makefile
--- a/net/appletalk/Makefile	2004-11-15 11:44:20.000000000 +0100
+++ b/net/appletalk/Makefile	2004-11-15 12:47:12.000000000 +0100
@@ -4,6 +4,6 @@
 
 obj-$(CONFIG_ATALK) += appletalk.o
 
-appletalk-y			:= aarp.o ddp.o dev.o
+appletalk-y			:= aarp.o ddp.o
 appletalk-$(CONFIG_PROC_FS)	+= atalk_proc.o
 appletalk-$(CONFIG_SYSCTL)	+= sysctl_net_atalk.o
