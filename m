Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbUJZSg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUJZSg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUJZSg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:36:26 -0400
Received: from mail.dif.dk ([193.138.115.101]:45474 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261384AbUJZSgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:36:17 -0400
Date: Tue, 26 Oct 2004 20:44:35 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: netdev <netdev@oss.sgi.com>,
       Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH][Doc][Trivial] fix spelling error related to IPComp help in
 Kconfig
Message-ID: <Pine.LNX.4.61.0410262038040.3277@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Small patch that fixes a spelling error (Payload misspelled as Paylod)in 
the IPComp help text in Kconfig (also expands the text to "IP Payload 
Compression Protocol (IPComp)" which is the title of RFC3173).
Please consider applying.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -urp linux-2.6.10-rc1-bk5-orig/net/ipv4/Kconfig linux-2.6.10-rc1-bk5/net/ipv4/Kconfig
--- linux-2.6.10-rc1-bk5-orig/net/ipv4/Kconfig	2004-10-18 23:54:55.000000000 +0200
+++ linux-2.6.10-rc1-bk5/net/ipv4/Kconfig	2004-10-26 20:30:35.000000000 +0200
@@ -331,8 +331,8 @@ config INET_IPCOMP
 	select CRYPTO
 	select CRYPTO_DEFLATE
 	---help---
-	  Support for IP Paylod Compression (RFC3173), typically needed
-	  for IPsec.
+	  Support for IP Payload Compression Protocol (IPComp) (RFC3173),
+	  typically needed for IPsec.
 	  
 	  If unsure, say Y.
 
diff -urp linux-2.6.10-rc1-bk5-orig/net/ipv6/Kconfig linux-2.6.10-rc1-bk5/net/ipv6/Kconfig
--- linux-2.6.10-rc1-bk5-orig/net/ipv6/Kconfig	2004-10-18 23:54:08.000000000 +0200
+++ linux-2.6.10-rc1-bk5/net/ipv6/Kconfig	2004-10-26 20:31:19.000000000 +0200
@@ -52,8 +52,8 @@ config INET6_IPCOMP
 	select CRYPTO
 	select CRYPTO_DEFLATE
 	---help---
-	  Support for IP Paylod Compression (RFC3173), typically needed
-	  for IPsec.
+	  Support for IP Payload Compression Protocol (IPComp) (RFC3173),
+	  typically needed for IPsec.
 
 	  If unsure, say Y.
 

