Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269868AbRHDW21>; Sat, 4 Aug 2001 18:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269870AbRHDW2S>; Sat, 4 Aug 2001 18:28:18 -0400
Received: from dnai-216-15-62-124.cust.dnai.com ([216.15.62.124]:20172 "HELO
	soni.ppetru.net") by vger.kernel.org with SMTP id <S269868AbRHDW2L>;
	Sat, 4 Aug 2001 18:28:11 -0400
Date: Sat, 4 Aug 2001 15:27:15 -0700
To: linux-kernel@vger.kernel.org
Subject: Megaraid trouble in 2.4.8-pre and 2.4.7-ac
Message-ID: <20010804152714.C466@ppetru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: ppetru@ppetru.net (Petru Paler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this:

megaraid: v1.17a (Release Date: Fri Jul 13 18:44:01 EDT 2001)
PCI: Found IRQ 5 for device 01:02.0
megaraid: found 0x101e:0x1960:idx 0:bus 1:slot 2:func 0
scsi0 : Found a MegaRAID controller at 0xf8802000, IRQ: 5
scsi0 : Enabling 64 bit support
megaraid: [l148:3.11] detected 1 logical drives
megaraid: channel[1] is raid.
scsi0 : AMI MegaRAID l148 254 commands 16 targs 1 chans 40 luns
scsi0: scanning channel 1 for devices.
scsi0: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5 35254R  Rev: l148
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 1, id 0, lun 0
Partition check:
 sda:scsi : aborting command due to timeout : pid 0, scsi0, channel 1, id 0, lun 0 Read (10) 00 00 00 00 00 00 00 02 00

when trying to boot 2.4.8-pre4 or 2.4.7-ac5, then the machine hangs.
2.4.7 works fine.

Any ideeas?

Petru
