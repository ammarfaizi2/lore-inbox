Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265235AbTLRQyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 11:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbTLRQyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 11:54:44 -0500
Received: from bay2-f77.bay2.hotmail.com ([65.54.247.77]:46093 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265235AbTLRQym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 11:54:42 -0500
X-Originating-IP: [148.87.1.171]
X-Originating-Email: [gonzalocoello@hotmail.com]
From: "Gonzalo Coello" <gonzalocoello@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Not able to load megaraid module after kernel upgrade from 2.4.9-e2 to 2.4.9-e25
Date: Thu, 18 Dec 2003 16:54:41 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F77LwSQcBqfrft00040881@hotmail.com>
X-OriginalArrivalTime: 18 Dec 2003 16:54:41.0478 (UTC) FILETIME=[A159CE60:01C3C587]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello I am running dell Power Edge 12600, with Firmware 1.68,

I have a Perc 4/Si RAID Controller BIOS version 1.04 FW 2.27 (the last 
version)

I installer Red Hat advanced server 2.4.9-e3 and works fine, the megaraid 
driver is OK, the driver I used is perc-rhas21-1194-a02.tar.gz (the last 
one)

When I upgrade to kernel 2.4.9-e25, using the rpm provided by Red hat, 
happens the same when upgrading to any version, like 2.4.9-e21.

When starting up, the bios can recognize the disk array with no problem, the 
server starts booting OK, but when it gets to load the megaraid module, it 
brakes:

The server is not able to boot any more, here is the error:

----------------

Red Hat nash version 3.2.6 starting
Loading scsi_mod module
SCSI subsystem driver Revision: 1.00
Loading sd_mod module
Loading megaraid module
megaraid: v1.18 (release Date: Wed Dec 4 11:33:00 EST 2002)
megaraid: no BIOS enabled.
/lib/megaraid.o: init_module:
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters
ERROR: /bin/insmod exited abnormally!
Mounting /proc filesystem
Creating root device
Mouting root filesystem
mount: error 19 mounting ext2
pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
Freeing unused kernel memory: 244 freed
Kernel panic: No init found. Try passing init= option to kernel


I can clearly see that the driver can't be loaded,there is a problem.

My question is: What is the problem with the driver after upgrading the 
kernel?

I think somehow when red hat is installed with the first kernel, there is 
some aditional configuration with this particular driver that is lost when 
upgrading.

What do I need to reconfigure?

Thanks in advance.

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

