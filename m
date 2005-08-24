Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVHXRCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVHXRCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVHXRCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:02:45 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:18590 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751201AbVHXRCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:02:44 -0400
Date: Wed, 24 Aug 2005 12:02:39 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, chris@zankel.net
Subject: [PATCH 15/15] xtensa: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241201570.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed asm-xtensa/segment.h as its not used by anything.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 51e70a5236bf8f2f30f1a86513c18e05e3cb6fee
tree 57c39eaf3761a71b9d78c25893f7696fdc703915
parent 36b349eaba7a399c06219d3553d571261dbf6333
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:37:29 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:37:29 -0500

 include/asm-xtensa/segment.h |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/include/asm-xtensa/segment.h b/include/asm-xtensa/segment.h
deleted file mode 100644
--- a/include/asm-xtensa/segment.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * include/asm-xtensa/segment.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-
-#ifndef _XTENSA_SEGMENT_H
-#define _XTENSA_SEGMENT_H
-
-#include <asm/uaccess.h>
-
-#endif	/* _XTENSA_SEGEMENT_H */
