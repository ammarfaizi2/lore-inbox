Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273749AbRI0R6f>; Thu, 27 Sep 2001 13:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273751AbRI0R6Z>; Thu, 27 Sep 2001 13:58:25 -0400
Received: from mailhost.iworld.com ([63.95.15.3]:31666 "EHLO
	mailhost.iworld.com") by vger.kernel.org with ESMTP
	id <S273749AbRI0R6Q>; Thu, 27 Sep 2001 13:58:16 -0400
Message-ID: <3BB3684F.A4A4DB3C@internet.com>
Date: Thu, 27 Sep 2001 13:56:31 -0400
From: Byron Albert <balbert@internet.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: megaraid driver only seeing 2 of 3 logical dirve.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just added an ami megaraid card to a machine. I configured the 6  9gb
drives to look like 3 18gb drives and then booted. Linux only saw 2 of
the 3 drive.  I think got the latest kernel and compiled and rebooted
and the same below is the relevant dmesg info.  It says it detected 3
logical drives but the driver only uses two of them.

I really need this other drive so any help would be appreciated.

Byron

p.s. please cc me as I am in the proccess of joining the list


SCSI subsystem driver Revision: 1.00
megaraid: v1.17a (Release Date: Fri Jul 13 18:44:01 EDT 2001)
megaraid: found 0x8086:0x1960:idx 0:bus 0:slot 5:func 1
scsi0 : Found a MegaRAID controller at 0xf8808000, IRQ: 10
megaraid: [C :B ] detected 3 logical drives
megaraid: channel[1] is raid.
megaraid: channel[2] is raid.
megaraid: channel[3] is raid.
megaraid: no BIOS enabled.
scsi0 : AMI MegaRAID C  254 commands 16 targs 3 chans 8 luns
scsi0: scanning channel 1 for devices.
scsi0: scanning channel 2 for devices.
scsi0: scanning channel 3 for devices.
scsi0: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID0 17354R  Rev:   C
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: MegaRAID  Model: LD1 RAID0 17354R  Rev:   C
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 3, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 3, id 0, lun 1
SCSI device sda: 35540992 512-byte hdwr sectors (18197 MB)
 sda: sda1
SCSI device sdb: 35540992 512-byte hdwr sectors (18197 MB)
 sdb: sdb1


