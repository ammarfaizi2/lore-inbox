Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVHXQyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVHXQyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVHXQyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:54:47 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:43757 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751177AbVHXQyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:54:46 -0400
Date: Wed, 24 Aug 2005 11:54:27 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, ralf@linux-mips.org,
       linux-mips@linux-mips.org
Subject: [PATCH 06/15] mips: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241153260.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed MIPS architecture specific users of asm/segment.h and
asm-mips/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 8f20e153d5d5c3efd95835e814fae7b3ccbfcd08
tree 17e9ae88b3fe1762302179a4ea08e61360805a29
parent 503a812c1f9cef08e6f96b2b2cf1f32bbfef2bc6
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:59:09 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:59:09 -0500

 arch/mips/au1000/db1x00/mirage_ts.c |    1 -
 include/asm-mips/segment.h          |    6 ------
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/mips/au1000/db1x00/mirage_ts.c b/arch/mips/au1000/db1x00/mirage_ts.c
--- a/arch/mips/au1000/db1x00/mirage_ts.c
+++ b/arch/mips/au1000/db1x00/mirage_ts.c
@@ -44,7 +44,6 @@
 #include <linux/smp_lock.h>
 #include <linux/wait.h>
 
-#include <asm/segment.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/delay.h>
diff --git a/include/asm-mips/segment.h b/include/asm-mips/segment.h
deleted file mode 100644
--- a/include/asm-mips/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_SEGMENT_H
-#define _ASM_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif /* _ASM_SEGMENT_H */
