Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUHNSyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUHNSyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 14:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUHNSyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 14:54:25 -0400
Received: from verein.lst.de ([213.95.11.210]:43951 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264571AbUHNSyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 14:54:24 -0400
Date: Sat, 14 Aug 2004 20:54:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove dead CONFIG_KERNEL_ELF Kconfig entry
Message-ID: <20040814185419.GA29000@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't allow non-ELF kernels since 2.0 days, and surprisingly this
is not actually checked anywhere.


--- 1.73/arch/ppc/Kconfig	2004-07-02 07:23:46 +02:00
+++ edited/arch/ppc/Kconfig	2004-07-04 00:21:37 +02:00
@@ -799,10 +799,6 @@
 config HIGHMEM
 	bool "High memory support"
 
-config KERNEL_ELF
-	bool
-	default y
-
 source "fs/Kconfig.binfmt"
 
 config PROC_DEVICETREE
