Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUGGOwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUGGOwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 10:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUGGOww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 10:52:52 -0400
Received: from verein.lst.de ([212.34.189.10]:6582 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265195AbUGGOwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 10:52:51 -0400
Date: Wed, 7 Jul 2004 16:52:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill CONFIG_KERNEL_ELF
Message-ID: <20040707145246.GA13846@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, paulus@samba.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember we had that in the 2.0-aera, but these days no one checks it
at all.


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
