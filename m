Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273836AbRI0TnK>; Thu, 27 Sep 2001 15:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273832AbRI0TnB>; Thu, 27 Sep 2001 15:43:01 -0400
Received: from mail2.megatrends.com ([155.229.80.11]:61451 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S273855AbRI0Tmy>; Thu, 27 Sep 2001 15:42:54 -0400
Message-ID: <1355693A51C0D211B55A00105ACCFE6402D2601A@ATL_MS1>
From: "Atul Mukker." <Atulm@ami.com>
To: "'Byron Albert'" <balbert@internet.com>, linux-kernel@vger.kernel.org
Subject: RE: megaraid driver only seeing 2 of 3 logical dirve.
Date: Thu, 27 Sep 2001 15:37:24 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver you are using seems to be not what we had released ( as I could
make out from the dmesg ) . Which distribution/kernel are you using. I
recommend you to get 1.17c, which is the latest driver. I will mail it
separately to you since sending attachments on this list is probably not a
good idea

Atul Mukker
Software Engineer II

LSI Logic Corporation
RAID Adapters Storage Division
6145-F Northbelt Parkway Norcross GA-30071
770-326-9187, 770-246-8765(Fax)
E-mail: atulm@lsil.com
HTTP: www.lsilogic.com


> -----Original Message-----
> From:	Byron Albert [SMTP:balbert@internet.com]
> Sent:	Thursday, September 27, 2001 1:57 PM
> To:	linux-kernel@vger.kernel.org
> Subject:	megaraid driver only seeing 2 of 3 logical dirve.
> 
> I just added an ami megaraid card to a machine. I configured the 6  9gb
> drives to look like 3 18gb drives and then booted. Linux only saw 2 of
> the 3 drive.  I think got the latest kernel and compiled and rebooted
> and the same below is the relevant dmesg info.  It says it detected 3
> logical drives but the driver only uses two of them.
> 
> I really need this other drive so any help would be appreciated.
> 
> Byron
> 
> p.s. please cc me as I am in the proccess of joining the list
> 
> 
> SCSI subsystem driver Revision: 1.00
> megaraid: v1.17a (Release Date: Fri Jul 13 18:44:01 EDT 2001)
> megaraid: found 0x8086:0x1960:idx 0:bus 0:slot 5:func 1
> scsi0 : Found a MegaRAID controller at 0xf8808000, IRQ: 10
> megaraid: [C :B ] detected 3 logical drives
> megaraid: channel[1] is raid.
> megaraid: channel[2] is raid.
> megaraid: channel[3] is raid.
> megaraid: no BIOS enabled.
> scsi0 : AMI MegaRAID C  254 commands 16 targs 3 chans 8 luns
> scsi0: scanning channel 1 for devices.
> scsi0: scanning channel 2 for devices.
> scsi0: scanning channel 3 for devices.
> scsi0: scanning virtual channel for logical drives.
>   Vendor: MegaRAID  Model: LD0 RAID0 17354R  Rev:   C
>   Type:   Direct-Access                      ANSI SCSI revision: 02
>   Vendor: MegaRAID  Model: LD1 RAID0 17354R  Rev:   C
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Attached scsi disk sda at scsi0, channel 3, id 0, lun 0
> Attached scsi disk sdb at scsi0, channel 3, id 0, lun 1
> SCSI device sda: 35540992 512-byte hdwr sectors (18197 MB)
>  sda: sda1
> SCSI device sdb: 35540992 512-byte hdwr sectors (18197 MB)
>  sdb: sdb1
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
