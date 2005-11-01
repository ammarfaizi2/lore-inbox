Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVKANVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVKANVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVKANVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:21:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11538 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750737AbVKANVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:21:47 -0500
Date: Tue, 1 Nov 2005 14:21:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: hch@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/freevxfs/: add #include's
Message-ID: <20051101132143.GM8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for
it's global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/freevxfs/vxfs_bmap.c |    1 +
 fs/freevxfs/vxfs_olt.c  |    1 +
 2 files changed, 2 insertions(+)

--- linux-2.6.14-rc5-mm1-full/fs/freevxfs/vxfs_bmap.c.old	2005-10-31 17:30:47.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/freevxfs/vxfs_bmap.c	2005-10-31 17:31:02.000000000 +0100
@@ -36,6 +36,7 @@
 
 #include "vxfs.h"
 #include "vxfs_inode.h"
+#include "vxfs_extern.h"
 
 
 #ifdef DIAGNOSTIC
--- linux-2.6.14-rc5-mm1-full/fs/freevxfs/vxfs_olt.c.old	2005-10-31 17:31:20.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/freevxfs/vxfs_olt.c	2005-10-31 17:38:42.000000000 +0100
@@ -36,6 +36,7 @@
 
 #include "vxfs.h"
 #include "vxfs_olt.h"
+#include "vxfs_extern.h"
 
 
 static inline void

