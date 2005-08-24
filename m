Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVHXRAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVHXRAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVHXRAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:00:06 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:1685 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751182AbVHXRAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:00:04 -0400
Date: Wed, 24 Aug 2005 11:59:54 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, lethal@linux-sh.org, linux-sh@m17n.org,
       kkojima@rr.iij4u.or.jp
Subject: [PATCH 12/15] sh: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241159050.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed asm-sh/segment.h as its not used by anything.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit ab81566ace65ac748c885d696c11b5ae839fb328
tree e36ec9a52dc26db8bc20e1c57a9dce5e2b58fd39
parent e2a2b88b3c3d60b07be7908579bb772e6bd4cd01
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:32:48 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:32:48 -0500

 include/asm-sh/segment.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/include/asm-sh/segment.h b/include/asm-sh/segment.h
deleted file mode 100644
--- a/include/asm-sh/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_SH_SEGMENT_H
-#define __ASM_SH_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif /* __ASM_SH_SEGMENT_H */
