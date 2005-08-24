Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVHXQ7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVHXQ7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVHXQ7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:59:24 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:43156 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751181AbVHXQ7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:59:23 -0400
Date: Wed, 24 Aug 2005 11:59:03 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, lethal@linux-sh.org, rc@rc0.org.uk,
       linuxsh-shmedia-dev@lists.sourceforge.net
Subject: [PATCH 11/15] sh64: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241158100.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed asm-sh64/segment.h as its not used by anything.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 36b349eaba7a399c06219d3553d571261dbf6333
tree 5ac502496f084585407bf5d8fd9040a489525edf
parent ab81566ace65ac748c885d696c11b5ae839fb328
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:33:32 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:33:32 -0500

 include/asm-sh64/segment.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/include/asm-sh64/segment.h b/include/asm-sh64/segment.h
deleted file mode 100644
--- a/include/asm-sh64/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_SEGMENT_H
-#define _ASM_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif /* _ASM_SEGMENT_H */
