Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbUKXNtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbUKXNtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUKXNsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:48:41 -0500
Received: from lucidpixels.com ([66.45.37.187]:39825 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262656AbUKXNV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:21:59 -0500
Date: Wed, 24 Nov 2004 08:21:53 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.9 3rd SCSI Driver Compiliation Error w/GCC-3.4.2
Message-ID: <Pine.LNX.4.61.0411240821330.19627@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@p500b:/usr/src/linux# make modules
   CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
   CC [M]  drivers/scsi/pci2220i.o
drivers/scsi/pci2220i.c:37:2: #error Convert me to understand page+offset 
based scatterlists
drivers/scsi/pci2220i.c: In function `WalkScatGath':
drivers/scsi/pci2220i.c:470: error: structure has no member named 
`address'
drivers/scsi/pci2220i.c: In function `Pci2220i_QueueCommand':
drivers/scsi/pci2220i.c:2060: error: structure has no member named 
`address'
drivers/scsi/pci2220i.c: In function `Pci2220i_Detect':
drivers/scsi/pci2220i.c:2632: warning: implicit declaration of function 
`scsi_set_pci_device'
drivers/scsi/pci2220i.c: At top level:
drivers/scsi/pci2220i.c:2906: warning: initialization from incompatible 
pointer type
drivers/scsi/pci2220i.c:2907: warning: initialization from incompatible 
pointer type
make[2]: *** [drivers/scsi/pci2220i.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2
root@p500b:/usr/src/linux#

