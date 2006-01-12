Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWALRVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWALRVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWALRVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:21:43 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:31156 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751466AbWALRVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:21:42 -0500
Date: Thu, 12 Jan 2006 18:19:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cornelia.huck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 13/13] s390: email-address change.
Message-ID: <20060112171932.GN16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[patch 13/13] s390: email-address change.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/airq.c          |    4 ++--
 drivers/s390/cio/blacklist.c     |    4 ++--
 drivers/s390/cio/ccwgroup.c      |    4 ++--
 drivers/s390/cio/chsc.c          |    4 ++--
 drivers/s390/cio/cio.c           |    4 ++--
 drivers/s390/cio/css.c           |    4 ++--
 drivers/s390/cio/device.c        |    4 ++--
 drivers/s390/cio/device_fsm.c    |    2 +-
 drivers/s390/cio/device_id.c     |    2 +-
 drivers/s390/cio/device_ops.c    |    4 ++--
 drivers/s390/cio/device_pgid.c   |    2 +-
 drivers/s390/cio/device_status.c |    2 +-
 drivers/s390/cio/qdio.c          |    4 ++--
 drivers/s390/net/ctcmain.c       |    8 ++++----
 drivers/s390/net/cu3088.c        |    4 ++--
 drivers/s390/net/netiucv.c       |    9 +++++----
 drivers/s390/s390_rdev.c         |    4 ++--
 include/asm-s390/s390_rdev.h     |    2 +-
 18 files changed, 36 insertions(+), 35 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/airq.c linux-2.6-patched/drivers/s390/cio/airq.c
--- linux-2.6/drivers/s390/cio/airq.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/airq.c	2006-01-12 15:44:04.000000000 +0100
@@ -2,12 +2,12 @@
  *  drivers/s390/cio/airq.c
  *   S/390 common I/O routines -- support for adapter interruptions
  *
- *   $Revision: 1.12 $
+ *   $Revision: 1.15 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
  *    Author(s): Ingo Adlung (adlung@de.ibm.com)
- *		 Cornelia Huck (cohuck@de.ibm.com)
+ *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Arnd Bergmann (arndb@de.ibm.com)
  */
 
diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2006-01-12 15:44:04.000000000 +0100
@@ -1,12 +1,12 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.39 $
+ *   $Revision: 1.42 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
  *    Author(s): Ingo Adlung (adlung@de.ibm.com)
- *		 Cornelia Huck (cohuck@de.ibm.com)
+ *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Arnd Bergmann (arndb@de.ibm.com)
  */
 
diff -urpN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-patched/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/ccwgroup.c	2006-01-12 15:44:04.000000000 +0100
@@ -1,12 +1,12 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.33 $
+ *   $Revision: 1.35 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
- *               Cornelia Huck (cohuck@de.ibm.com)
+ *               Cornelia Huck (cornelia.huck@de.ibm.com)
  */
 #include <linux/module.h>
 #include <linux/errno.h>
diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-01-12 15:44:04.000000000 +0100
@@ -1,12 +1,12 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.126 $
+ *   $Revision: 1.128 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
  *    Author(s): Ingo Adlung (adlung@de.ibm.com)
- *		 Cornelia Huck (cohuck@de.ibm.com)
+ *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Arnd Bergmann (arndb@de.ibm.com)
  */
 
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-01-12 15:44:04.000000000 +0100
@@ -1,12 +1,12 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.138 $
+ *   $Revision: 1.140 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
  *    Author(s): Ingo Adlung (adlung@de.ibm.com)
- *		 Cornelia Huck (cohuck@de.ibm.com)
+ *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Arnd Bergmann (arndb@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-01-12 15:44:04.000000000 +0100
@@ -1,12 +1,12 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.93 $
+ *   $Revision: 1.96 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
- *		 Cornelia Huck (cohuck@de.ibm.com)
+ *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  */
 #include <linux/module.h>
 #include <linux/init.h>
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-01-12 15:44:05.000000000 +0100
@@ -1,12 +1,12 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.137 $
+ *   $Revision: 1.140 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
- *		 Cornelia Huck (cohuck@de.ibm.com)
+ *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 #include <linux/config.h>
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-01-12 15:44:05.000000000 +0100
@@ -4,7 +4,7 @@
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
- *    Author(s): Cornelia Huck(cohuck@de.ibm.com)
+ *    Author(s): Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
diff -urpN linux-2.6/drivers/s390/cio/device_id.c linux-2.6-patched/drivers/s390/cio/device_id.c
--- linux-2.6/drivers/s390/cio/device_id.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_id.c	2006-01-12 15:44:05.000000000 +0100
@@ -3,7 +3,7 @@
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
- *    Author(s): Cornelia Huck(cohuck@de.ibm.com)
+ *    Author(s): Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
  * Sense ID functions.
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-01-12 15:44:05.000000000 +0100
@@ -1,12 +1,12 @@
 /*
  *  drivers/s390/cio/device_ops.c
  *
- *   $Revision: 1.58 $
+ *   $Revision: 1.61 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *               Cornelia Huck (cohuck@de.ibm.com)
+ *               Cornelia Huck (cornelia.huck@de.ibm.com)
  */
 #include <linux/config.h>
 #include <linux/module.h>
diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2006-01-12 15:44:05.000000000 +0100
@@ -3,7 +3,7 @@
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
- *    Author(s): Cornelia Huck(cohuck@de.ibm.com)
+ *    Author(s): Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
  * Path Group ID functions.
diff -urpN linux-2.6/drivers/s390/cio/device_status.c linux-2.6-patched/drivers/s390/cio/device_status.c
--- linux-2.6/drivers/s390/cio/device_status.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_status.c	2006-01-12 15:44:05.000000000 +0100
@@ -3,7 +3,7 @@
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
- *    Author(s): Cornelia Huck(cohuck@de.ibm.com)
+ *    Author(s): Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
  * Status accumulation and basic sense functions.
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-01-12 15:44:05.000000000 +0100
@@ -7,7 +7,7 @@
  *
  * Copyright 2000,2002 IBM Corporation
  * Author(s):             Utz Bacher <utz.bacher@de.ibm.com>
- * 2.6 cio integration by Cornelia Huck <cohuck@de.ibm.com>
+ * 2.6 cio integration by Cornelia Huck <cornelia.huck@de.ibm.com>
  *
  * Restriction: only 63 iqdio subchannels would have its own indicator,
  * after that, subsequent subchannels share one indicator
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.114 $"
+#define VERSION_QDIO_C "$Revision: 1.117 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
diff -urpN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-patched/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctcmain.c	2006-01-12 15:44:04.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.78 2005/09/07 12:18:02 pavlic Exp $
+ * $Id: ctcmain.c,v 1.79 2006/01/11 11:32:18 cohuck Exp $
  *
  * CTC / ESCON network driver
  *
@@ -8,7 +8,7 @@
  * Fixes by : Jochen Röhrig (roehrig@de.ibm.com)
  *            Arnaldo Carvalho de Melo <acme@conectiva.com.br>
 	      Peter Tiedemann (ptiedem@de.ibm.com)
- * Driver Model stuff by : Cornelia Huck <cohuck@de.ibm.com>
+ * Driver Model stuff by : Cornelia Huck <huckc@de.ibm.com>
  *
  * Documentation used:
  *  - Principles of Operation (IBM doc#: SA22-7201-06)
@@ -37,7 +37,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.78 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.79 $
  *
  */
 #undef DEBUG
@@ -248,7 +248,7 @@ static void
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.78 $";
+	char vbuf[] = "$Revision: 1.79 $";
 	char *version = vbuf;
 
 	if (printed)
diff -urpN linux-2.6/drivers/s390/net/cu3088.c linux-2.6-patched/drivers/s390/net/cu3088.c
--- linux-2.6/drivers/s390/net/cu3088.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/cu3088.c	2006-01-12 15:44:05.000000000 +0100
@@ -1,11 +1,11 @@
 /*
- * $Id: cu3088.c,v 1.36 2005/10/25 14:37:17 cohuck Exp $
+ * $Id: cu3088.c,v 1.38 2006/01/12 14:33:09 cohuck Exp $
  *
  * CTC / LCS ccw_device driver
  *
  * Copyright (C) 2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
  * Author(s): Arnd Bergmann <arndb@de.ibm.com>
- *            Cornelia Huck <cohuck@de.ibm.com>
+ *            Cornelia Huck <cornelia.huck@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff -urpN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-patched/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/netiucv.c	2006-01-12 15:44:05.000000000 +0100
@@ -1,12 +1,13 @@
 /*
- * $Id: netiucv.c,v 1.66 2005/05/11 08:10:17 holzheu Exp $
+ * $Id: netiucv.c,v 1.69 2006/01/12 14:33:09 cohuck Exp $
  *
  * IUCV network driver
  *
  * Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
  * Author(s): Fritz Elfert (elfert@de.ibm.com, felfert@millenux.com)
  *
- * Driverfs integration and all bugs therein by Cornelia Huck(cohuck@de.ibm.com)
+ * Sysfs integration and all bugs therein by Cornelia Huck
+ * (cornelia.huck@de.ibm.com)
  *
  * Documentation used:
  *  the source of the original IUCV driver by:
@@ -30,7 +31,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.66 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.69 $
  *
  */
 
@@ -2076,7 +2077,7 @@ DRIVER_ATTR(remove, 0200, NULL, remove_w
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.66 $";
+	char vbuf[] = "$Revision: 1.69 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urpN linux-2.6/drivers/s390/s390_rdev.c linux-2.6-patched/drivers/s390/s390_rdev.c
--- linux-2.6/drivers/s390/s390_rdev.c	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/s390_rdev.c	2006-01-12 15:44:05.000000000 +0100
@@ -1,11 +1,11 @@
 /*
  *  drivers/s390/s390_rdev.c
  *  s390 root device
- *   $Revision: 1.2 $
+ *   $Revision: 1.4 $
  *
  *    Copyright (C) 2002, 2005 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
- *    Author(s): Cornelia Huck (cohuck@de.ibm.com)
+ *    Author(s): Cornelia Huck (cornelia.huck@de.ibm.com)
  *		  Carsten Otte  (cotte@de.ibm.com)
  */
 
diff -urpN linux-2.6/include/asm-s390/s390_rdev.h linux-2.6-patched/include/asm-s390/s390_rdev.h
--- linux-2.6/include/asm-s390/s390_rdev.h	2006-01-12 15:43:32.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/s390_rdev.h	2006-01-12 15:44:05.000000000 +0100
@@ -2,7 +2,7 @@
  *  include/asm-s390/ccwdev.h
  *
  *    Copyright (C) 2002,2005 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Cornelia Huck <cohuck@de.ibm.com>
+ *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  *               Carsten Otte  <cotte@de.ibm.com>
  *
  *  Interface for s390 root device
