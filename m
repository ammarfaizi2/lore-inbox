Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbUJXPqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUJXPqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUJXPpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:45:30 -0400
Received: from mail.dif.dk ([193.138.115.101]:11162 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261523AbUJXPoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:44:06 -0400
Date: Sun, 24 Oct 2004 17:52:15 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH][Trivial] Small spelling fix for MODULE_SRCVERSION_ALL Kconfig
 help text
Message-ID: <Pine.LNX.4.61.0410241742380.2919@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a trivial patch fixing a small spelling error in init/Kconfig in 
the description of MODULE_SRCVERSION_ALL

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-rc1-bk2/init/Kconfig.orig linux-2.6.10-rc1-bk2/init/Kconfig
--- linux-2.6.10-rc1-bk2/init/Kconfig.orig	2004-10-24 17:39:33.000000000 +0200
+++ linux-2.6.10-rc1-bk2/init/Kconfig	2004-10-24 17:41:12.000000000 +0200
@@ -392,7 +392,7 @@
 	depends on MODULES
 	help
 	  Modules which contain a MODULE_VERSION get an extra "srcversion"
-	  field inserting into their modinfo section, which contains a
+	  field inserted into their modinfo section, which contains a
     	  sum of the source files which made it.  This helps maintainers
 	  see exactly which source was used to build a module (since
 	  others sometimes change the module source without updating


