Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSLMRVt>; Fri, 13 Dec 2002 12:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSLMRVs>; Fri, 13 Dec 2002 12:21:48 -0500
Received: from u156n240.eastlink.ca ([24.224.156.240]:35234 "EHLO
	ns1.danicar.net") by vger.kernel.org with ESMTP id <S261346AbSLMRVr>;
	Fri, 13 Dec 2002 12:21:47 -0500
Message-ID: <1578.172.24.100.59.1039800552.squirrel@www.danicar.net>
Date: Fri, 13 Dec 2002 13:29:12 -0400 (AST)
Subject: kernel question
From: "Joe Gofton" <jgofton@danicar.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Reply-To: jgofton@danicar.net
X-Mailer: SquirrelMail (version 1.2.10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this after I install a new kernel.  2.4.19 or 2.4.20.  This doesn't
happen with 2.4.18.  Is this bad?


Dec  1 11:10:32 ns1 kernel: SCSI subsystem driver Revision: 1.00
Dec  1 11:10:32 ns1 kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.2.8
Dec  1 11:10:32 ns1 kernel:         <Adaptec 2940 Ultra2 SCSI adapter>
Dec  1 11:10:32 ns1 kernel:         aic7890/91: Ultra2 Wide Channel A,
SCSI Id=7, 32/253 SCBs
Dec  1 11:10:32 ns1 kernel:
Dec  1 11:10:32 ns1 kernel:   Vendor: QUANTUM   Model: ATLAS_V_18_WLS   
Rev: 0230
Dec  1 11:10:32 ns1 kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 03
Dec  1 11:10:32 ns1 kernel:   Vendor: QUANTUM   Model: ATLAS_V_18_WLS   
Rev: 0230
Dec  1 11:10:32 ns1 kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 03
Dec  1 11:10:32 ns1 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Dec  1 11:10:32 ns1 kernel: scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
Dec  1 11:10:32 ns1 kernel: scsi: <fdomain> Detection failed (no card)
Dec  1 11:10:32 ns1 kernel: PCI: Enabling device 00:09.0 (0006 -> 0007)
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: agpgart: Detected Via Apollo Pro chipset
Dec  1 11:10:32 ns1 kernel: agpgart: AGP aperture is 64M @ 0xd0000000
Dec  1 11:10:32 ns1 kernel: Highpoint HPT370 Softwareraid driver for linux
version 0.01
Dec  1 11:10:32 ns1 kernel: No raid array found
Dec  1 11:10:32 ns1 kernel: SCSI subsystem driver Revision: 1.00
Dec  1 11:10:32 ns1 kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.2.8
Dec  1 11:10:32 ns1 kernel:         <Adaptec 2940 Ultra2 SCSI adapter>
Dec  1 11:10:32 ns1 kernel:         aic7890/91: Ultra2 Wide Channel A,
SCSI Id=7, 32/253 SCBs
Dec  1 11:10:32 ns1 kernel:
Dec  1 11:10:32 ns1 kernel:   Vendor: QUANTUM   Model: ATLAS_V_18_WLS   
Rev: 0230
Dec  1 11:10:32 ns1 kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 03
Dec  1 11:10:32 ns1 kernel:   Vendor: QUANTUM   Model: ATLAS_V_18_WLS   
Rev: 0230
Dec  1 11:10:32 ns1 kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 03
Dec  1 11:10:32 ns1 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Dec  1 11:10:32 ns1 kernel: scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
Dec  1 11:10:32 ns1 kernel: scsi: <fdomain> Detection failed (no card)
Dec  1 11:10:32 ns1 kernel: PCI: Enabling device 00:09.0 (0006 -> 0007)
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: Attached scsi disk sda at scsi0, channel 0, id
0, lun 0
Dec  1 11:10:32 ns1 kernel: Attached scsi disk sdb at scsi0, channel 0, id
1, lun 0
Dec  1 11:10:32 ns1 kernel: (scsi0:A:0): 80.000MB/s transfers (40.000MHz,
offset 63, 16bit)
Dec  1 11:10:32 ns1 kernel: SCSI device sda: 35861388 512-byte hdwr
sectors (18361 MB)
Dec  1 11:10:32 ns1 kernel: Partition check:
Dec  1 11:10:32 ns1 kernel:  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Dec  1 11:10:32 ns1 kernel: (scsi0:A:1): 80.000MB/s transfers (40.000MHz,
offset 63, 16bit)
Dec  1 11:10:32 ns1 kernel: SCSI device sdb: 35861388 512-byte hdwr
sectors (18361 MB)
Dec  1 11:10:32 ns1 kernel:  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >


