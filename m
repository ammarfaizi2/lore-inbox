Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbTIWUzj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTIWUzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:55:39 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.36.233]:25303 "EHLO
	ms-smtp-05.texas.rr.com") by vger.kernel.org with ESMTP
	id S263413AbTIWUz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:55:29 -0400
Date: Tue, 23 Sep 2003 15:55:26 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@iguana.localdomain
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s/Dell Computer Corporation/Dell Inc./
In-Reply-To: <Pine.LNX.4.44.0309231404110.11196-100000@iguana.localdomain>
Message-ID: <Pine.LNX.4.44.0309231554570.12214-100000@iguana.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1326, 2003-09-23 13:52:38-05:00, Matt_Domsch@dell.com
  s/Dell Computer Corporation/Dell Inc./
  
  Necessary due to company name change.


 CREDITS                     |    2 +-
 arch/i386/kernel/dmi_scan.c |    2 +-
 arch/i386/kernel/edd.c      |    2 +-
 arch/ia64/kernel/mca.c      |    2 +-
 drivers/ieee1394/oui.db     |    6 +++---
 drivers/scsi/aacraid/README |    8 ++++----
 fs/partitions/efi.c         |    2 +-
 fs/partitions/efi.h         |    2 +-
 include/asm-i386/edd.h      |    2 +-
 include/linux/pci-dynids.h  |    2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)


diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Tue Sep 23 13:53:47 2003
+++ b/CREDITS	Tue Sep 23 13:53:47 2003
@@ -771,7 +771,7 @@
 W: http://domsch.com/linux
 D: Linux/IA-64
 D: Dell PowerEdge server, SCSI layer, misc drivers, and other patches
-S: Dell Computer Corporation
+S: Dell Inc.
 S: One Dell Way
 S: Round Rock, TX  78682
 S: USA
diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	Tue Sep 23 13:53:47 2003
+++ b/arch/i386/kernel/dmi_scan.c	Tue Sep 23 13:53:47 2003
@@ -205,7 +205,7 @@
 
 /* 
  * Reboot options and system auto-detection code provided by
- * Dell Computer Corporation so their systems "just work". :-)
+ * Dell Inc. so their systems "just work". :-)
  */
 
 /* 
diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Tue Sep 23 13:53:47 2003
+++ b/arch/i386/kernel/edd.c	Tue Sep 23 13:53:47 2003
@@ -1,6 +1,6 @@
 /*
  * linux/arch/i386/kernel/edd.c
- *  Copyright (C) 2002, 2003 Dell Computer Corporation
+ *  Copyright (C) 2002, 2003 Dell Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
  *
  * BIOS Enhanced Disk Drive Services (EDD)
diff -Nru a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
--- a/arch/ia64/kernel/mca.c	Tue Sep 23 13:53:47 2003
+++ b/arch/ia64/kernel/mca.c	Tue Sep 23 13:53:47 2003
@@ -6,7 +6,7 @@
  * Copyright (C) 2003 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  *
- * Copyright (C) 2002 Dell Computer Corporation
+ * Copyright (C) 2002 Dell Inc.
  * Copyright (C) Matt Domsch (Matt_Domsch@dell.com)
  *
  * Copyright (C) 2002 Intel
diff -Nru a/drivers/ieee1394/oui.db b/drivers/ieee1394/oui.db
--- a/drivers/ieee1394/oui.db	Tue Sep 23 13:53:47 2003
+++ b/drivers/ieee1394/oui.db	Tue Sep 23 13:53:47 2003
@@ -1612,7 +1612,7 @@
 000658 Helmut Fischer GmbH & Co. KG
 000659 EAL (Apeldoorn) B.V.
 00065A Strix Systems
-00065B Dell Computer Corp.
+00065B Dell Inc.
 00065C Malachite Technologies, Inc.
 00065D Heidelberg Web Systems
 00065E Photuris, Inc.
@@ -3965,7 +3965,7 @@
 00B0C2 Cisco Systems, Inc.
 00B0C7 Tellabs Operations, Inc.
 00B0CE TECHNOLOGY RESCUE
-00B0D0 Dell Computer Corp.
+00B0D0 Dell Inc.
 00B0DB Nextcell, Inc.
 00B0DF Reliable Data Technology, Inc.
 00B0E7 British Federal Ltd.
@@ -4054,7 +4054,7 @@
 00C04C DEPARTMENT OF FOREIGN AFFAIRS
 00C04D MITEC, INC.
 00C04E COMTROL CORPORATION
-00C04F DELL COMPUTER CORPORATION
+00C04F Dell Inc.
 00C050 TOYO DENKI SEIZO K.K.
 00C051 ADVANCED INTEGRATION RESEARCH
 00C052 BURR-BROWN
diff -Nru a/drivers/scsi/aacraid/README b/drivers/scsi/aacraid/README
--- a/drivers/scsi/aacraid/README	Tue Sep 23 13:53:47 2003
+++ b/drivers/scsi/aacraid/README	Tue Sep 23 13:53:47 2003
@@ -10,10 +10,10 @@
 
 Supported Cards/Chipsets
 -------------------------
-	Dell Computer Corporation PERC 2 Quad Channel
-	Dell Computer Corporation PERC 2/Si
-	Dell Computer Corporation PERC 3/Si
-	Dell Computer Corporation PERC 3/Di
+	Dell PERC 2 Quad Channel
+	Dell PERC 2/Si
+	Dell PERC 3/Si
+	Dell PERC 3/Di
 	HP NetRAID-4M
 	ADAPTEC 2120S
 	ADAPTEC 2200S
diff -Nru a/fs/partitions/efi.c b/fs/partitions/efi.c
--- a/fs/partitions/efi.c	Tue Sep 23 13:53:47 2003
+++ b/fs/partitions/efi.c	Tue Sep 23 13:53:47 2003
@@ -3,7 +3,7 @@
  * Per Intel EFI Specification v1.02
  * http://developer.intel.com/technology/efi/efi.htm
  * efi.[ch] by Matt Domsch <Matt_Domsch@dell.com>
- *   Copyright 2000,2001,2002 Dell Computer Corporation
+ *   Copyright 2000,2001,2002 Dell Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff -Nru a/fs/partitions/efi.h b/fs/partitions/efi.h
--- a/fs/partitions/efi.h	Tue Sep 23 13:53:47 2003
+++ b/fs/partitions/efi.h	Tue Sep 23 13:53:47 2003
@@ -4,7 +4,7 @@
  * http://developer.intel.com/technology/efi/efi.htm
  *
  * By Matt Domsch <Matt_Domsch@dell.com>  Fri Sep 22 22:15:56 CDT 2000  
- *   Copyright 2000,2001 Dell Computer Corporation
+ *   Copyright 2000,2001 Dell Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
diff -Nru a/include/asm-i386/edd.h b/include/asm-i386/edd.h
--- a/include/asm-i386/edd.h	Tue Sep 23 13:53:47 2003
+++ b/include/asm-i386/edd.h	Tue Sep 23 13:53:47 2003
@@ -1,6 +1,6 @@
 /*
  * linux/include/asm-i386/edd.h
- *  Copyright (C) 2002 Dell Computer Corporation
+ *  Copyright (C) 2002 Dell Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
  *
  * structures and definitions for the int 13h, ax={41,48}h
diff -Nru a/include/linux/pci-dynids.h b/include/linux/pci-dynids.h
--- a/include/linux/pci-dynids.h	Tue Sep 23 13:53:47 2003
+++ b/include/linux/pci-dynids.h	Tue Sep 23 13:53:47 2003
@@ -1,6 +1,6 @@
 /*
  *	PCI defines and function prototypes
- *	Copyright 2003 Dell Computer Corporation
+ *	Copyright 2003 Dell Inc.
  *        by Matt Domsch <Matt_Domsch@dell.com>
  */
 

===================================================================


This BitKeeper patch contains the following changesets:
1.1326
## Wrapped with gzip_uu ##


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
2E1RS9E8WG#G_ R3TVBH1'   
 

