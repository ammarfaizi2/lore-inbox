Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUE3IKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUE3IKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 04:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUE3IKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 04:10:41 -0400
Received: from verein.lst.de ([212.34.189.10]:32658 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261443AbUE3IKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 04:10:40 -0400
Date: Sun, 30 May 2004 10:10:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: ambx1@neo.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pnpbios only makes sense for X86
Message-ID: <20040530081034.GA30736@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, ambx1@neo.rr.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the Debian kernel package


--- kernel-source-2.6.6/drivers/pnp/pnpbios/Kconfig	2004-03-11 13:55:37.000000000 +1100
+++ kernel-source-2.6.6-1/drivers/pnp/pnpbios/Kconfig	2004-02-19 20:55:53.000000000 +1100
@@ -3,7 +3,7 @@
 #
 config PNPBIOS
 	bool "Plug and Play BIOS support (EXPERIMENTAL)"
-	depends on PNP && EXPERIMENTAL
+	depends on PNP && X86 && EXPERIMENTAL
 	---help---
 	  Linux uses the PNPBIOS as defined in "Plug and Play BIOS
 	  Specification Version 1.0A May 5, 1994" to autodetect built-in
