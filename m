Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbULKV3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbULKV3n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 16:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbULKV3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 16:29:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50438 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262016AbULKV3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 16:29:33 -0500
Date: Sat, 11 Dec 2004 22:29:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, philb@gnu.org
Subject: [patch] Update email address of Benjamin LaHaise
Message-ID: <20041211212923.GA22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Blundell's email address Philip.Blundell@pobox.com is bouncing.

The patch below (applies against both 2.4 and 2.6 and already ACK'ed by 
Philip Blundell) changes all occurances of this address in the kernel 
sources to philb@gnu.org .


diffstat output:
 Documentation/parport.txt        |    2 +-
 MAINTAINERS                      |    6 +++---
 drivers/char/lp.c                |    2 +-
 drivers/net/3c505.c              |    2 +-
 drivers/net/eexpress.c           |    2 +-
 drivers/parport/ieee1284.c       |    2 +-
 drivers/parport/parport_arc.c    |    2 +-
 drivers/parport/parport_gsc.c    |    2 +-
 drivers/parport/parport_pc.c     |    2 +-
 drivers/parport/parport_sunbpp.c |    2 +-
 drivers/parport/probe.c          |    2 +-
 drivers/scsi/advansys.c          |    2 +-
 12 files changed, 14 insertions(+), 14 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/MAINTAINERS.old	2004-12-11 19:34:58.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/MAINTAINERS	2004-12-11 19:35:17.000000000 +0100
@@ -80,7 +80,7 @@
 
 3C505 NETWORK DRIVER
 P:	Philip Blundell
-M:	Philip.Blundell@pobox.com
+M:	philb@gnu.org
 L:	linux-net@vger.kernel.org
 S:	Maintained
 
@@ -789,7 +789,7 @@
 
 ETHEREXPRESS-16 NETWORK DRIVER
 P:	Philip Blundell
-M:	Philip.Blundell@pobox.com
+M:	philb@gnu.org
 L:	linux-net@vger.kernel.org
 S:	Maintained
 
@@ -1686,7 +1686,7 @@
 
 PARALLEL PORT SUPPORT
 P:	Phil Blundell
-M:	Philip.Blundell@pobox.com
+M:	philb@gnu.org
 P:	Tim Waugh
 M:	tim@cyberelk.net
 P:	David Campbell
--- linux-2.6.10-rc2-mm4-full/Documentation/parport.txt.old	2004-12-11 19:35:27.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/Documentation/parport.txt	2004-12-11 19:35:56.000000000 +0100
@@ -264,5 +264,5 @@
     io=0x378 irq=7 dma=none (for PIO)
     io=0x378 irq=7 dma=3 (for DMA)
 --
-Philip.Blundell@pobox.com
+philb@gnu.org
 tim@cyberelk.net
--- linux-2.6.10-rc2-mm4-full/drivers/net/eexpress.c.old	2004-12-11 19:36:09.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/net/eexpress.c	2004-12-11 19:36:26.000000000 +0100
@@ -7,7 +7,7 @@
  * Support for 8-bit mode by Zoltan Szilagyi <zoltans@cs.arizona.edu>
  *
  * Many modifications, and currently maintained, by
- *  Philip Blundell <Philip.Blundell@pobox.com>
+ *  Philip Blundell <philb@gnu.org>
  * Added the Compaq LTE  Alan Cox <alan@redhat.com>
  * Added MCA support Adam Fritzler <mid@auk.cx>
  *
--- linux-2.6.10-rc2-mm4-full/drivers/net/3c505.c.old	2004-12-11 19:36:34.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/net/3c505.c	2004-12-11 19:36:42.000000000 +0100
@@ -32,7 +32,7 @@
  *              Linux 1.3.0 changes by
  *                      Alan Cox <Alan.Cox@linux.org>
  *              More debugging, DMA support, currently maintained by
- *                      Philip Blundell <Philip.Blundell@pobox.com>
+ *                      Philip Blundell <philb@gnu.org>
  *              Multicard/soft configurable dma channel/rev 2 hardware support
  *                      by Christopher Collins <ccollins@pcug.org.au>
  *		Ethtool support (jgarzik), 11/17/2001
--- linux-2.6.10-rc2-mm4-full/drivers/char/lp.c.old	2004-12-11 19:36:50.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/char/lp.c	2004-12-11 19:36:58.000000000 +0100
@@ -12,7 +12,7 @@
  * "lp=" command line parameters added by Grant Guenther, grant@torque.net
  * lp_read (Status readback) support added by Carsten Gross,
  *                                             carsten@sol.wohnheim.uni-ulm.de
- * Support for parport by Philip Blundell <Philip.Blundell@pobox.com>
+ * Support for parport by Philip Blundell <philb@gnu.org>
  * Parport sharing hacking by Andrea Arcangeli
  * Fixed kernel_(to/from)_user memory copy to check for errors
  * 				by Riccardo Facchetti <fizban@tin.it>
--- linux-2.6.10-rc2-mm4-full/drivers/scsi/advansys.c.old	2004-12-11 19:37:05.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/scsi/advansys.c	2004-12-11 19:37:34.000000000 +0100
@@ -714,7 +714,7 @@
      Tom Rini <trini@kernel.crashing.org> provided the CONFIG_ISA
      patch and helped with PowerPC wide and narrow board support.
 
-     Philip Blundell <philip.blundell@pobox.com> provided an
+     Philip Blundell <philb@gnu.org> provided an
      advansys_interrupts_enabled patch.
 
      Dave Jones <dave@denial.force9.co.uk> reported the compiler
--- linux-2.6.10-rc2-mm4-full/drivers/parport/parport_arc.c.old	2004-12-11 19:37:43.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/parport/parport_arc.c	2004-12-11 19:37:50.000000000 +0100
@@ -1,6 +1,6 @@
 /* Low-level parallel port routines for Archimedes onboard hardware
  *
- * Author: Phil Blundell <Philip.Blundell@pobox.com>
+ * Author: Phil Blundell <philb@gnu.org>
  */
 
 /* This driver is for the parallel port hardware found on Acorn's old
--- linux-2.6.10-rc2-mm4-full/drivers/parport/ieee1284.c.old	2004-12-11 19:38:00.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/parport/ieee1284.c	2004-12-11 19:38:08.000000000 +0100
@@ -1,7 +1,7 @@
 /* $Id: parport_ieee1284.c,v 1.4 1997/10/19 21:37:21 philip Exp $
  * IEEE-1284 implementation for parport.
  *
- * Authors: Phil Blundell <Philip.Blundell@pobox.com>
+ * Authors: Phil Blundell <philb@gnu.org>
  *          Carsten Gross <carsten@sol.wohnheim.uni-ulm.de>
  *	    Jose Renau <renau@acm.org>
  *          Tim Waugh <tim@cyberelk.demon.co.uk> (largely rewritten)
--- linux-2.6.10-rc2-mm4-full/drivers/parport/parport_sunbpp.c.old	2004-12-11 19:38:16.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/parport/parport_sunbpp.c	2004-12-11 19:38:32.000000000 +0100
@@ -4,7 +4,7 @@
  * Author: Derrick J. Brashear <shadow@dementia.org>
  *
  * based on work by:
- *          Phil Blundell <Philip.Blundell@pobox.com>
+ *          Phil Blundell <philb@gnu.org>
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *	    Jose Renau <renau@acm.org>
  *          David Campbell <campbell@tirian.che.curtin.edu.au>
--- linux-2.6.10-rc2-mm4-full/drivers/parport/probe.c.old	2004-12-11 19:38:39.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/parport/probe.c	2004-12-11 19:38:47.000000000 +0100
@@ -2,7 +2,7 @@
  * Parallel port device probing code
  *
  * Authors:    Carsten Gross, carsten@sol.wohnheim.uni-ulm.de
- *             Philip Blundell <Philip.Blundell@pobox.com>
+ *             Philip Blundell <philb@gnu.org>
  */
 
 #include <linux/module.h>
--- linux-2.6.10-rc2-mm4-full/drivers/parport/parport_gsc.c.old	2004-12-11 19:38:56.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/parport/parport_gsc.c	2004-12-11 19:39:09.000000000 +0100
@@ -12,7 +12,7 @@
  * 
  * based on parport_pc.c by 
  * 	    Grant Guenther <grant@torque.net>
- * 	    Phil Blundell <Philip.Blundell@pobox.com>
+ * 	    Phil Blundell <philb@gnu.org>
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *	    Jose Renau <renau@acm.org>
  *          David Campbell <campbell@torque.net>
--- linux-2.6.10-rc2-mm4-full/drivers/parport/parport_pc.c.old	2004-12-11 19:39:17.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/parport/parport_pc.c	2004-12-11 19:39:24.000000000 +0100
@@ -1,6 +1,6 @@
 /* Low-level parallel-port routines for 8255-based PC-style hardware.
  * 
- * Authors: Phil Blundell <Philip.Blundell@pobox.com>
+ * Authors: Phil Blundell <philb@gnu.org>
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *	    Jose Renau <renau@acm.org>
  *          David Campbell <campbell@torque.net>
