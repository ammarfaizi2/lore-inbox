Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264132AbUE1WEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUE1WEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUE1VlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:41:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:37043 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263971AbUE1ViF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:38:05 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <10857801151567@kroah.com>
Date: Fri, 28 May 2004 14:35:15 -0700
Message-Id: <1085780115273@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.6.25, 2004/05/19 10:33:24-07:00, greg@kroah.com

Reversed pci.ids changes, as Linus already fixed them in his tree


 drivers/pci/pci.ids |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Fri May 28 14:29:15 2004
+++ b/drivers/pci/pci.ids	Fri May 28 14:29:15 2004
@@ -2331,7 +2331,7 @@
 	c801  PCI-GPIB
 	c831  PCI-GPIB bridge
 1094  First International Computers [FIC]
-1095  Silicon Image, Inc.
+1095  Silicon Image, Inc. (formerly CMD Technology Inc)
 	0240  Adaptec AAR-1210SA SATA HostRAID Controller
 	0640  PCI0640
 	0643  PCI0643
@@ -5155,7 +5155,7 @@
 	9132  Ethernet 100/10 MBit
 1283  Integrated Technology Express, Inc.
 	673a  IT8330G
-	8212  IT/ITE8212 Dual channel ATA RAID controller
+	8212  IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be IT8212, embedded seems to be ITE8212)
 	8330  IT8330G
 	8872  IT8874F PCI Dual Serial Port Controller
 	8888  IT8888F PCI to ISA Bridge with SMB
@@ -6098,7 +6098,7 @@
 	0340  PC4800
 	0350  PC4800
 	4500  PC4500
-	4800  Cisco Aironet 340 802.11b Wireless LAN Adapter
+	4800  Cisco Aironet 340 802.11b Wireless LAN Adapter/Aironet PC4800
 	a504  Cisco Aironet Wireless 802.11b
 	a505  Cisco Aironet CB20a 802.11a Wireless LAN Adapter
 14ba  INTERNIX Inc.
@@ -6824,7 +6824,7 @@
 1629  Kongsberg Spacetec AS
 	1003  Format synchronizer v3.0
 	2002  Fast Universal Data Output
-1638  SMC
+1638  Standard Microsystems Corp [SMC]
 	1100  SMC2602W EZConnect / Addtron AWA-100 / Eumitcom PCI WL11000
 163c  Smart Link Ltd.
 	3052  SmartLink SmartPCI562 56K Modem

