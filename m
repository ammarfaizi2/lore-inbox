Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264669AbUFLI07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbUFLI07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 04:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264670AbUFLI06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 04:26:58 -0400
Received: from node-d-4940.a2000.nl ([62.195.73.64]:45189 "EHLO mail.ennes.net")
	by vger.kernel.org with ESMTP id S264669AbUFLI05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 04:26:57 -0400
Message-ID: <40CABE4F.1040104@spam.ennes.net>
Date: Sat, 12 Jun 2004 10:26:55 +0200
From: Pieter Ennes <lkml@spam.ennes.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040526)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc3-mm1 and advansys driver failes to mount
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having troubles getting the advansys driver to work in
2.6.7-rc3-mm1. dmesg output seems OK, but when mounting
no filesystem can be found on the partitions.

2.6.7-rc3 is fine. I noticed a few changes in drivers/scsi/advansys.c,
but i'm not much of a hacker to sort it out...

scsi1 : AdvanSys SCSI 3.3GJ: PCI Ultra-Wide: PCIMEM 
0xE0BE0000-0xE0BE003F, IRQ 0x13
   Vendor: SEAGATE   Model: ST39173W          Rev: 6244
   Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdb: 17783240 512-byte hdwr sectors (9105 MB)
SCSI device sdb: drive cache: write back
  /dev/scsi/host1/bus0/target2/lun0: unknown partition table
Attached scsi disk sdb at scsi1, channel 0, id 2, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 2, lun 0,  type 0
   Vendor: IBM       Model: IC35L036UWD210-0  Rev: S5CQ
   Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdc: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sdc: drive cache: write back
  /dev/scsi/host1/bus0/target6/lun0: unknown partition table
Attached scsi disk sdc at scsi1, channel 0, id 6, lun 0
Attached scsi generic sg2 at scsi1, channel 0, id 6, lun 0,  type 0

Cheers,
-- 
  - Pieter

