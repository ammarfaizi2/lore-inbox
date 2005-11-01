Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVKAUt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVKAUt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVKAUt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:49:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16391 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751143AbVKAUt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:49:58 -0500
Date: Tue, 1 Nov 2005 21:49:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jffs-dev@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] jffs_fm.c should #include "intrep.h"
Message-ID: <20051101204954.GX8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for
it's global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/fs/jffs/jffs_fm.c.old	2005-11-01 20:25:45.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/jffs/jffs_fm.c	2005-11-01 20:26:01.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/blkdev.h>
 #include <linux/jffs.h>
 #include "jffs_fm.h"
+#include "intrep.h"
 
 #if defined(JFFS_MARK_OBSOLETE) && JFFS_MARK_OBSOLETE
 static int jffs_mark_obsolete(struct jffs_fmcontrol *fmc, __u32 fm_offset);

