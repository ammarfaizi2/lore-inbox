Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbUB1UIW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 15:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUB1UIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 15:08:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46570 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261909AbUB1UIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 15:08:20 -0500
Date: Sat, 28 Feb 2004 21:08:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small doc fix for CONFIG_SWAP (fwd)
Message-ID: <20040228200813.GO5499@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

the trivial patch forwarded below still applies against 2.6.3-mm4.

Please apply
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Wed, 21 Jan 2004 00:17:18 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small doc fix for CONFIG_SWAP

"swap" is more known than "Support for paging of anonymous memory".
The patch below adds "(swap)" to the prompt of CONFIG_SWAP.

Please apply
Adrian


--- linux-2.6.1-mm5/init/Kconfig.old	2004-01-21 00:10:59.000000000 +0100
+++ linux-2.6.1-mm5/init/Kconfig	2004-01-21 00:11:10.000000000 +0100
@@ -66,7 +66,7 @@
 menu "General setup"
 
 config SWAP
-	bool "Support for paging of anonymous memory"
+	bool "Support for paging of anonymous memory (swap)"
 	depends on MMU
 	default y
 	help
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

