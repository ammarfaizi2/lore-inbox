Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265236AbUFMSFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUFMSFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUFMSFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 14:05:34 -0400
Received: from mail.dif.dk ([193.138.115.101]:61347 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265236AbUFMSFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 14:05:32 -0400
Date: Sun, 13 Jun 2004 20:04:38 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH - Trivial] Documentation - NFSv3 & v4 can't both be "the
 newer version"
Message-ID: <Pine.LNX.4.56.0406131928370.5930@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the kernel help for NFSv3 & NFSv4 client support both are listed as
"the newer version ... of the NFS protocol". Obviously both can't be the
newer version at the same time, so here's a patch to correct the text in
such a way that only v4 is listed as the newer version.
Patch is against 2.6.7-rc3 - please consider including it.


--- linux-2.6.7-rc3/fs/Kconfig-orig	2004-06-13 19:26:13.000000000 +0200
+++ linux-2.6.7-rc3/fs/Kconfig	2004-06-13 19:28:32.000000000 +0200
@@ -1363,8 +1363,8 @@ config NFS_V3
 	bool "Provide NFSv3 client support"
 	depends on NFS_FS
 	help
-	  Say Y here if you want your NFS client to be able to speak the newer
-	  version 3 of the NFS protocol.
+	  Say Y here if you want your NFS client to be able to speak version
+	  3 of the NFS protocol.

 	  If unsure, say Y.


--
Jesper Juhl <juhl-lkml@dif.dk>

