Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288512AbSAHWc5>; Tue, 8 Jan 2002 17:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288513AbSAHWcp>; Tue, 8 Jan 2002 17:32:45 -0500
Received: from mta05bw.bigpond.com ([139.134.6.95]:21232 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S288512AbSAHWbL>; Tue, 8 Jan 2002 17:31:11 -0500
Message-Id: <5.1.0.14.0.20020109093045.00ba7170@mail.bigpond.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 09 Jan 2002 09:31:03 +1100
To: linux-kernel@vger.kernel.org
From: Dylan Egan <crack_me@bigpond.com.au>
Subject: woops forgot about it..... usbide not working
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok..... sorry haven't been at my computer.

Uuummm.... i haven't yet got my ScanLogic product to work but it did 
improve with

UNUSUAL_DEV( 0x04ce, 0x0002, 0x0200, 0x0260,
"ScanLogic",
"H45/ScanLogic USB-IDE",
US_SC_SCSI, US_PR_BULK, NULL, US_FL_FIX_INQUIRY)

with this little patch it didnt lock up on me

but it gave some errors:

Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
usb-storage: act_altsettting is 0
usb-storage: id_index calculated to be: 52
usb-storage: Array length appears to be: 54
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xcff64154 Out: 0xcff64140 Int: 0x00000000 
(Period 0)
usb-storage: New GUID 04ce00020000000000000000
usb-storage: GetMaxLUN command result is 1, data is 0
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: *** thread sleeping.
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 00 00 00 ff 00 00 00 75 04 1a c0
usb-storage: Bulk command S 0x43425355 T 0x1 Trg 0 LUN 0 L 255 F 128 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 255/255
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x600350 R 159 Stat 0x0
usb-storage: Bulk logical error
usb-storage: Bulk reset requested

i was just wondering if someone could list all the known patches... or even 
attach them in a patch file then i could give them a go and see what happens

Thanks,

Dylan

