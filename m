Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbTGJVsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbTGJVsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:48:12 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:55300 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266499AbTGJVpm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:45:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: FW: cciss updates for 2.4.22-pre3  [4 of 6]
Date: Thu, 10 Jul 2003 17:00:19 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF104052A66@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss updates for 2.4.22-pre3  [4 of 6]
Thread-Index: AcNHLT/BhFrCJB5JSMSv03ppBleHvQAAV7EA
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Jul 2003 22:00:19.0867 (UTC) FILETIME=[A76026B0:01C3472E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Miller, Mike (OS Dev) 
Sent: Thursday, July 10, 2003 4:50 PM
To: 'axboe@suse.de'; 'marcelo@conectiva.com.br'
Cc: 'alan@lxorguk.ukuu.org.uk'; 'linuxkernel@vger.kernel.org'
Subject: cciss updates for 2.4.22-pre3 [4 of 6]


These patches can be installed in any order EXCEPT the final 2 of the 6. They are named p1* & p2* respectively.

This patch was built & tested using kernel 2.4.21 with the 2.4.22pre3 patch
applied. It is intended for inclusion in the 2.4.22 kernel.
Patch name: cciss_2447_version_change_for_lx2422p3.patch
Changes:
	1. Bumps the version number from 2.4.44 to 2.4.47. 2.4.47 is the 
	   preferred number version to use in kernel 2.4.22.

diff -burN lx2422p3.orig/drivers/block/cciss.c lx2422p3/drivers/block/cciss.c
--- lx2422p3.orig/drivers/block/cciss.c	2003-07-07 11:18:21.000000000 -0500
+++ lx2422p3/drivers/block/cciss.c	2003-07-07 13:14:23.000000000 -0500
@@ -44,12 +44,12 @@
 #include <linux/genhd.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.4.44)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,44)
+#define DRIVER_NAME "HP CISS Driver (v 2.4.47)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,47)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Charles M. White III - Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.44");
+MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.47");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"); 
 MODULE_LICENSE("GPL");
