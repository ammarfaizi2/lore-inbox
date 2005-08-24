Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVHXQzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVHXQzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVHXQzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:55:39 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:5531 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751162AbVHXQzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:55:38 -0400
Date: Wed, 24 Aug 2005 11:55:30 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, matthew@wil.cx, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org
Subject: [PATCH 07/15] parisc: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241154290.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed asm-parisc/segment.h as its not used by anything.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit e2a2b88b3c3d60b07be7908579bb772e6bd4cd01
tree f87e38b7cfa643825a937c2d4a65a042ebfe263d
parent 18c435f8b99db307732a02a07bf2099ad64174db
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:32:02 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:32:02 -0500

 include/asm-parisc/segment.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/include/asm-parisc/segment.h b/include/asm-parisc/segment.h
deleted file mode 100644
--- a/include/asm-parisc/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __PARISC_SEGMENT_H
-#define __PARISC_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif
