Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135913AbREDIZY>; Fri, 4 May 2001 04:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135914AbREDIZO>; Fri, 4 May 2001 04:25:14 -0400
Received: from ns.viventus.no ([195.18.200.139]:54032 "EHLO viventus.no")
	by vger.kernel.org with ESMTP id <S135913AbREDIZI>;
	Fri, 4 May 2001 04:25:08 -0400
From: Rafael Martinez <rafael@viewpoint.no>
To: venkateshr@ami.com
Cc: linux-kernel@vger.kernel.org
Reply-To: rafael@viewpoint.no
Subject: Re: Solution - AMI  megaraid driver doesn't work with Linux 2.4.x kernels
In-Reply-To: <002d01c0d3e0$1f4d5270$7253e59b@megatrends.com>
Date: Fri, 04 May 2001 10:27:15 +0100 (CEST)
X-Mailer: XCmail 1.2 - with PGP support, PGP engine version 0.5 (Linux)
X-Mailerorigin: http://www.fsai.fh-trier.de/~schmitzj/Xclasses/XCmail/
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <auto-000000185962@viventus.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---Reply to mail from Venkatesh Ramamurthy about Solution - AMI  megaraid driver doesn't work with Linux 2.4.x kernels
> Can you provide the dmesg output of your system after loading the driver
> either successfully or unsucessfully.
> 

Successfully: (Raid 5 4x18GB)
------------------------------------------------------
megaraid: v1.14g (Release Date: Feb 5, 2001; 11:42)
megaraid: found 0x101e:0x1960:idx 0:bus 9:slot 0:func 0
scsi3 : Found a MegaRAID controller at 0xf884e000, IRQ: 17
scsi3 : Enabling 64 bit support
megaraid: [G158:3.11] detected 1 logical drives
scsi3 : AMI MegaRAID G158 254 commands 16 targs 2 chans 40 luns
scsi3: scanning channel 1 for devices.
  Vendor: ESG-SHV   Model: SCA HSBP M9       Rev: 0.10
  Type:   Processor                          ANSI SCSI revision: 02
scsi3: scanning channel 2 for devices.
scsi3: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5 52527R  Rev: G158
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sdb at scsi3, channel 2, id 0, lun 0
SCSI device sdb: 107575296 512-byte hdwr sectors (55079 MB)
 sdb: sdb1
-------------------------------------------------------

When it was unsucessfully, it stoppet in the last line with:
sdb: unknown partition table 
(With kernel 2.4.2-2smp from redhat (RH7.1) and "official" 2.4.2, 2.4.3)

The only different between the to instalations is the firmware version
C158 --> G158 of the ami card.

The kernel is a 2.4.2-2smp from redhat (RH7.1). I will test the system with an
"official" ;-) kernel today.

Rafael Martinez

---End reply



