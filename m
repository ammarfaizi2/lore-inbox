Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVGJTyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVGJTyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVGJTlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:53 -0400
Received: from cantor2.suse.de ([195.135.220.15]:52188 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262024AbVGJTgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:19 -0400
Date: Sun, 10 Jul 2005 19:36:15 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org
Subject: [PATCH 67/82] remove linux/version.h from fs/hfsplus/
Message-ID: <20050710193615.67.QTABky4046.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

Signed-off-by: Olaf Hering <olh@suse.de>

fs/hfsplus/bnode.c      |    1 -
fs/hfsplus/dir.c        |    1 -
fs/hfsplus/extents.c    |    1 -
fs/hfsplus/hfsplus_fs.h |    1 -
fs/hfsplus/inode.c      |    1 -
fs/hfsplus/super.c      |    1 -
fs/hfsplus/wrapper.c    |    1 -
7 files changed, 7 deletions(-)

Index: linux-2.6.13-rc2-mm1/fs/hfsplus/bnode.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/hfsplus/bnode.c
+++ linux-2.6.13-rc2-mm1/fs/hfsplus/bnode.c
@@ -13,7 +13,6 @@
#include <linux/pagemap.h>
#include <linux/fs.h>
#include <linux/swap.h>
-#include <linux/version.h>

#include "hfsplus_fs.h"
#include "hfsplus_raw.h"
Index: linux-2.6.13-rc2-mm1/fs/hfsplus/dir.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/hfsplus/dir.c
+++ linux-2.6.13-rc2-mm1/fs/hfsplus/dir.c
@@ -13,7 +13,6 @@
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/random.h>
-#include <linux/version.h>

#include "hfsplus_fs.h"
#include "hfsplus_raw.h"
Index: linux-2.6.13-rc2-mm1/fs/hfsplus/extents.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/hfsplus/extents.c
+++ linux-2.6.13-rc2-mm1/fs/hfsplus/extents.c
@@ -11,7 +11,6 @@
#include <linux/errno.h>
#include <linux/fs.h>
#include <linux/pagemap.h>
-#include <linux/version.h>

#include "hfsplus_fs.h"
#include "hfsplus_raw.h"
Index: linux-2.6.13-rc2-mm1/fs/hfsplus/hfsplus_fs.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/hfsplus/hfsplus_fs.h
+++ linux-2.6.13-rc2-mm1/fs/hfsplus/hfsplus_fs.h
@@ -11,7 +11,6 @@
#define _LINUX_HFSPLUS_FS_H

#include <linux/fs.h>
-#include <linux/version.h>
#include <linux/buffer_head.h>
#include "hfsplus_raw.h"

Index: linux-2.6.13-rc2-mm1/fs/hfsplus/inode.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/hfsplus/inode.c
+++ linux-2.6.13-rc2-mm1/fs/hfsplus/inode.c
@@ -11,7 +11,6 @@
#include <linux/mm.h>
#include <linux/fs.h>
#include <linux/pagemap.h>
-#include <linux/version.h>
#include <linux/mpage.h>

#include "hfsplus_fs.h"
Index: linux-2.6.13-rc2-mm1/fs/hfsplus/super.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/hfsplus/super.c
+++ linux-2.6.13-rc2-mm1/fs/hfsplus/super.c
@@ -14,7 +14,6 @@
#include <linux/fs.h>
#include <linux/sched.h>
#include <linux/slab.h>
-#include <linux/version.h>
#include <linux/vfs.h>
#include <linux/nls.h>

Index: linux-2.6.13-rc2-mm1/fs/hfsplus/wrapper.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/hfsplus/wrapper.c
+++ linux-2.6.13-rc2-mm1/fs/hfsplus/wrapper.c
@@ -12,7 +12,6 @@
#include <linux/blkdev.h>
#include <linux/cdrom.h>
#include <linux/genhd.h>
-#include <linux/version.h>
#include <asm/unaligned.h>

#include "hfsplus_fs.h"
