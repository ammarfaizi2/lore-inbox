Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTBTNsQ>; Thu, 20 Feb 2003 08:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTBTNsQ>; Thu, 20 Feb 2003 08:48:16 -0500
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:47549 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S265414AbTBTNsP>;
	Thu, 20 Feb 2003 08:48:15 -0500
Subject: 2.4.18-19.8.0 SCSI Tape Error
From: Adam Voigt <adam@cryptocomm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Feb 2003 08:58:31 -0500
Message-Id: <1045749511.1904.8.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 20 Feb 2003 13:58:20.0310 (UTC) FILETIME=[2024F360:01C2D8E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While booting my system, I saw this after upgrading my kernel
(both previous and current are Redhat kernels):

kernel: SCSI subsystem driver Revision: 1.00
kernel: kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter,
errno = 2
kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
kernel:         <Adaptec 2940 Ultra SCSI adapter>
kernel:         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
kernel:
kernel: blk: queue c2a21214, I/O limit 4095Mb (mask 0xffffffff)
kernel: (scsi0:A:2:0): refuses synchronous negotiation. Using
asynchronous transfers
kernel: (scsi0:A:2:0): parity error detected in Message-in phase.
SEQADDR(0x165) SCSIRATE(0x0)
kernel: scsi0:A:2: Message reject for 0 -- ignored
kernel: (scsi0:A:2:0): Unexpected busfree in Data-in phase
kernel: SEQADDR == 0x7f
kernel:   Vendor: ST90      Model: 00?'    ?\212 ? ?\214?  Rev:
kernel:   Type:   Sequential-Access                  ANSI SCSI revision:
07
kernel: blk: queue c2a21814, I/O limit 4095Mb (mask 0xffffffff)

The tape drive is a Sony SDT-S9000 (DAT3). This is the
first time I have seen this.

-- 
Adam Voigt (adam@cryptocomm.com)
The Cryptocomm Group
My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc

