Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTFHXMq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 19:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTFHXMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 19:12:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19451 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264043AbTFHXMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 19:12:35 -0400
Date: Mon, 9 Jun 2003 01:26:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [2.5 patch] kill 3 occurences of __NO_VERSION__
Message-ID: <20030608232611.GM16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__NO_VERSION__ is obsolete for a long time.

The patch below removes 3 occurences that went into the tree recently.

cu
Adrian

--- linux-2.5.70-mm6/drivers/char/drm/gamma_lists.h.old	2003-06-09 01:21:40.000000000 +0200
+++ linux-2.5.70-mm6/drivers/char/drm/gamma_lists.h	2003-06-09 01:21:57.000000000 +0200
@@ -29,7 +29,6 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 
--- linux-2.5.70-mm6/drivers/mtd/inftlmount.c.old	2003-06-09 01:22:19.000000000 +0200
+++ linux-2.5.70-mm6/drivers/mtd/inftlmount.c	2003-06-09 01:22:33.000000000 +0200
@@ -25,7 +25,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#define __NO_VERSION__
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <asm/errno.h>
--- linux-2.5.70-mm6/fs/intermezzo/fileset.c.old	2003-06-09 01:23:02.000000000 +0200
+++ linux-2.5.70-mm6/fs/intermezzo/fileset.c	2003-06-09 01:23:12.000000000 +0200
@@ -22,8 +22,6 @@
  *
  */
 
-#define __NO_VERSION__
-
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
