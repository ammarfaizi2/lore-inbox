Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312361AbSDJBkr>; Tue, 9 Apr 2002 21:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312364AbSDJBkr>; Tue, 9 Apr 2002 21:40:47 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:6303 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S312361AbSDJBkq>; Tue, 9 Apr 2002 21:40:46 -0400
Date: Tue, 9 Apr 2002 18:59:31 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Dolphin PCI-SCI drivers 1.19 posted 
Message-ID: <20020409185931.A12158@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Drivers for the Dolphin PCI-SCI (Scalable Coherent Interface) v1.19 
in both .tar.gz and RedHat Pakcage Manager (rpm) format  
have been posted to:

ftp.kernel.org:/pub/linux/kernel/people/jmerkey/sci/pci-sci-1.19-1
ftp.utah-nac.org:/sci/pci-sci-1.19-1
ftp.timpanogas.org:/sci/pci-sci-1.19-1

Performance testing of this release over SCI Fabric to remote
SCI attached RAID systems:

Tyan 2720 2 x P4 2.2 Ghz (x 22), 2GB Memory, 7500 Chipset
2 x 3Ware 7850 Raid controllers, Linux 2.4.19, WDC1200 ATA Drives

Write Through                  239 MB/S 
Read                           246 MB/S

SuperMicro P4DE6 2 x P4 2.2 Ghz (x 22) 2GB Memory, 7500 Chipset
2 x 3Ware 7850 Raid Controllers, Linux 2.4.19 WDC1200 ATA Drives

Write Through                  219 MB/S
Read                           235 MB/S

Changes/Bug fixes this release:

SISCI 1.11.4 ( April 5th 2002 )
*Added benchmark.sh script for easy benchmariking of test applications.
*Added alignement check for size and offsets of DMA transfers, in core_dma.c.
*Added options to vary offset and transfer size in dmatest.
*Added HP-UX / PARISC support. Thanks to Airy Andre ! Gnats #1402
*Cleaned up flags for new SISCI function SCIFlush(). Gnats #979
*Made SCIWaitForInterrupt() to fail if timeout is specified on systems not supporting
 timeouts. Gnats #1216
*Added new SISCI interface to do physical DMA operations. Gnats #1409
*Added optimization for 64 byte cache lines on AMD Athlon CPUS. Gnats #1394


IRM 1.11.4 ( April 5th 2002 )
*Solaris: Fixed typing error related to tridcoloring in drv/solgen/Driver.conf
*Removed hardcoded dma alignement values from genif.c, and made the
 query return values defined by the adapters. Gnats #1399
*Added HP-UX / PARISC support. Thanks to Airy Andre ! Gnats #1402
*Linux: Added support for new property use_runtime_config. Gnats #1406
*Linux: Added support for D336. Gnats #1365
*Linux: Added support for shared interrupt lines. Gnats #
*Added low level functionality for adapter card hot swap/power management.
 Gnats #1397
*Added support for Intel 815. Gnats #1400
*Linux: Added support for runtime configuration of IRM/Adaper. Gnats #1406


Please direct any bug reports to jmerkey@timpanogas.org or 
hugo@dolphinics.no.

Jeff Merkey


