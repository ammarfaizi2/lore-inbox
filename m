Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSGJIPS>; Wed, 10 Jul 2002 04:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSGJIPR>; Wed, 10 Jul 2002 04:15:17 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.9]:38386 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S316896AbSGJIPQ>; Wed, 10 Jul 2002 04:15:16 -0400
Date: Wed, 10 Jul 2002 04:18:00 -0400
From: Bill Darrow <bdarrow@optonline.net>
Subject: [patch] regards SIS645DX/SIS5513
To: linux-kernel@vger.kernel.org
Message-id: <20020710041800.34945f02.bdarrow@optonline.net>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick hack to support SiS645dx(646)/961B onboard 5513 family IDE controller for those of you with 645dx boards....

diff -c -b -r linuxold/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
*** linuxold/drivers/ide/sis5513.c	Wed Jul 10 04:00:48 2002
--- linux/drivers/ide/sis5513.c	Wed Jul 10 00:03:14 2002
***************
*** 177,182 ****
--- 177,183 ----
  	{ "SiS730",	PCI_DEVICE_ID_SI_730,	ATA_100a,	SIS5513_LATENCY },
  	{ "SiS650",	PCI_DEVICE_ID_SI_650,	ATA_100,	SIS5513_LATENCY },
  	{ "SiS645",	PCI_DEVICE_ID_SI_645,	ATA_100,	SIS5513_LATENCY },
+ 	{ "SiS646",	PCI_DEVICE_ID_SI_646,   ATA_100,	SIS5513_LATENCY },
  	{ "SiS635",	PCI_DEVICE_ID_SI_635,	ATA_100,	SIS5513_LATENCY },
  	{ "SiS640",	PCI_DEVICE_ID_SI_640,	ATA_66,		SIS5513_LATENCY },
  	{ "SiS630",	PCI_DEVICE_ID_SI_630,	ATA_66,		SIS5513_LATENCY },
diff -c -b -r linuxold/include/linux/pci_ids.h linux/include/linux/pci_ids.h
*** linuxold/include/linux/pci_ids.h	Wed Jul 10 03:59:40 2002
--- linux/include/linux/pci_ids.h	Wed Jul 10 00:10:41 2002
***************
*** 475,480 ****
--- 475,481 ----
  #define PCI_DEVICE_ID_SI_635		0x0635
  #define PCI_DEVICE_ID_SI_640		0x0640
  #define PCI_DEVICE_ID_SI_645		0x0645
+ #define PCI_DEVICE_ID_SI_646		0x0646
  #define PCI_DEVICE_ID_SI_650		0x0650
  #define PCI_DEVICE_ID_SI_730		0x0730
  #define PCI_DEVICE_ID_SI_630_VGA	0x6300


Bill
