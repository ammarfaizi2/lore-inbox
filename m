Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318455AbSIBULD>; Mon, 2 Sep 2002 16:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318458AbSIBULD>; Mon, 2 Sep 2002 16:11:03 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:30624
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S318455AbSIBULC> convert rfc822-to-8bit; Mon, 2 Sep 2002 16:11:02 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: Poweroff error from 2.4.20-pre5-ac1 w/ Asus A7M266-D motherboard AND question
Date: Mon, 2 Sep 2002 16:18:15 -0400
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200209021618.15767.spstarr@sh0n.net>
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.100.232.94] using ID <shawn.starr@rogers.com> at Mon, 2 Sep 2002 16:15:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First the question:

Why does Linux detect my AMD chipset as ONLY the MP and not the MPX? I thought the A7M266-D had the MPX? 
The manual says it does

Secondly the error:

On poweroff: I see:

hdc: failed to unregister!

I have mapped hdc to sdc0 (via SCSI Emulation)

hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive

SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Vendor: YAMAHA    Model: CRW2100E          Rev: 1.0N
Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray

Just to also mention I have enabled the experimental AMD Power Management:

md76x_pm: Version 20020730
amd76x_pm: Initializing northbridge Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
amd76x_pm: Initializing southbridge Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
