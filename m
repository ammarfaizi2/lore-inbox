Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUBVXXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 18:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUBVXXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 18:23:16 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:12939 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261234AbUBVXXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 18:23:12 -0500
Message-ID: <403939D4.9020804@blue-labs.org>
Date: Sun, 22 Feb 2004 18:23:00 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: SONY SMO-F551, non-functional for a loong time :)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the last couple of years, this MO drive (I have several) has been 
unusable.  It used to lock up the machine if I had a disc inside it when 
I booted, but that was late in 2.5, and now with 2.6.3, it no longer 
hangs the machine, however, it's still not usable.

I'd love to get this bugger working, I used to use it a long long time 
ago in 2.4 kernels.  Any suggestions?

David
--

bootup stuff:

sym0: <875> rev 0x4 at pci 0000:01:0b.0 irq 209
sym0: Symbios NVRAM, ID 15, Fast-20, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18f
  Vendor: UMAX      Model: Astra 2400S       Rev: V1.1
  Type:   Scanner                            ANSI SCSI revision: 02
  Vendor: SONY      Model: SMO-F551          Rev: 1.14
  Type:   Optical Device                     ANSI SCSI revision: 02
sym0:4:0: tagged command queuing enabled, command queue depth 16.
libata version 1.00 loaded.
st: Version 20040122, fixed bufsize 32768, s/g segs 256
sym0:4: FAST-10 SCSI 5.0 MB/s ST (200.0 ns, offset 15)
sda: Unit Not Ready, sense:
Current : sense key Hardware Error
ASC=40 ASCQ=86
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08
Current sd: sense key Hardware Error
ASC=40 ASCQ=86
sda: Write Protect is off
sda: Mode Sense: 5b 03 10 08
SCSI device sda: drive cache: write back
SCSI error: host 0 id 4 lun 0 return code = 8000002
        Sense class 7, sense error 0, extended sense 4
sda: Unit Not Ready, sense:
Current : sense key Hardware Error
ASC=40 ASCQ=86
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08
Current sd: sense key Hardware Error
ASC=40 ASCQ=86
sda: Write Protect is off
sda: Mode Sense: 5b 03 10 08
SCSI device sda: drive cache: write back
sda: Unit Not Ready, sense:
Current : sense key Hardware Error
ASC=40 ASCQ=86
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08
Current sd: sense key Hardware Error
ASC=40 ASCQ=86
sda: Write Protect is off
sda: Mode Sense: 5b 03 10 08
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target4/lun0:<3>Buffer I/O error on device sda, 
logical block 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
 /dev/scsi/host0/bus0/target4/lun0:<3>Buffer I/O error on device sda, 
logical block 0
 unable to read partition table
Attached scsi removable disk sda at scsi0, channel 0, id 4, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 6
Attached scsi generic sg1 at scsi0, channel 0, id 4, lun 0,  type 7



# fdisk /dev/sda
Unable to read /dev/sda


# dmesg -c
SCSI error: host 0 id 4 lun 0 return code = 8000002
        Sense class 7, sense error 0, extended sense 4
sda: Unit Not Ready, sense:
Current : sense key Hardware Error
ASC=40 ASCQ=86
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08
Current sd: sense key Hardware Error
ASC=40 ASCQ=86
sda: Write Protect is off
sda: Mode Sense: 5b 03 10 08
SCSI device sda: drive cache: write back
sda: Unit Not Ready, sense:
Current : sense key Hardware Error
ASC=40 ASCQ=86
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08
Current sd: sense key Hardware Error
ASC=40 ASCQ=86
sda: Write Protect is off
sda: Mode Sense: 5b 03 10 08
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target4/lun0:<3>Buffer I/O error on device sda,
 logical block 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
Buffer I/O error on device sda, logical block 0
Buffer I/O error on device sda, logical block 1
Buffer I/O error on device sda, logical block 2
Buffer I/O error on device sda, logical block 3
Buffer I/O error on device sda, logical block 4
Buffer I/O error on device sda, logical block 5
Buffer I/O error on device sda, logical block 6
Buffer I/O error on device sda, logical block 7
Buffer I/O error on device sda, logical block 8
Buffer I/O error on device sda, logical block 9
Buffer I/O error on device sda, logical block 10
Buffer I/O error on device sda, logical block 11
Buffer I/O error on device sda, logical block 12
Buffer I/O error on device sda, logical block 13
Buffer I/O error on device sda, logical block 14
Buffer I/O error on device sda, logical block 15


