Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268002AbUHEWtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268002AbUHEWtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268006AbUHEWtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:49:45 -0400
Received: from mail.dif.dk ([193.138.115.101]:57489 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268002AbUHEWtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:49:41 -0400
Date: Fri, 6 Aug 2004 00:54:26 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6][Trivial] NFS Kconfig description correction
Message-ID: <Pine.LNX.4.60.0408060046170.2538@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a resend of a trivial patch I've submitted earlier.

In the kernel help for NFSv3 & NFSv4 client support both are listed as 
"the newer version ... of the NFS protocol". 
Obviously both can't be the newer version at the same time, so here's a 
patch to correct the text in such a way that only v4 is listed as the 
newer version. Patch is against 2.6.8-rc3-mm1 - please consider applying.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.8-rc3-mm1-orig/fs/Kconfig linux-2.6.8-rc3-mm1/fs/Kconfig
--- linux-2.6.8-rc3-mm1-orig/fs/Kconfig	2004-08-05 21:51:38.000000000 +0200
+++ linux-2.6.8-rc3-mm1/fs/Kconfig	2004-08-05 21:55:26.000000000 +0200
@@ -1358,8 +1358,8 @@ config NFS_V3
 	bool "Provide NFSv3 client support"
 	depends on NFS_FS
 	help
-	  Say Y here if you want your NFS client to be able to speak the newer
-	  version 3 of the NFS protocol.
+	  Say Y here if you want your NFS client to be able to speak version
+	  3 of the NFS protocol.
 
 	  If unsure, say Y.
 


