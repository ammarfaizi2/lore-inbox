Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424351AbWKPVjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424351AbWKPVjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424659AbWKPVjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:39:10 -0500
Received: from v813.rev.tld.pl ([195.149.226.213]:39339 "EHLO
	smtp.host4.kei.pl") by vger.kernel.org with ESMTP id S1424351AbWKPVjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:39:09 -0500
X-clamdmail: clamdmail 0.18a
From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] trivial change for mmc/Kconfig: MMC_PXA does not mean only PXA255
Date: Thu, 16 Nov 2006 22:39:10 +0100
User-Agent: KMail/1.9.5
Cc: Pierre Ossman <drzeus-list@drzeus.cx>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       linux-arm-kernel@lists.arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611162239.12391.openembedded@hrw.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PXA MMC driver supports not only PXA255 but also PXA250 and newer ones

Signed-off-by: Marcin Juszkiewicz <hrw@openembedded.org>

Index: linux/drivers/mmc/Kconfig
===================================================================
--- linux.orig/drivers/mmc/Kconfig      2006-11-16 22:30:31.370992028 +0100
+++ linux/drivers/mmc/Kconfig   2006-11-16 22:31:13.614547509 +0100
 -40,7 +40,7 @@
          If unsure, say N.

 config MMC_PXA
-       tristate "Intel PXA255 Multimedia Card Interface support"
+       tristate "Intel PXA25x/26x/27x Multimedia Card Interface support"
        depends on ARCH_PXA && MMC
        help
          This selects the Intel(R) PXA(R) Multimedia card Interface.

-- 
JID: hrw-jabber.org
OpenEmbedded developer/consultant

              whats mean ubuntu?
              it's african word for "can't configure debian"


