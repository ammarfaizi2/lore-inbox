Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWIZU77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWIZU77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWIZU77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:59:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41693 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932310AbWIZU76
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:59:58 -0400
Subject: Re: pata_serverworks oopses in latest -git
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Diego Calleja <diegocg@gmail.com>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060926223857.56b0047d.diegocg@gmail.com>
References: <20060926140016.54d532ba.diegocg@gmail.com>
	 <1159275010.11049.215.camel@localhost.localdomain>
	 <45194DAD.6060904@garzik.org> <20060926212939.69b52f0d.diegocg@gmail.com>
	 <1159300946.11049.300.camel@localhost.localdomain>
	 <20060926223857.56b0047d.diegocg@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 22:24:31 +0100
Message-Id: <1159305871.11049.316.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh.. OSB4IDE not OSB4


Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_serverworks.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_serverworks.c	2006-09-26 21:44:17.190601032 +0100
@@ -41,7 +41,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_serverworks"
-#define DRV_VERSION "0.3.6"
+#define DRV_VERSION "0.3.7"
 
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
@@ -128,7 +128,7 @@
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_VENDOR_ID_DELL, dell_cable },
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB6IDE, PCI_VENDOR_ID_DELL, dell_cable },
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_VENDOR_ID_SUN,  sun_cable },
-	{ PCI_DEVICE_ID_SERVERWORKS_OSB4, PCI_ANY_ID, osb4_cable },
+	{ PCI_DEVICE_ID_SERVERWORKS_OSB4IDE, PCI_ANY_ID, osb4_cable },
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_ANY_ID, csb_cable },
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB6IDE, PCI_ANY_ID, csb_cable },
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2, PCI_ANY_ID, csb_cable },



