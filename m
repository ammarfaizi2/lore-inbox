Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVHXQvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVHXQvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVHXQvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:51:09 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:13721 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751153AbVHXQvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:51:08 -0400
Date: Wed, 24 Aug 2005 11:50:38 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, rmk@arm.linux.org.uk
Subject: [PATCH 03/15] arm: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241148330.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed asm-arm/segment.h as its not used by anything.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 13e9876eff93029eb24affd8842db94035c370f5
tree acb6c189dd89aef958961eedba5641449865c5aa
parent 1d8c8bf789b6925529d84f3ad787cf973763793f
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:42:30 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:42:30 -0500

 include/asm-arm/segment.h |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/include/asm-arm/segment.h b/include/asm-arm/segment.h
deleted file mode 100644
--- a/include/asm-arm/segment.h
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
