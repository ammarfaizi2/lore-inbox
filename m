Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265860AbUATXS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265867AbUATXS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:18:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29411 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265860AbUATXR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:17:26 -0500
Date: Wed, 21 Jan 2004 00:17:18 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small doc fix for CONFIG_SWAP
Message-ID: <20040120231718.GB6441@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
