Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263679AbTCUSFV>; Fri, 21 Mar 2003 13:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263680AbTCUSFV>; Fri, 21 Mar 2003 13:05:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31363
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263679AbTCUSFO>; Fri, 21 Mar 2003 13:05:14 -0500
Date: Fri, 21 Mar 2003 19:20:28 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211920.h2LJKSRO025693@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: __NO_VERSION__ for used bits of dri
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_agpsupport.h linux-2.5.65-ac2/drivers/char/drm/drm_agpsupport.h
--- linux-2.5.65/drivers/char/drm/drm_agpsupport.h	2003-02-10 18:37:54.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_agpsupport.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 #include <linux/module.h>
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_auth.h linux-2.5.65-ac2/drivers/char/drm/drm_auth.h
--- linux-2.5.65/drivers/char/drm/drm_auth.h	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_auth.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 static int DRM(hash_magic)(drm_magic_t magic)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_bufs.h linux-2.5.65-ac2/drivers/char/drm/drm_bufs.h
--- linux-2.5.65/drivers/char/drm/drm_bufs.h	2003-02-10 18:38:03.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_bufs.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include <linux/vmalloc.h>
 #include "drmP.h"
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_context.h linux-2.5.65-ac2/drivers/char/drm/drm_context.h
--- linux-2.5.65/drivers/char/drm/drm_context.h	2003-02-10 18:37:54.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_context.h	2003-03-14 00:52:15.000000000 +0000
@@ -33,7 +33,6 @@
  *		needed by SiS driver's memory management.
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #if __HAVE_CTX_BITMAP
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_dma.h linux-2.5.65-ac2/drivers/char/drm/drm_dma.h
--- linux-2.5.65/drivers/char/drm/drm_dma.h	2003-02-10 18:38:44.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_dma.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #include <linux/interrupt.h>	/* For task queue support */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_drawable.h linux-2.5.65-ac2/drivers/char/drm/drm_drawable.h
--- linux-2.5.65/drivers/char/drm/drm_drawable.h	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_drawable.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 int DRM(adddraw)(struct inode *inode, struct file *filp,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_fops.h linux-2.5.65-ac2/drivers/char/drm/drm_fops.h
--- linux-2.5.65/drivers/char/drm/drm_fops.h	2003-02-10 18:38:42.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_fops.h	2003-03-14 00:52:15.000000000 +0000
@@ -30,7 +30,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 #include <linux/poll.h>
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_init.h linux-2.5.65-ac2/drivers/char/drm/drm_init.h
--- linux-2.5.65/drivers/char/drm/drm_init.h	2003-02-10 18:38:51.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_init.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #if 0
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_ioctl.h linux-2.5.65-ac2/drivers/char/drm/drm_ioctl.h
--- linux-2.5.65/drivers/char/drm/drm_ioctl.h	2003-02-10 18:38:04.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_ioctl.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_lists.h linux-2.5.65-ac2/drivers/char/drm/drm_lists.h
--- linux-2.5.65/drivers/char/drm/drm_lists.h	2003-02-10 18:38:50.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_lists.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #if __HAVE_DMA_WAITLIST
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_lock.h linux-2.5.65-ac2/drivers/char/drm/drm_lock.h
--- linux-2.5.65/drivers/char/drm/drm_lock.h	2003-02-10 18:38:44.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_lock.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 int DRM(block)(struct inode *inode, struct file *filp, unsigned int cmd,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_memory.h linux-2.5.65-ac2/drivers/char/drm/drm_memory.h
--- linux-2.5.65/drivers/char/drm/drm_memory.h	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_memory.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include "drmP.h"
 #include <linux/wrapper.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_os_linux.h linux-2.5.65-ac2/drivers/char/drm/drm_os_linux.h
--- linux-2.5.65/drivers/char/drm/drm_os_linux.h	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_os_linux.h	2003-03-14 00:52:15.000000000 +0000
@@ -1,4 +1,3 @@
-#define __NO_VERSION__
 
 #include <linux/interrupt.h>	/* For task queue support */
 #include <linux/delay.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_proc.h linux-2.5.65-ac2/drivers/char/drm/drm_proc.h
--- linux-2.5.65/drivers/char/drm/drm_proc.h	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_proc.h	2003-03-14 00:52:15.000000000 +0000
@@ -33,7 +33,6 @@
  *    the problem with the proc files not outputting all their information.
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 static int	   DRM(name_info)(char *buf, char **start, off_t offset,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_scatter.h linux-2.5.65-ac2/drivers/char/drm/drm_scatter.h
--- linux-2.5.65/drivers/char/drm/drm_scatter.h	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_scatter.h	2003-03-14 00:52:15.000000000 +0000
@@ -27,7 +27,6 @@
  *   Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/vmalloc.h>
 #include "drmP.h"
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_stub.h linux-2.5.65-ac2/drivers/char/drm/drm_stub.h
--- linux-2.5.65/drivers/char/drm/drm_stub.h	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_stub.h	2003-03-14 00:52:15.000000000 +0000
@@ -28,7 +28,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #define DRM_STUB_MAXCARDS 16	/* Enough for one machine */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/drm_vm.h linux-2.5.65-ac2/drivers/char/drm/drm_vm.h
--- linux-2.5.65/drivers/char/drm/drm_vm.h	2003-03-06 17:04:25.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/drm_vm.h	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 struct vm_operations_struct   DRM(vm_ops) = {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/gamma_dma.c linux-2.5.65-ac2/drivers/char/drm/gamma_dma.c
--- linux-2.5.65/drivers/char/drm/gamma_dma.c	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/gamma_dma.c	2003-03-14 00:52:15.000000000 +0000
@@ -29,7 +29,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include "gamma.h"
 #include "drmP.h"
 #include "drm.h"
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/i810_dma.c linux-2.5.65-ac2/drivers/char/drm/i810_dma.c
--- linux-2.5.65/drivers/char/drm/i810_dma.c	2003-02-10 18:38:18.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/i810_dma.c	2003-03-14 00:52:15.000000000 +0000
@@ -30,7 +30,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include "i810.h"
 #include "drmP.h"
 #include "drm.h"
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/mga_warp.c linux-2.5.65-ac2/drivers/char/drm/mga_warp.c
--- linux-2.5.65/drivers/char/drm/mga_warp.c	2003-02-10 18:38:29.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/mga_warp.c	2003-03-14 00:52:15.000000000 +0000
@@ -27,7 +27,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "mga.h"
 #include "drmP.h"
 #include "drm.h"
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/sis_ds.c linux-2.5.65-ac2/drivers/char/drm/sis_ds.c
--- linux-2.5.65/drivers/char/drm/sis_ds.c	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/sis_ds.c	2003-03-14 00:52:15.000000000 +0000
@@ -28,7 +28,6 @@
  * 
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/sis_mm.c linux-2.5.65-ac2/drivers/char/drm/sis_mm.c
--- linux-2.5.65/drivers/char/drm/sis_mm.c	2003-02-10 18:38:45.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/sis_mm.c	2003-03-14 00:52:15.000000000 +0000
@@ -28,7 +28,6 @@
  * 
  */
 
-#define __NO_VERSION__
 #include "sis.h"
 #include <linux/sisfb.h>
 #include "drmP.h"
