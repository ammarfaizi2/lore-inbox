Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbULUObA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbULUObA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 09:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbULUObA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 09:31:00 -0500
Received: from main.gmane.org ([80.91.229.2]:12705 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261762AbULUOao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 09:30:44 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ermanno Poggi <epoggi@libero.it>
Subject: aic7xxx boot error
Date: Tue, 21 Dec 2004 15:27:51 +0100
Message-ID: <cq9brv$pe3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host72-199.pool8248.interbusiness.it
User-Agent: KNode/0.8.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
 From kernel 2.6.0, I've a problem with the aic7xxx driver (2.6.0-testXX was
ok).
 Until 2.6.7 I can solve this issue deleting the original aic7xxx directory
in the kernel source and substitute this with the one downloaded from
http://people.freebsd.org/~gibbs/linux/ !
 From 2.6.7 I can't do this anymore, because I get some error compiling the
kernel!
 Can some one tell me if there is a solution, now I'm stuck with 2.6.7 and
can't upgrade my kernel!
 
 The only thing that I've noticed is the ACPI row before the detection of
the aic7xxx, in the 2.6.X (where X>7) it could be an ACPI problem??

Obviously this problem prevent me to use any scsi device, with the new
kernel
 
 Thanks in advance
 
 Bye bye
 
 ---------kernel 2.6.9 with original aic7xxx driver------------
 
 Zeus ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
 Zeus scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
 Zeus <Adaptec 2940 Ultra SCSI adapter>
 Zeus aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs
 Zeus
 Zeus (scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 8)
 Zeus scsi0:0:5:0: Attempting to queue an ABORT message
 Zeus CDB: 0x12 0x0 0x0 0x0 0x24 0x0
 Zeus scsi0: At time of recovery, card was not paused
 Zeus >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
 Zeus scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x7c
 Zeus Card was paused
 Zeus ACCUM = 0x0, SINDEX = 0xb8, DINDEX = 0xa8, ARG_2 = 0x0
 Zeus HCNT = 0x20 SCBPTR = 0x0
 Zeus SCSISIGI[0x44] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x40]
 Zeus SCSISEQ[0x12] SBLKCTL[0x0] SCSIRATE[0x8] SEQCTL[0x10]
 Zeus SEQ_FLAGS[0x20] SSTAT0[0x0] SSTAT1[0x2] SSTAT2[0x0]
 Zeus SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac] SXFRCTL0[0x80]
 Zeus DFCNTRL[0x38] DFSTATUS[0x0]
 Zeus STACK: 0x0 0x162 0x192 0x6e
 Zeus SCB count = 4
 Zeus Kernel NEXTQSCB = 2
 Zeus Card NEXTQSCB = 2
 Zeus QINFIFO entries:
 Zeus Waiting Queue entries:
 Zeus Disconnected Queue entries:
 Zeus QOUTFIFO entries:
 Zeus Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
 Zeus Sequencer SCB Info:
 Zeus 0 SCB_CONTROL[0x0] SCB_SCSIID[0x57] SCB_LUN[0x0] SCB_TAG[0x3]
 Zeus 1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 Zeus Pending list:
 Zeus 3 SCB_CONTROL[0x0] SCB_SCSIID[0x57] SCB_LUN[0x0]
 Zeus Kernel Free SCB list: 1 0
 Zeus Untagged Q(5): 3
 Zeus DevQ(0:5:0): 0 waiting
 Zeus
 Zeus <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
 Zeus scsi0:0:5:0: Device is active, asserting ATN
 Zeus (scsi0:A:5:0): Abort Message Sent
 Zeus Recovery code sleeping
 Zeus (scsi0:A:5:0): SCB 3 - Abort Completed.
 Zeus Recovery SCB completes
 Zeus Recovery code awake
 Zeus aic7xxx_abort returns 0x2002
 Zeus (scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 8)
 Zeus Vendor: PIONEER   Model: DVD-ROM DVD-303F  Rev: 2.00
 Zeus Type:   CD-ROM                             ANSI SCSI revision: 02
 Zeus sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
 Zeus Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
 Zeus Attached scsi generic sg0 at scsi0, channel 0, id 5, lun 0,  type 5


  ---------kernel 2.6.7 with Gibbs aic7xxx driver------------
 
 Zeus scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.3.9
 Zeus <Adaptec 2940 Ultra SCSI adapter>
 Zeus aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs
 Zeus
 Zeus Vendor: PIONEER   Model: DVD-ROM DVD-303F  Rev: 2.00
 Zeus Type:   CD-ROM                             ANSI SCSI revision: 02
 Zeus sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
 Zeus Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
 Zeus Attached scsi generic sg0 at scsi0, channel 0, id 5, lun 0,  type 5

