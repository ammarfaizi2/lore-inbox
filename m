Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVGJU5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVGJU5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVGJTk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:40:57 -0400
Received: from ns.suse.de ([195.135.220.2]:60306 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261234AbVGJTf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:28 -0400
Date: Sun, 10 Jul 2005 19:35:27 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: kai.germaschewski@gmx.de, kkeil@suse.de
Subject: [PATCH 19/82] remove linux/version.h from drivers/isdn
Message-ID: <20050710193527.19.GyblpJ2784.2247.olh@nectarine.suse.de>
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

drivers/isdn/divert/divert_init.c   |    1 -
drivers/isdn/divert/divert_procfs.c |    1 -
drivers/isdn/divert/isdn_divert.c   |    1 -
drivers/isdn/hisax/hisax_fcpcipnp.c |    1 -
drivers/isdn/hisax/st5481_init.c    |    1 -
drivers/isdn/hysdn/hycapi.c         |    1 -
drivers/isdn/hysdn/hysdn_init.c     |    1 -
drivers/isdn/hysdn/hysdn_net.c      |    1 -
drivers/isdn/hysdn/hysdn_procconf.c |    1 -
drivers/isdn/hysdn/hysdn_proclog.c  |    1 -
drivers/isdn/i4l/isdn_common.c      |    1 -
drivers/isdn/icn/icn.h              |    1 -
drivers/isdn/isdnloop/isdnloop.h    |    1 -
drivers/isdn/sc/includes.h          |    1 -
14 files changed, 14 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/isdn/divert/divert_init.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/divert/divert_init.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/divert/divert_init.c
@@ -10,7 +10,6 @@
*/

#include <linux/module.h>
-#include <linux/version.h>
#include <linux/init.h>
#include <linux/kernel.h>

Index: linux-2.6.13-rc2-mm1/drivers/isdn/divert/divert_procfs.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/divert/divert_procfs.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/divert/divert_procfs.c
@@ -11,7 +11,6 @@

#include <linux/config.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/poll.h>
#include <linux/smp_lock.h>
#ifdef CONFIG_PROC_FS
Index: linux-2.6.13-rc2-mm1/drivers/isdn/divert/isdn_divert.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/divert/isdn_divert.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/divert/isdn_divert.c
@@ -9,7 +9,6 @@
*
*/

-#include <linux/version.h>
#include <linux/proc_fs.h>

#include "isdn_divert.h"
Index: linux-2.6.13-rc2-mm1/drivers/isdn/hisax/hisax_fcpcipnp.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/hisax/hisax_fcpcipnp.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/hisax/hisax_fcpcipnp.c
@@ -23,7 +23,6 @@
* o tx_skb at PH_DEACTIVATE time
*/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/pci.h>
Index: linux-2.6.13-rc2-mm1/drivers/isdn/hisax/st5481_init.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/hisax/st5481_init.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/hisax/st5481_init.c
@@ -25,7 +25,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/usb.h>
Index: linux-2.6.13-rc2-mm1/drivers/isdn/hysdn/hycapi.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/hysdn/hycapi.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/hysdn/hycapi.c
@@ -11,7 +11,6 @@
*/

#include <linux/module.h>
-#include <linux/version.h>
#include <linux/signal.h>
#include <linux/kernel.h>
#include <linux/skbuff.h>
Index: linux-2.6.13-rc2-mm1/drivers/isdn/hysdn/hysdn_init.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/hysdn/hysdn_init.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/hysdn/hysdn_init.c
@@ -13,7 +13,6 @@
#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>
-#include <linux/version.h>
#include <linux/poll.h>
#include <linux/vmalloc.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/drivers/isdn/hysdn/hysdn_net.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/hysdn/hysdn_net.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/hysdn/hysdn_net.c
@@ -14,7 +14,6 @@
*/

#include <linux/module.h>
-#include <linux/version.h>
#include <linux/signal.h>
#include <linux/kernel.h>
#include <linux/netdevice.h>
Index: linux-2.6.13-rc2-mm1/drivers/isdn/hysdn/hysdn_procconf.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/hysdn/hysdn_procconf.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/hysdn/hysdn_procconf.c
@@ -12,7 +12,6 @@
*/

#include <linux/module.h>
-#include <linux/version.h>
#include <linux/poll.h>
#include <linux/proc_fs.h>
#include <linux/pci.h>
Index: linux-2.6.13-rc2-mm1/drivers/isdn/hysdn/hysdn_proclog.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/hysdn/hysdn_proclog.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/hysdn/hysdn_proclog.c
@@ -11,7 +11,6 @@
*/

#include <linux/module.h>
-#include <linux/version.h>
#include <linux/poll.h>
#include <linux/proc_fs.h>
#include <linux/pci.h>
Index: linux-2.6.13-rc2-mm1/drivers/isdn/i4l/isdn_common.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/i4l/isdn_common.c
+++ linux-2.6.13-rc2-mm1/drivers/isdn/i4l/isdn_common.c
@@ -14,7 +14,6 @@
#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>
-#include <linux/version.h>
#include <linux/poll.h>
#include <linux/vmalloc.h>
#include <linux/isdn.h>
Index: linux-2.6.13-rc2-mm1/drivers/isdn/icn/icn.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/icn/icn.h
+++ linux-2.6.13-rc2-mm1/drivers/isdn/icn/icn.h
@@ -35,7 +35,6 @@ typedef struct icn_cdef {
#ifdef __KERNEL__
/* Kernel includes */

-#include <linux/version.h>
#include <linux/errno.h>
#include <linux/fs.h>
#include <linux/major.h>
Index: linux-2.6.13-rc2-mm1/drivers/isdn/isdnloop/isdnloop.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/isdnloop/isdnloop.h
+++ linux-2.6.13-rc2-mm1/drivers/isdn/isdnloop/isdnloop.h
@@ -33,7 +33,6 @@ typedef struct isdnloop_sdef {
#ifdef __KERNEL__
/* Kernel includes */

-#include <linux/version.h>
#include <linux/errno.h>
#include <linux/fs.h>
#include <linux/major.h>
Index: linux-2.6.13-rc2-mm1/drivers/isdn/sc/includes.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/isdn/sc/includes.h
+++ linux-2.6.13-rc2-mm1/drivers/isdn/sc/includes.h
@@ -4,7 +4,6 @@
*
*/

-#include <linux/version.h>
#include <linux/errno.h>
#include <asm/io.h>
#include <linux/delay.h>
