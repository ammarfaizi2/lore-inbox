Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTD1NX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 09:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTD1NX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 09:23:28 -0400
Received: from brln-d51481d7.dsl.mediaWays.net ([213.20.129.215]:60641 "EHLO
	freeside.dungeon.de") by vger.kernel.org with ESMTP id S263570AbTD1NX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 09:23:27 -0400
From: Oliver Sommer <oliver@kernzeit.com>
Organization: Kernzeit GmbH
To: linux-kernel@vger.kernel.org
Subject: [bugreport] aic7xxx, DV failed to configure device
Date: Mon, 28 Apr 2003 15:35:05 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304281535.05891.oliver@kernzeit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the kernel logging messages ask me to file this "bug report".
I hope this is the right place to do so.


--snip--

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 2940 Ultra2 SCSI adapter (OEM)>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi0:A:0:0: DV failed to configure device.  Please file a bug report against 
this driver.
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: IBM       Model: DDYS-T18350N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: DV failed to configure device.  Please file a bug report against 
this driver.
(scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1 p2 p3

--snap--

little system info:
distribution is gentoo, kernel is the gentoo-patched kernel
uname -a:
Linux <hostname> 2.4.20-gentoo-r2 #5 SMP Thu Apr 10 14:11:34 CEST 2003 i686 
Pentium III (Katmai) GenuineIntel GNU/Linux
(gcc version 3.2.2)

Actually we had problems on the machine a few months ago, but we believe it is 
a buggy harddisk.The second harddisk sometimes "disappeard" (/dev/sdb: no 
such device or address). in the time before we had no problems at all. 
just repeating myself:
I just filed this "bug report" because the driver asked me to do so.
I think my problem was a buggy harddisk.

for any replies, please CC me directly as I am not on the list.

cheers, oliver


