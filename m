Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVHXQsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVHXQsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVHXQsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:48:39 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:37016 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751150AbVHXQsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:48:38 -0400
Date: Wed, 24 Aug 2005 11:48:27 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, spyro@f2s.com
Subject: [PATCH 02/15] arm26: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241147250.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed ARM26 architecture specific users of asm/segment.h and
asm-alpha/segment.h itself.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 1d8c8bf789b6925529d84f3ad787cf973763793f
tree 8b009fca0a2f15ac71e72f09d16330990609c4bc
parent 19150fe1698293dc2c4f4f48c6b05d83595544e6
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:40:11 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:40:11 -0500

 arch/arm26/mm/init.c        |    1 -
 include/asm-arm26/segment.h |   11 -----------
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm26/mm/init.c b/arch/arm26/mm/init.c
--- a/arch/arm26/mm/init.c
+++ b/arch/arm26/mm/init.c
@@ -24,7 +24,6 @@
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 
-#include <asm/segment.h>
 #include <asm/mach-types.h>
 #include <asm/dma.h>
 #include <asm/hardware.h>
diff --git a/include/asm-arm26/segment.h b/include/asm-arm26/segment.h
deleted file mode 100644
--- a/include/asm-arm26/segment.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __ASM_ARM_SEGMENT_H
-#define __ASM_ARM_SEGMENT_H
-
-#define __KERNEL_CS   0x0
-#define __KERNEL_DS   0x0
-
-#define __USER_CS     0x1
-#define __USER_DS     0x1
-
-#endif /* __ASM_ARM_SEGMENT_H */
-
