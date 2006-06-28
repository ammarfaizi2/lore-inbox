Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWF1RCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWF1RCY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWF1Q7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:59:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42756 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751451AbWF1QzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:08 -0400
Date: Wed, 28 Jun 2006 18:55:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typo fixes: disadvantadge -> disadvantage
Message-ID: <20060628165507.GY13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/arm/IXP4xx         |    2 +-
 include/asm-arm/arch-ixp4xx/io.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm3-full/Documentation/arm/IXP4xx.old	2006-06-27 20:44:39.000000000 +0200
+++ linux-2.6.17-mm3-full/Documentation/arm/IXP4xx	2006-06-27 20:44:58.000000000 +0200
@@ -85,7 +85,7 @@
 2) If > 64MB of memory space is required, the IXP4xx can be 
    configured to use indirect registers to access PCI This allows 
    for up to 128MB (0x48000000 to 0x4fffffff) of memory on the bus. 
-   The disadvantadge of this is that every PCI access requires 
+   The disadvantage of this is that every PCI access requires 
    three local register accesses plus a spinlock, but in some 
    cases the performance hit is acceptable. In addition, you cannot 
    mmap() PCI devices in this case due to the indirect nature
--- linux-2.6.17-mm3-full/include/asm-arm/arch-ixp4xx/io.h.old	2006-06-27 20:45:06.000000000 +0200
+++ linux-2.6.17-mm3-full/include/asm-arm/arch-ixp4xx/io.h	2006-06-27 20:45:09.000000000 +0200
@@ -38,7 +38,7 @@
  * 2) If > 64MB of memory space is required, the IXP4xx can be configured
  *    to use indirect registers to access PCI (as we do below for I/O
  *    transactions). This allows for up to 128MB (0x48000000 to 0x4fffffff)
- *    of memory on the bus. The disadvantadge of this is that every 
+ *    of memory on the bus. The disadvantage of this is that every 
  *    PCI access requires three local register accesses plus a spinlock,
  *    but in some cases the performance hit is acceptable. In addition,
  *    you cannot mmap() PCI devices in this case.

