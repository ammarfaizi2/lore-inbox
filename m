Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbSJIP7T>; Wed, 9 Oct 2002 11:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261838AbSJIP7T>; Wed, 9 Oct 2002 11:59:19 -0400
Received: from linux.kappa.ro ([194.102.255.131]:16853 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S261837AbSJIP7R>;
	Wed, 9 Oct 2002 11:59:17 -0400
Date: Wed, 9 Oct 2002 19:04:58 +0300
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1[89] Warning - running *really* short on DMA buffers .. and crash
Message-ID: <20021009160458.GA23810@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have this machine running either 2.4.18 or 19 with the same bad behavior.
I get from time to time the message in the Subject and if I do something
that uses the disk somewhat more it just reboots without any warning.
(for example if I use fsck or I type sync a lot when untarring .. )

Anyway the hardware configuration is like this:

2 X PIII 667MHz
MB chipset VIA VT82C693A/694x SMP board
512MB
2 Intel Etherexpress 82557
and the scsi adapter:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 19160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: QUANTUM   Model: ATLAS10K2-TY184L  Rev: DA40
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
SCSI device sda: 35860910 512-byte hdwr sectors (18361 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >



It's really annoying to have the computer reboot without any warning or message to
track something ...


Teo
