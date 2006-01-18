Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWARQu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWARQu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWARQu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:50:29 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:17808 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932459AbWARQuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:50:23 -0500
Date: Wed, 18 Jan 2006 17:49:14 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andreas Herrmann <aherrman@de.ibm.com>,
       Frank Pavlic <pavlic@de.ibm.com>
Subject: [PATCH 1/7] s390: Remove CVS generated information.
Message-ID: <20060118164914.GA29266@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

- Remove all CVS generated information like e.g. revision IDs from
  drivers/s390 and include/asm-s390 (none present in arch/s390).
- Add newline at end of arch/s390/lib/Makefile to avoid diff message.

Acked-by: Andreas Herrmann <aherrman@de.ibm.com>
Acked-by: Frank Pavlic <pavlic@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/lib/Makefile                 |    2 +-
 drivers/s390/block/dasd.c              |    1 -
 drivers/s390/block/dasd_3370_erp.c     |    1 -
 drivers/s390/block/dasd_3990_erp.c     |    1 -
 drivers/s390/block/dasd_9336_erp.c     |    1 -
 drivers/s390/block/dasd_9343_erp.c     |    1 -
 drivers/s390/block/dasd_cmb.c          |    2 --
 drivers/s390/block/dasd_devmap.c       |    1 -
 drivers/s390/block/dasd_diag.c         |    1 -
 drivers/s390/block/dasd_diag.h         |    1 -
 drivers/s390/block/dasd_eckd.c         |    1 -
 drivers/s390/block/dasd_eckd.h         |    1 -
 drivers/s390/block/dasd_erp.c          |    1 -
 drivers/s390/block/dasd_fba.c          |    1 -
 drivers/s390/block/dasd_fba.h          |    1 -
 drivers/s390/block/dasd_genhd.c        |    1 -
 drivers/s390/block/dasd_int.h          |    1 -
 drivers/s390/block/dasd_ioctl.c        |    2 --
 drivers/s390/block/dasd_proc.c         |    1 -
 drivers/s390/char/tape_34xx.c          |    5 ++---
 drivers/s390/char/tape_class.c         |    4 ++--
 drivers/s390/char/tape_class.h         |    2 +-
 drivers/s390/char/tape_core.c          |    5 ++---
 drivers/s390/cio/airq.c                |    2 --
 drivers/s390/cio/blacklist.c           |    1 -
 drivers/s390/cio/ccwgroup.c            |    1 -
 drivers/s390/cio/chsc.c                |    1 -
 drivers/s390/cio/cio.c                 |    1 -
 drivers/s390/cio/cmf.c                 |    2 +-
 drivers/s390/cio/css.c                 |    1 -
 drivers/s390/cio/device.c              |    1 -
 drivers/s390/cio/device_ops.c          |    2 --
 drivers/s390/cio/qdio.c                |    5 +----
 drivers/s390/cio/qdio.h                |    2 --
 drivers/s390/crypto/z90common.h        |    2 --
 drivers/s390/crypto/z90crypt.h         |    2 --
 drivers/s390/crypto/z90hardware.c      |    6 ------
 drivers/s390/crypto/z90main.c          |   10 ----------
 drivers/s390/net/claw.c                |   11 +----------
 drivers/s390/net/claw.h                |    2 +-
 drivers/s390/net/ctcdbug.c             |    5 +----
 drivers/s390/net/ctcdbug.h             |    4 +---
 drivers/s390/net/ctcmain.c             |   19 ++-----------------
 drivers/s390/net/ctcmain.h             |    4 ----
 drivers/s390/net/ctctty.c              |    2 --
 drivers/s390/net/ctctty.h              |    2 --
 drivers/s390/net/cu3088.c              |    2 --
 drivers/s390/net/fsm.c                 |    2 --
 drivers/s390/net/fsm.h                 |    2 --
 drivers/s390/net/iucv.c                |   16 +---------------
 drivers/s390/net/lcs.c                 |    5 +----
 drivers/s390/net/lcs.h                 |    2 --
 drivers/s390/net/netiucv.c             |   15 +--------------
 drivers/s390/net/qeth.h                |    2 --
 drivers/s390/net/qeth_eddp.c           |    5 +----
 drivers/s390/net/qeth_eddp.h           |    6 ++----
 drivers/s390/net/qeth_fs.h             |    5 -----
 drivers/s390/net/qeth_main.c           |   13 ++-----------
 drivers/s390/net/qeth_mpc.c            |    2 --
 drivers/s390/net/qeth_mpc.h            |    4 ----
 drivers/s390/net/qeth_proc.c           |    4 +---
 drivers/s390/net/qeth_sys.c            |    4 +---
 drivers/s390/net/qeth_tso.h            |    4 +---
 drivers/s390/s390_rdev.c               |    1 -
 drivers/s390/scsi/zfcp_aux.c           |    2 --
 drivers/s390/scsi/zfcp_ccw.c           |    2 --
 drivers/s390/scsi/zfcp_dbf.c           |    2 --
 drivers/s390/scsi/zfcp_def.h           |    2 --
 drivers/s390/scsi/zfcp_erp.c           |    2 --
 drivers/s390/scsi/zfcp_ext.h           |    2 --
 drivers/s390/scsi/zfcp_fsf.c           |    2 --
 drivers/s390/scsi/zfcp_qdio.c          |    2 --
 drivers/s390/scsi/zfcp_scsi.c          |    2 --
 drivers/s390/scsi/zfcp_sysfs_adapter.c |    2 --
 drivers/s390/scsi/zfcp_sysfs_driver.c  |    2 --
 drivers/s390/scsi/zfcp_sysfs_port.c    |    2 --
 drivers/s390/scsi/zfcp_sysfs_unit.c    |    2 --
 include/asm-s390/dasd.h                |    2 --
 include/asm-s390/qdio.h                |    2 --
 79 files changed, 27 insertions(+), 223 deletions(-)

diff -urpN linux-2.6/arch/s390/lib/Makefile linux-2.6-patched/arch/s390/lib/Makefile
--- linux-2.6/arch/s390/lib/Makefile	2006-01-18 17:25:20.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/Makefile	2006-01-18 17:25:47.000000000 +0100
@@ -6,4 +6,4 @@ EXTRA_AFLAGS := -traditional
 
 lib-y += delay.o string.o
 lib-y += $(if $(CONFIG_64BIT),uaccess64.o,uaccess.o)
-lib-$(CONFIG_SMP) += spinlock.o
\ No newline at end of file
+lib-$(CONFIG_SMP) += spinlock.o
diff -urpN linux-2.6/drivers/s390/block/dasd_3370_erp.c linux-2.6-patched/drivers/s390/block/dasd_3370_erp.c
--- linux-2.6/drivers/s390/block/dasd_3370_erp.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_3370_erp.c	2006-01-18 17:25:47.000000000 +0100
@@ -4,7 +4,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000
  *
- * $Revision: 1.9 $
  */
 
 #define PRINTK_HEADER "dasd_erp(3370)"
diff -urpN linux-2.6/drivers/s390/block/dasd_3990_erp.c linux-2.6-patched/drivers/s390/block/dasd_3990_erp.c
--- linux-2.6/drivers/s390/block/dasd_3990_erp.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_3990_erp.c	2006-01-18 17:25:47.000000000 +0100
@@ -5,7 +5,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000, 2001
  *
- * $Revision: 1.36 $
  */
 
 #include <linux/timer.h>
diff -urpN linux-2.6/drivers/s390/block/dasd_9336_erp.c linux-2.6-patched/drivers/s390/block/dasd_9336_erp.c
--- linux-2.6/drivers/s390/block/dasd_9336_erp.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_9336_erp.c	2006-01-18 17:25:47.000000000 +0100
@@ -4,7 +4,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000
  *
- * $Revision: 1.8 $
  */
 
 #define PRINTK_HEADER "dasd_erp(9336)"
diff -urpN linux-2.6/drivers/s390/block/dasd_9343_erp.c linux-2.6-patched/drivers/s390/block/dasd_9343_erp.c
--- linux-2.6/drivers/s390/block/dasd_9343_erp.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_9343_erp.c	2006-01-18 17:25:47.000000000 +0100
@@ -4,7 +4,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000
  *
- * $Revision: 1.13 $
  */
 
 #define PRINTK_HEADER "dasd_erp(9343)"
diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-01-18 17:25:47.000000000 +0100
@@ -7,7 +7,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.172 $
  */
 
 #include <linux/config.h>
diff -urpN linux-2.6/drivers/s390/block/dasd_cmb.c linux-2.6-patched/drivers/s390/block/dasd_cmb.c
--- linux-2.6/drivers/s390/block/dasd_cmb.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_cmb.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/s390/block/dasd_cmb.c ($Revision: 1.9 $)
- *
  * Linux on zSeries Channel Measurement Facility support
  *  (dasd device driver interface)
  *
diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-01-18 17:25:47.000000000 +0100
@@ -11,7 +11,6 @@
  * functions may not be called from interrupt context. In particular
  * dasd_get_device is a no-no from interrupt context.
  *
- * $Revision: 1.43 $
  */
 
 #include <linux/config.h>
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-patched/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.c	2006-01-18 17:25:47.000000000 +0100
@@ -6,7 +6,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.53 $
  */
 
 #include <linux/config.h>
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.h linux-2.6-patched/drivers/s390/block/dasd_diag.h
--- linux-2.6/drivers/s390/block/dasd_diag.h	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.h	2006-01-18 17:25:47.000000000 +0100
@@ -6,7 +6,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.9 $
  */
 
 #define MDSK_WRITE_REQ 0x01
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2006-01-18 17:25:47.000000000 +0100
@@ -7,7 +7,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.74 $
  */
 
 #include <linux/config.h>
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.h linux-2.6-patched/drivers/s390/block/dasd_eckd.h
--- linux-2.6/drivers/s390/block/dasd_eckd.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.h	2006-01-18 17:25:47.000000000 +0100
@@ -5,7 +5,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.10 $
  */
 
 #ifndef DASD_ECKD_H
diff -urpN linux-2.6/drivers/s390/block/dasd_erp.c linux-2.6-patched/drivers/s390/block/dasd_erp.c
--- linux-2.6/drivers/s390/block/dasd_erp.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_erp.c	2006-01-18 17:25:47.000000000 +0100
@@ -7,7 +7,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.14 $
  */
 
 #include <linux/config.h>
diff -urpN linux-2.6/drivers/s390/block/dasd_fba.c linux-2.6-patched/drivers/s390/block/dasd_fba.c
--- linux-2.6/drivers/s390/block/dasd_fba.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_fba.c	2006-01-18 17:25:47.000000000 +0100
@@ -4,7 +4,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.41 $
  */
 
 #include <linux/config.h>
diff -urpN linux-2.6/drivers/s390/block/dasd_fba.h linux-2.6-patched/drivers/s390/block/dasd_fba.h
--- linux-2.6/drivers/s390/block/dasd_fba.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_fba.h	2006-01-18 17:25:47.000000000 +0100
@@ -4,7 +4,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.6 $
  */
 
 #ifndef DASD_FBA_H
diff -urpN linux-2.6/drivers/s390/block/dasd_genhd.c linux-2.6-patched/drivers/s390/block/dasd_genhd.c
--- linux-2.6/drivers/s390/block/dasd_genhd.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_genhd.c	2006-01-18 17:25:47.000000000 +0100
@@ -9,7 +9,6 @@
  *
  * gendisk related functions for the dasd driver.
  *
- * $Revision: 1.51 $
  */
 
 #include <linux/config.h>
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-01-18 17:25:47.000000000 +0100
@@ -6,7 +6,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.68 $
  */
 
 #ifndef DASD_INT_H
diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2006-01-18 17:25:47.000000000 +0100
@@ -7,8 +7,6 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.50 $
- *
  * i/o controls for the dasd driver.
  */
 #include <linux/config.h>
diff -urpN linux-2.6/drivers/s390/block/dasd_proc.c linux-2.6-patched/drivers/s390/block/dasd_proc.c
--- linux-2.6/drivers/s390/block/dasd_proc.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_proc.c	2006-01-18 17:25:47.000000000 +0100
@@ -9,7 +9,6 @@
  *
  * /proc interface for the dasd driver.
  *
- * $Revision: 1.33 $
  */
 
 #include <linux/config.h>
diff -urpN linux-2.6/drivers/s390/char/tape_34xx.c linux-2.6-patched/drivers/s390/char/tape_34xx.c
--- linux-2.6/drivers/s390/char/tape_34xx.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_34xx.c	2006-01-18 17:25:47.000000000 +0100
@@ -1357,7 +1357,7 @@ tape_34xx_init (void)
 	debug_set_level(TAPE_DBF_AREA, 6);
 #endif
 
-	DBF_EVENT(3, "34xx init: $Revision: 1.23 $\n");
+	DBF_EVENT(3, "34xx init\n");
 	/* Register driver for 3480/3490 tapes. */
 	rc = ccw_driver_register(&tape_34xx_driver);
 	if (rc)
@@ -1377,8 +1377,7 @@ tape_34xx_exit(void)
 
 MODULE_DEVICE_TABLE(ccw, tape_34xx_ids);
 MODULE_AUTHOR("(C) 2001-2002 IBM Deutschland Entwicklung GmbH");
-MODULE_DESCRIPTION("Linux on zSeries channel attached 3480 tape "
-		   "device driver ($Revision: 1.23 $)");
+MODULE_DESCRIPTION("Linux on zSeries channel attached 3480 tape device driver");
 MODULE_LICENSE("GPL");
 
 module_init(tape_34xx_init);
diff -urpN linux-2.6/drivers/s390/char/tape_class.c linux-2.6-patched/drivers/s390/char/tape_class.c
--- linux-2.6/drivers/s390/char/tape_class.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_class.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * (C) Copyright IBM Corp. 2004
- * tape_class.c ($Revision: 1.8 $)
+ * tape_class.c
  *
  * Tape class device support
  *
@@ -12,7 +12,7 @@
 MODULE_AUTHOR("Stefan Bader <shbader@de.ibm.com>");
 MODULE_DESCRIPTION(
 	"(C) Copyright IBM Corp. 2004   All Rights Reserved.\n"
-	"tape_class.c ($Revision: 1.8 $)"
+	"tape_class.c"
 );
 MODULE_LICENSE("GPL");
 
diff -urpN linux-2.6/drivers/s390/char/tape_class.h linux-2.6-patched/drivers/s390/char/tape_class.h
--- linux-2.6/drivers/s390/char/tape_class.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_class.h	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * (C) Copyright IBM Corp. 2004   All Rights Reserved.
- * tape_class.h ($Revision: 1.4 $)
+ * tape_class.h
  *
  * Tape class device support
  *
diff -urpN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-patched/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_core.c	2006-01-18 17:25:47.000000000 +0100
@@ -1239,7 +1239,7 @@ tape_init (void)
 #ifdef DBF_LIKE_HELL
 	debug_set_level(TAPE_DBF_AREA, 6);
 #endif
-	DBF_EVENT(3, "tape init: ($Revision: 1.54 $)\n");
+	DBF_EVENT(3, "tape init\n");
 	tape_proc_init();
 	tapechar_init ();
 	tapeblock_init ();
@@ -1263,8 +1263,7 @@ tape_exit(void)
 
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and "
 	      "Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
-MODULE_DESCRIPTION("Linux on zSeries channel attached "
-		   "tape device driver ($Revision: 1.54 $)");
+MODULE_DESCRIPTION("Linux on zSeries channel attached tape device driver");
 MODULE_LICENSE("GPL");
 
 module_init(tape_init);
diff -urpN linux-2.6/drivers/s390/cio/airq.c linux-2.6-patched/drivers/s390/cio/airq.c
--- linux-2.6/drivers/s390/cio/airq.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/airq.c	2006-01-18 17:25:47.000000000 +0100
@@ -2,8 +2,6 @@
  *  drivers/s390/cio/airq.c
  *   S/390 common I/O routines -- support for adapter interruptions
  *
- *   $Revision: 1.15 $
- *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
  *    Author(s): Ingo Adlung (adlung@de.ibm.com)
diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,7 +1,6 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.42 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
diff -urpN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-patched/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/ccwgroup.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,7 +1,6 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.35 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,7 +1,6 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.128 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,7 +1,6 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.140 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
diff -urpN linux-2.6/drivers/s390/cio/cmf.c linux-2.6-patched/drivers/s390/cio/cmf.c
--- linux-2.6/drivers/s390/cio/cmf.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cmf.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/s390/cio/cmf.c ($Revision: 1.19 $)
+ * linux/drivers/s390/cio/cmf.c
  *
  * Linux on zSeries Channel Measurement Facility support
  *
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,7 +1,6 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.96 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,7 +1,6 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.140 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,8 +1,6 @@
 /*
  *  drivers/s390/cio/device_ops.c
  *
- *   $Revision: 1.61 $
- *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-01-18 17:25:47.000000000 +0100
@@ -56,8 +56,6 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.117 $"
-
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
 MODULE_DESCRIPTION("QDIO base support version 2, " \
@@ -66,8 +64,7 @@ MODULE_LICENSE("GPL");
 
 /******************** HERE WE GO ***********************************/
 
-static const char version[] = "QDIO base support version 2 ("
-	VERSION_QDIO_C "/" VERSION_QDIO_H  "/" VERSION_CIO_QDIO_H ")";
+static const char version[] = "QDIO base support version 2";
 
 #ifdef QDIO_PERFORMANCE_STATS
 static int proc_perf_file_registration;
diff -urpN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-patched/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.h	2006-01-18 17:25:47.000000000 +0100
@@ -5,8 +5,6 @@
 
 #include "schid.h"
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.40 $"
-
 #ifdef CONFIG_QDIO_DEBUG
 #define QDIO_VERBOSE_LEVEL 9
 #else /* CONFIG_QDIO_DEBUG */
diff -urpN linux-2.6/drivers/s390/crypto/z90common.h linux-2.6-patched/drivers/s390/crypto/z90common.h
--- linux-2.6/drivers/s390/crypto/z90common.h	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90common.h	2006-01-18 17:25:47.000000000 +0100
@@ -27,8 +27,6 @@
 #ifndef _Z90COMMON_H_
 #define _Z90COMMON_H_
 
-#define VERSION_Z90COMMON_H "$Revision: 1.17 $"
-
 
 #define RESPBUFFSIZE 256
 #define PCI_FUNC_KEY_DECRYPT 0x5044
diff -urpN linux-2.6/drivers/s390/crypto/z90crypt.h linux-2.6-patched/drivers/s390/crypto/z90crypt.h
--- linux-2.6/drivers/s390/crypto/z90crypt.h	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90crypt.h	2006-01-18 17:25:47.000000000 +0100
@@ -29,8 +29,6 @@
 
 #include <linux/ioctl.h>
 
-#define VERSION_Z90CRYPT_H "$Revision: 1.2.2.4 $"
-
 #define z90crypt_VERSION 1
 #define z90crypt_RELEASE 3	// 2 = PCIXCC, 3 = rewrite for coding standards
 #define z90crypt_VARIANT 3	// 3 = CEX2A support
diff -urpN linux-2.6/drivers/s390/crypto/z90hardware.c linux-2.6-patched/drivers/s390/crypto/z90hardware.c
--- linux-2.6/drivers/s390/crypto/z90hardware.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90hardware.c	2006-01-18 17:25:47.000000000 +0100
@@ -32,12 +32,6 @@
 #include "z90crypt.h"
 #include "z90common.h"
 
-#define VERSION_Z90HARDWARE_C "$Revision: 1.34 $"
-
-char z90hardware_version[] __initdata =
-	"z90hardware.o (" VERSION_Z90HARDWARE_C "/"
-	                  VERSION_Z90COMMON_H "/" VERSION_Z90CRYPT_H ")";
-
 struct cca_token_hdr {
 	unsigned char  token_identifier;
 	unsigned char  version;
diff -urpN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2006-01-18 17:25:47.000000000 +0100
@@ -38,14 +38,6 @@
 #include "z90crypt.h"
 #include "z90common.h"
 
-#define VERSION_Z90MAIN_C "$Revision: 1.62 $"
-
-static char z90main_version[] __initdata =
-	"z90main.o (" VERSION_Z90MAIN_C "/"
-                      VERSION_Z90COMMON_H "/" VERSION_Z90CRYPT_H ")";
-
-extern char z90hardware_version[];
-
 /**
  * Defaults that may be modified.
  */
@@ -594,8 +586,6 @@ z90crypt_init_module(void)
 		PRINTKN("Version %d.%d.%d loaded, built on %s %s\n",
 			z90crypt_VERSION, z90crypt_RELEASE, z90crypt_VARIANT,
 			__DATE__, __TIME__);
-		PRINTKN("%s\n", z90main_version);
-		PRINTKN("%s\n", z90hardware_version);
 		PDEBUG("create_z90crypt (domain index %d) successful.\n",
 		       domain);
 	} else
diff -urpN linux-2.6/drivers/s390/net/claw.c linux-2.6-patched/drivers/s390/net/claw.c
--- linux-2.6/drivers/s390/net/claw.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/claw.c	2006-01-18 17:25:47.000000000 +0100
@@ -2,8 +2,6 @@
  *  drivers/s390/net/claw.c
  *    ESCON CLAW network driver
  *
- *    $Revision: 1.38 $ $Date: 2005/08/29 09:47:04 $
- *
  *  Linux for zSeries version
  *    Copyright (C) 2002,2005 IBM Corporation
  *  Author(s) Original code written by:
@@ -4391,14 +4389,7 @@ static int __init
 claw_init(void)
 {
 	int ret = 0;
-       printk(KERN_INFO "claw: starting driver "
-#ifdef MODULE
-                "module "
-#else
-                "compiled into kernel "
-#endif
-                " $Revision: 1.38 $ $Date: 2005/08/29 09:47:04 $ \n");
-
+	printk(KERN_INFO "claw: starting driver\n");
 
 #ifdef FUNCTRACE
         printk(KERN_INFO "claw: %s() enter \n",__FUNCTION__);
diff -urpN linux-2.6/drivers/s390/net/claw.h linux-2.6-patched/drivers/s390/net/claw.h
--- linux-2.6/drivers/s390/net/claw.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/claw.h	2006-01-18 17:25:47.000000000 +0100
@@ -2,7 +2,7 @@
 *  Define constants                                    *
 *                                                      *
 ********************************************************/
-#define VERSION_CLAW_H "$Revision: 1.6 $"
+
 /*-----------------------------------------------------*
 *     CCW command codes for CLAW protocol              *
 *------------------------------------------------------*/
diff -urpN linux-2.6/drivers/s390/net/ctcdbug.c linux-2.6-patched/drivers/s390/net/ctcdbug.c
--- linux-2.6/drivers/s390/net/ctcdbug.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctcdbug.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/ctcdbug.c ($Revision: 1.6 $)
+ * linux/drivers/s390/net/ctcdbug.c
  *
  * CTC / ESCON network driver - s390 dbf exploit.
  *
@@ -9,8 +9,6 @@
  *    Author(s): Original Code written by
  *			  Peter Tiedemann (ptiedem@de.ibm.com)
  *
- *    $Revision: 1.6 $	 $Date: 2005/05/11 08:10:17 $
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2, or (at your option)
@@ -80,4 +78,3 @@ ctc_register_dbf_views(void)
 	return 0;
 }
 
-
diff -urpN linux-2.6/drivers/s390/net/ctcdbug.h linux-2.6-patched/drivers/s390/net/ctcdbug.h
--- linux-2.6/drivers/s390/net/ctcdbug.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctcdbug.h	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.6 $)
+ * linux/drivers/s390/net/ctcdbug.h
  *
  * CTC / ESCON network driver - s390 dbf exploit.
  *
@@ -9,8 +9,6 @@
  *    Author(s): Original Code written by
  *			  Peter Tiedemann (ptiedem@de.ibm.com)
  *
- *    $Revision: 1.6 $	 $Date: 2005/05/11 08:10:17 $
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2, or (at your option)
diff -urpN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-patched/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctcmain.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,4 @@
 /*
- * $Id: ctcmain.c,v 1.79 2006/01/11 11:32:18 cohuck Exp $
- *
  * CTC / ESCON network driver
  *
  * Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
@@ -37,8 +35,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.79 $
- *
  */
 #undef DEBUG
 #include <linux/module.h>
@@ -248,22 +244,11 @@ static void
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.79 $";
-	char *version = vbuf;
 
 	if (printed)
 		return;
-	if ((version = strchr(version, ':'))) {
-		char *p = strchr(version + 1, '$');
-		if (p)
-			*p = '\0';
-	} else
-		version = " ??? ";
-	printk(KERN_INFO "CTC driver Version%s"
-#ifdef DEBUG
-		    " (DEBUG-VERSION, " __DATE__ __TIME__ ")"
-#endif
-		    " initialized\n", version);
+
+	printk(KERN_INFO "CTC driver initialized\n");
 	printed = 1;
 }
 
diff -urpN linux-2.6/drivers/s390/net/ctcmain.h linux-2.6-patched/drivers/s390/net/ctcmain.h
--- linux-2.6/drivers/s390/net/ctcmain.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctcmain.h	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,4 @@
 /*
- * $Id: ctcmain.h,v 1.4 2005/03/24 09:04:17 mschwide Exp $
- *
  * CTC / ESCON network driver
  *
  * Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
@@ -29,8 +27,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.4 $
- *
  */
 
 #ifndef _CTCMAIN_H_
diff -urpN linux-2.6/drivers/s390/net/ctctty.c linux-2.6-patched/drivers/s390/net/ctctty.c
--- linux-2.6/drivers/s390/net/ctctty.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctctty.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,4 @@
 /*
- * $Id: ctctty.c,v 1.29 2005/04/05 08:50:44 mschwide Exp $
- *
  * CTC / ESCON network driver, tty interface.
  *
  * Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
diff -urpN linux-2.6/drivers/s390/net/ctctty.h linux-2.6-patched/drivers/s390/net/ctctty.h
--- linux-2.6/drivers/s390/net/ctctty.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctctty.h	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,4 @@
 /*
- * $Id: ctctty.h,v 1.4 2003/09/18 08:01:10 mschwide Exp $
- *
  * CTC / ESCON network driver, tty interface.
  *
  * Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
diff -urpN linux-2.6/drivers/s390/net/cu3088.c linux-2.6-patched/drivers/s390/net/cu3088.c
--- linux-2.6/drivers/s390/net/cu3088.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/cu3088.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,4 @@
 /*
- * $Id: cu3088.c,v 1.38 2006/01/12 14:33:09 cohuck Exp $
- *
  * CTC / LCS ccw_device driver
  *
  * Copyright (C) 2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
diff -urpN linux-2.6/drivers/s390/net/fsm.c linux-2.6-patched/drivers/s390/net/fsm.c
--- linux-2.6/drivers/s390/net/fsm.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/fsm.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,4 @@
 /**
- * $Id: fsm.c,v 1.6 2003/10/15 11:37:29 mschwide Exp $
- *
  * A generic FSM based on fsm used in isdn4linux
  *
  */
diff -urpN linux-2.6/drivers/s390/net/fsm.h linux-2.6-patched/drivers/s390/net/fsm.h
--- linux-2.6/drivers/s390/net/fsm.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/fsm.h	2006-01-18 17:25:47.000000000 +0100
@@ -1,5 +1,3 @@
-/* $Id: fsm.h,v 1.1.1.1 2002/03/13 19:33:09 mschwide Exp $
- */
 #ifndef _FSM_H_
 #define _FSM_H_
 
diff -urpN linux-2.6/drivers/s390/net/iucv.c linux-2.6-patched/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/iucv.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,4 @@
 /* 
- * $Id: iucv.c,v 1.47 2005/11/21 11:35:22 mschwide Exp $
- *
  * IUCV network driver
  *
  * Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
@@ -29,8 +27,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.47 $
- *
  */
 
 /* #define DEBUG */
@@ -355,17 +351,7 @@ do { \
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.47 $";
-	char *version = vbuf;
-
-	if ((version = strchr(version, ':'))) {
-		char *p = strchr(version + 1, '$');
-		if (p)
-			*p = '\0';
-	} else
-		version = " ??? ";
-	printk(KERN_INFO
-	       "IUCV lowlevel driver Version%s initialized\n", version);
+	printk(KERN_INFO "IUCV lowlevel driver initialized\n");
 }
 
 /**
diff -urpN linux-2.6/drivers/s390/net/lcs.c linux-2.6-patched/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/lcs.c	2006-01-18 17:25:47.000000000 +0100
@@ -11,8 +11,6 @@
  *			  Frank Pavlic (fpavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.99 $	 $Date: 2005/05/11 08:10:17 $
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2, or (at your option)
@@ -59,9 +57,8 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.99 $"
 
-static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
+static char version[] __initdata = "LCS driver";
 static char debug_buffer[255];
 
 /**
diff -urpN linux-2.6/drivers/s390/net/lcs.h linux-2.6-patched/drivers/s390/net/lcs.h
--- linux-2.6/drivers/s390/net/lcs.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/lcs.h	2006-01-18 17:25:47.000000000 +0100
@@ -6,8 +6,6 @@
 #include <linux/workqueue.h>
 #include <asm/ccwdev.h>
 
-#define VERSION_LCS_H "$Revision: 1.19 $"
-
 #define LCS_DBF_TEXT(level, name, text) \
 	do { \
 		debug_text_event(lcs_dbf_##name, level, text); \
diff -urpN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-patched/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/netiucv.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,4 @@
 /*
- * $Id: netiucv.c,v 1.69 2006/01/12 14:33:09 cohuck Exp $
- *
  * IUCV network driver
  *
  * Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
@@ -31,8 +29,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.69 $
- *
  */
 
 #undef DEBUG
@@ -2077,16 +2073,7 @@ DRIVER_ATTR(remove, 0200, NULL, remove_w
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.69 $";
-	char *version = vbuf;
-
-	if ((version = strchr(version, ':'))) {
-		char *p = strchr(version + 1, '$');
-		if (p)
-			*p = '\0';
-	} else
-		version = " ??? ";
-	PRINT_INFO("NETIUCV driver Version%s initialized\n", version);
+	PRINT_INFO("NETIUCV driver initialized\n");
 }
 
 static void __exit
diff -urpN linux-2.6/drivers/s390/net/qeth_eddp.c linux-2.6-patched/drivers/s390/net/qeth_eddp.c
--- linux-2.6/drivers/s390/net/qeth_eddp.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_eddp.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,5 @@
 /*
- *
- * linux/drivers/s390/net/qeth_eddp.c ($Revision: 1.13 $)
+ * linux/drivers/s390/net/qeth_eddp.c
  *
  * Enhanced Device Driver Packing (EDDP) support for the qeth driver.
  *
@@ -8,8 +7,6 @@
  *
  *    Author(s): Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.13 $	 $Date: 2005/05/04 20:19:18 $
- *
  */
 #include <linux/config.h>
 #include <linux/errno.h>
diff -urpN linux-2.6/drivers/s390/net/qeth_eddp.h linux-2.6-patched/drivers/s390/net/qeth_eddp.h
--- linux-2.6/drivers/s390/net/qeth_eddp.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_eddp.h	2006-01-18 17:25:47.000000000 +0100
@@ -1,14 +1,12 @@
 /*
- * linux/drivers/s390/net/qeth_eddp.c ($Revision: 1.5 $)
+ * linux/drivers/s390/net/qeth_eddp.h
  *
- * Header file for qeth enhanced device driver pakcing.
+ * Header file for qeth enhanced device driver packing.
  *
  * Copyright 2004 IBM Corporation
  *
  *    Author(s): Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.5 $	 $Date: 2005/03/24 09:04:18 $
- *
  */
 #ifndef __QETH_EDDP_H__
 #define __QETH_EDDP_H__
diff -urpN linux-2.6/drivers/s390/net/qeth_fs.h linux-2.6-patched/drivers/s390/net/qeth_fs.h
--- linux-2.6/drivers/s390/net/qeth_fs.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_fs.h	2006-01-18 17:25:47.000000000 +0100
@@ -12,11 +12,6 @@
 #ifndef __QETH_FS_H__
 #define __QETH_FS_H__
 
-#define VERSION_QETH_FS_H "$Revision: 1.10 $"
-
-extern const char *VERSION_QETH_PROC_C;
-extern const char *VERSION_QETH_SYS_C;
-
 #ifdef CONFIG_PROC_FS
 extern int
 qeth_create_procfs_entries(void);
diff -urpN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2006-01-18 17:25:47.000000000 +0100
@@ -25,8 +25,6 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.152 $"
-
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
 #else
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,5 @@
 /*
- *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.251 $)
+ * linux/drivers/s390/net/qeth_main.c
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,8 +11,6 @@
  *			  Frank Pavlic (fpavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.251 $	 $Date: 2005/05/04 20:19:18 $
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2, or (at your option)
@@ -73,7 +70,6 @@
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.251 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -8626,12 +8622,7 @@ qeth_init(void)
 {
 	int rc=0;
 
-	PRINT_INFO("loading %s (%s/%s/%s/%s/%s/%s/%s %s %s)\n",
-		   version, VERSION_QETH_C, VERSION_QETH_H,
-		   VERSION_QETH_MPC_H, VERSION_QETH_MPC_C,
-		   VERSION_QETH_FS_H, VERSION_QETH_PROC_C,
-		   VERSION_QETH_SYS_C, QETH_VERSION_IPV6,
-		   QETH_VERSION_VLAN);
+	PRINT_INFO("loading %s\n", version);
 
 	INIT_LIST_HEAD(&qeth_card_list.list);
 	INIT_LIST_HEAD(&qeth_notify_list);
diff -urpN linux-2.6/drivers/s390/net/qeth_mpc.c linux-2.6-patched/drivers/s390/net/qeth_mpc.c
--- linux-2.6/drivers/s390/net/qeth_mpc.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_mpc.c	2006-01-18 17:25:47.000000000 +0100
@@ -11,8 +11,6 @@
 #include <asm/cio.h>
 #include "qeth_mpc.h"
 
-const char *VERSION_QETH_MPC_C = "$Revision: 1.13 $";
-
 unsigned char IDX_ACTIVATE_READ[]={
 	0x00,0x00,0x80,0x00, 0x00,0x00,0x00,0x00,
 	0x19,0x01,0x01,0x80, 0x00,0x00,0x00,0x00,
diff -urpN linux-2.6/drivers/s390/net/qeth_mpc.h linux-2.6-patched/drivers/s390/net/qeth_mpc.h
--- linux-2.6/drivers/s390/net/qeth_mpc.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_mpc.h	2006-01-18 17:25:47.000000000 +0100
@@ -14,10 +14,6 @@
 
 #include <asm/qeth.h>
 
-#define VERSION_QETH_MPC_H "$Revision: 1.46 $"
-
-extern const char *VERSION_QETH_MPC_C;
-
 #define IPA_PDU_HEADER_SIZE	0x40
 #define QETH_IPA_PDU_LEN_TOTAL(buffer) (buffer+0x0e)
 #define QETH_IPA_PDU_LEN_PDU1(buffer) (buffer+0x26)
diff -urpN linux-2.6/drivers/s390/net/qeth_proc.c linux-2.6-patched/drivers/s390/net/qeth_proc.c
--- linux-2.6/drivers/s390/net/qeth_proc.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_proc.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.16 $)
+ * linux/drivers/s390/net/qeth_fs.c
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to procfs.
@@ -21,8 +21,6 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_PROC_C = "$Revision: 1.16 $";
-
 /***** /proc/qeth *****/
 #define QETH_PROCFILE_NAME "qeth"
 static struct proc_dir_entry *qeth_procfile;
diff -urpN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-patched/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_sys.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.60 $)
+ * linux/drivers/s390/net/qeth_sys.c
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,8 +20,6 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.60 $";
-
 /*****************************************************************************/
 /*                                                                           */
 /*          /sys-fs stuff UNDER DEVELOPMENT !!!                              */
diff -urpN linux-2.6/drivers/s390/net/qeth_tso.h linux-2.6-patched/drivers/s390/net/qeth_tso.h
--- linux-2.6/drivers/s390/net/qeth_tso.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_tso.h	2006-01-18 17:25:47.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/s390/net/qeth_tso.h ($Revision: 1.8 $)
+ * linux/drivers/s390/net/qeth_tso.h
  *
  * Header file for qeth TCP Segmentation Offload support.
  *
@@ -7,8 +7,6 @@
  *
  *    Author(s): Frank Pavlic <fpavlic@de.ibm.com>
  *
- *    $Revision: 1.8 $	 $Date: 2005/05/04 20:19:18 $
- *
  */
 #ifndef __QETH_TSO_H__
 #define __QETH_TSO_H__
diff -urpN linux-2.6/drivers/s390/s390_rdev.c linux-2.6-patched/drivers/s390/s390_rdev.c
--- linux-2.6/drivers/s390/s390_rdev.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/s390_rdev.c	2006-01-18 17:25:47.000000000 +0100
@@ -1,7 +1,6 @@
 /*
  *  drivers/s390/s390_rdev.c
  *  s390 root device
- *   $Revision: 1.4 $
  *
  *    Copyright (C) 2002, 2005 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c	2006-01-18 17:25:47.000000000 +0100
@@ -29,8 +29,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_AUX_REVISION "$Revision: 1.145 $"
-
 #include "zfcp_ext.h"
 
 /* accumulated log level (module parameter) */
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_ccw.c linux-2.6-patched/drivers/s390/scsi/zfcp_ccw.c
--- linux-2.6/drivers/s390/scsi/zfcp_ccw.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_ccw.c	2006-01-18 17:25:47.000000000 +0100
@@ -27,8 +27,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_CCW_C_REVISION "$Revision: 1.58 $"
-
 #include "zfcp_ext.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_dbf.c linux-2.6-patched/drivers/s390/scsi/zfcp_dbf.c
--- linux-2.6/drivers/s390/scsi/zfcp_dbf.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_dbf.c	2006-01-18 17:25:47.000000000 +0100
@@ -23,8 +23,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_DBF_REVISION "$Revision$"
-
 #include <asm/debug.h>
 #include <linux/ctype.h>
 #include "zfcp_ext.h"
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-patched/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_def.h	2006-01-18 17:25:47.000000000 +0100
@@ -34,8 +34,6 @@
 #ifndef ZFCP_DEF_H
 #define ZFCP_DEF_H
 
-#define ZFCP_DEF_REVISION "$Revision: 1.111 $"
-
 /*************************** INCLUDES *****************************************/
 
 #include <linux/init.h>
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c	2006-01-18 17:25:47.000000000 +0100
@@ -31,8 +31,6 @@
 
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
-#define ZFCP_ERP_REVISION "$Revision: 1.86 $"
-
 #include "zfcp_ext.h"
 
 static int zfcp_erp_adisc(struct zfcp_port *);
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_ext.h linux-2.6-patched/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6/drivers/s390/scsi/zfcp_ext.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_ext.h	2006-01-18 17:25:47.000000000 +0100
@@ -32,8 +32,6 @@
 #ifndef ZFCP_EXT_H
 #define ZFCP_EXT_H
 
-#define ZFCP_EXT_REVISION "$Revision: 1.62 $"
-
 #include "zfcp_def.h"
 
 extern struct zfcp_data zfcp_data;
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c	2006-01-18 17:25:47.000000000 +0100
@@ -30,8 +30,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_FSF_C_REVISION "$Revision: 1.92 $"
-
 #include "zfcp_ext.h"
 
 static int zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *);
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_qdio.c linux-2.6-patched/drivers/s390/scsi/zfcp_qdio.c
--- linux-2.6/drivers/s390/scsi/zfcp_qdio.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_qdio.c	2006-01-18 17:25:47.000000000 +0100
@@ -29,8 +29,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_QDIO_C_REVISION "$Revision: 1.20 $"
-
 #include "zfcp_ext.h"
 
 static inline void zfcp_qdio_sbal_limit(struct zfcp_fsf_req *, int);
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c	2006-01-18 17:25:47.000000000 +0100
@@ -31,8 +31,6 @@
 
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
-#define ZFCP_SCSI_REVISION "$Revision: 1.74 $"
-
 #include "zfcp_ext.h"
 
 static void zfcp_scsi_slave_destroy(struct scsi_device *sdp);
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_adapter.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_adapter.c	2006-01-18 17:25:47.000000000 +0100
@@ -27,8 +27,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.38 $"
-
 #include "zfcp_ext.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_sysfs_driver.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_driver.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_driver.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_driver.c	2006-01-18 17:25:47.000000000 +0100
@@ -27,8 +27,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_DRIVER_C_REVISION "$Revision: 1.17 $"
-
 #include "zfcp_ext.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_port.c	2006-01-18 17:25:47.000000000 +0100
@@ -28,8 +28,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.47 $"
-
 #include "zfcp_ext.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_unit.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c	2006-01-18 17:25:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_unit.c	2006-01-18 17:25:47.000000000 +0100
@@ -28,8 +28,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.30 $"
-
 #include "zfcp_ext.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
diff -urpN linux-2.6/include/asm-s390/dasd.h linux-2.6-patched/include/asm-s390/dasd.h
--- linux-2.6/include/asm-s390/dasd.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/dasd.h	2006-01-18 17:25:47.000000000 +0100
@@ -8,8 +8,6 @@
  * any future changes wrt the API will result in a change of the APIVERSION reported
  * to userspace by the DASDAPIVER-ioctl
  *
- * $Revision: 1.6 $
- *
  */
 
 #ifndef DASD_H
diff -urpN linux-2.6/include/asm-s390/qdio.h linux-2.6-patched/include/asm-s390/qdio.h
--- linux-2.6/include/asm-s390/qdio.h	2006-01-18 17:25:27.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/qdio.h	2006-01-18 17:25:47.000000000 +0100
@@ -11,8 +11,6 @@
 #ifndef __QDIO_H__
 #define __QDIO_H__
 
-#define VERSION_QDIO_H "$Revision: 1.57 $"
-
 /* note, that most of the typedef's are from ingo. */
 
 #include <linux/interrupt.h>
