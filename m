Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUACAtU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 19:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265806AbUACAtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 19:49:20 -0500
Received: from mx15.sac.fedex.com ([199.81.197.54]:48137 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S265800AbUACAtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 19:49:01 -0500
Date: Sat, 3 Jan 2004 08:35:12 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Jens Axboe <axboe@suse.de>
cc: Michael Hunold <hunold@convergence.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GetASF failed on DVD authentication
In-Reply-To: <20040102163024.GS5523@suse.de>
Message-ID: <Pine.LNX.4.58.0401030830360.407@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com>
 <20040102103949.GL5523@suse.de> <Pine.LNX.4.58.0401022219290.10338@silk.corp.fedex.com>
 <3FF5986C.8060806@convergence.de> <20040102161813.GA21852@suse.de>
 <20040102163024.GS5523@suse.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/03/2004
 08:48:39 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/03/2004
 08:48:53 AM,
	Serialize complete at 01/03/2004 08:48:53 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Jan 2004, Jens Axboe wrote:

> BTW Jeff, I'd still very much like to see the usb-storage log from when
> sr gets loaded. Even though it's fine to kill the CDC_DVD checks, it
> would still be a good idea to fix why the capabilities check fails. That
> is the real bug.

Below is the "debug" messages for usb-storage ...

The log showed "Illegal Request: invalid command operation code" when I
issued "tstdvd".


Thanks,
Jeff


*********  starting usb ...
Jan  3 08:11:07 boston kernel: PCI: Setting latency timer of device 00:1f.6 to 64
Jan  3 08:11:33 boston kernel: PCI: Setting latency timer of device 00:1d.0 to 64
Jan  3 08:11:34 boston kernel: usb.c: kmalloc IF f6d8a280, numif 1
Jan  3 08:11:34 boston kernel: usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
Jan  3 08:11:34 boston kernel: usb.c: USB device number 1 default language ID 0x0
Jan  3 08:11:34 boston kernel: hub.c: standalone hub
Jan  3 08:11:34 boston kernel: hub.c: ganged power switching
Jan  3 08:11:34 boston kernel: hub.c: global over-current protection
Jan  3 08:11:34 boston kernel: hub.c: Port indicators are not supported
Jan  3 08:11:34 boston kernel: hub.c: power on to power good time: 2ms
Jan  3 08:11:34 boston kernel: hub.c: hub controller current requirement: 0mA
Jan  3 08:11:34 boston kernel: hub.c: port removable status: RR
Jan  3 08:11:34 boston kernel: hub.c: local power source is good
Jan  3 08:11:34 boston kernel: hub.c: no over-current condition exists
Jan  3 08:11:34 boston kernel: hub.c: enabling power on all ports
Jan  3 08:11:34 boston kernel: usb.c: hub driver claimed interface f6d8a280
Jan  3 08:11:34 boston kernel: usb.c: kusbd: /sbin/hotplug add 1
Jan  3 08:11:34 boston kernel: usb.c: kusbd policy returned 0xfffffffe
Jan  3 08:11:34 boston kernel: PCI: Setting latency timer of device 00:1d.1 to 64
Jan  3 08:11:34 boston kernel: usb.c: kmalloc IF f6d8a3a0, numif 1
Jan  3 08:11:34 boston kernel: usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
Jan  3 08:11:34 boston kernel: usb.c: USB device number 1 default language ID 0x0
Jan  3 08:11:34 boston kernel: hub.c: standalone hub
Jan  3 08:11:34 boston kernel: hub.c: ganged power switching
Jan  3 08:11:34 boston kernel: hub.c: global over-current protection
Jan  3 08:11:34 boston kernel: hub.c: Port indicators are not supported
Jan  3 08:11:34 boston kernel: hub.c: power on to power good time: 2ms
Jan  3 08:11:34 boston kernel: hub.c: hub controller current requirement: 0mA
Jan  3 08:11:34 boston kernel: hub.c: port removable status: RR
Jan  3 08:11:34 boston kernel: hub.c: local power source is good
Jan  3 08:11:34 boston kernel: hub.c: no over-current condition exists
Jan  3 08:11:34 boston kernel: hub.c: enabling power on all ports
Jan  3 08:11:34 boston kernel: usb.c: hub driver claimed interface f6d8a3a0
Jan  3 08:11:34 boston kernel: usb.c: kusbd: /sbin/hotplug add 1
Jan  3 08:11:34 boston kernel: usb.c: kusbd policy returned 0xfffffffe
Jan  3 08:11:34 boston kernel: PCI: Setting latency timer of device 00:1d.2 to 64
Jan  3 08:11:34 boston kernel: hub.c: port 1, portstatus 100, change 0, 12 Mb/s
Jan  3 08:11:34 boston kernel: hub.c: port 2, portstatus 101, change 1, 12 Mb/s
Jan  3 08:11:34 boston kernel: hub.c: port 2 connection change
Jan  3 08:11:34 boston kernel: hub.c: port 2, portstatus 101, change 1, 12 Mb/s
Jan  3 08:11:34 boston kernel: usb.c: kmalloc IF f6d8a4c0, numif 1
Jan  3 08:11:34 boston kernel: usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
Jan  3 08:11:34 boston kernel: usb.c: USB device number 1 default language ID 0x0
Jan  3 08:11:34 boston kernel: hub.c: standalone hub
Jan  3 08:11:34 boston kernel: hub.c: ganged power switching
Jan  3 08:11:34 boston kernel: hub.c: global over-current protection
Jan  3 08:11:34 boston kernel: hub.c: Port indicators are not supported
Jan  3 08:11:34 boston kernel: hub.c: power on to power good time: 2ms
Jan  3 08:11:34 boston kernel: hub.c: hub controller current requirement: 0mA
Jan  3 08:11:34 boston kernel: hub.c: port removable status: RR
Jan  3 08:11:34 boston kernel: hub.c: local power source is good
Jan  3 08:11:34 boston kernel: hub.c: no over-current condition exists
Jan  3 08:11:34 boston kernel: hub.c: enabling power on all ports
Jan  3 08:11:34 boston kernel: usb.c: hub driver claimed interface f6d8a4c0
Jan  3 08:11:34 boston kernel: usb.c: kusbd: /sbin/hotplug add 1
Jan  3 08:11:34 boston kernel: usb.c: kusbd policy returned 0xfffffffe
Jan  3 08:11:34 boston kernel: hub.c: port 2, portstatus 101, change 0, 12 Mb/s
Jan  3 08:11:34 boston last message repeated 3 times
Jan  3 08:11:34 boston kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Jan  3 08:11:34 boston kernel: usb.c: kmalloc IF f6d8a560, numif 1
Jan  3 08:11:34 boston kernel: usb.c: new device strings: Mfr=73, Product=87, SerialNumber=107
Jan  3 08:11:34 boston kernel: usb.c: USB device number 2 default language ID 0x409
Jan  3 08:11:34 boston kernel: usb-storage: act_altsettting is 0
Jan  3 08:11:34 boston kernel: usb-storage: id_index calculated to be: 86
Jan  3 08:11:34 boston kernel: usb-storage: Array length appears to be: 88
Jan  3 08:11:34 boston kernel: usb-storage: USB Mass Storage device detected
Jan  3 08:11:34 boston kernel: usb-storage: Endpoints: In: 0xf6dfd574 Out: 0xf6dfd560 Int: 0xf6dfd588 (Period 16)
Jan  3 08:11:34 boston kernel: usb-storage: New GUID 093b002011100e00004b6be4
Jan  3 08:11:34 boston kernel: usb-storage: GetMaxLUN command result is 1, data is 0
Jan  3 08:11:34 boston kernel: usb-storage: Transport: Bulk
Jan  3 08:11:34 boston kernel: usb-storage: Protocol: Transparent SCSI
Jan  3 08:11:34 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:11:34 boston kernel: usb-storage: queuecommand() called
Jan  3 08:11:34 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:11:34 boston kernel: usb-storage: Command INQUIRY (6 bytes)
Jan  3 08:11:34 boston kernel: usb-storage: 12 00 00 00 ff 00 00 00 5a 07 00 00
Jan  3 08:11:34 boston kernel: usb-storage: Bulk command S 0x43425355 T 0x1 Trg 0 LUN 0 L 255 F 128 CL 6
Jan  3 08:11:34 boston kernel: usb-storage: Bulk command transfer result=0
Jan  3 08:11:34 boston kernel: usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
Jan  3 08:11:34 boston kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 96/255
Jan  3 08:11:34 boston kernel: usb-storage: Bulk data transfer result 0x1
Jan  3 08:11:34 boston kernel: usb-storage: Attempting to get CSW...
Jan  3 08:11:34 boston kernel: usb-storage: clearing endpoint halt for pipe 0xc0010280
Jan  3 08:11:34 boston kernel: usb-storage: usb_stor_clear_halt: result=0
Jan  3 08:11:34 boston kernel: usb-storage: Attempting to get CSW (2nd try)...
Jan  3 08:11:34 boston kernel: usb-storage: Bulk status result = 0
Jan  3 08:11:34 boston kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1 R 159 Stat 0x0
Jan  3 08:11:34 boston kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
Jan  3 08:11:34 boston kernel: usb-storage: scsi cmd done, result=0x0
Jan  3 08:11:34 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:11:34 boston kernel: usb-storage: queuecommand() called
Jan  3 08:11:34 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:11:34 boston kernel: usb-storage: Bad LUN (0/1)
Jan  3 08:11:34 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:11:34 boston kernel: usb-storage: queuecommand() called
Jan  3 08:11:34 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:11:34 boston kernel: usb-storage: Bad target number (1/0)
Jan  3 08:11:34 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:11:34 boston kernel: usb-storage: queuecommand() called
Jan  3 08:11:34 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:11:34 boston kernel: usb-storage: Bad target number (2/0)
Jan  3 08:11:34 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:11:34 boston kernel: usb-storage: queuecommand() called
Jan  3 08:11:34 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:11:34 boston kernel: usb-storage: Bad target number (3/0)
Jan  3 08:11:34 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:11:34 boston kernel: usb-storage: queuecommand() called
Jan  3 08:11:34 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:11:34 boston kernel: usb-storage: Bad target number (4/0)
Jan  3 08:11:34 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:11:34 boston kernel: usb-storage: queuecommand() called
Jan  3 08:11:34 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:11:34 boston kernel: usb-storage: Bad target number (5/0)
Jan  3 08:11:34 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:11:34 boston kernel: usb-storage: queuecommand() called
Jan  3 08:11:34 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:11:34 boston kernel: usb-storage: Bad target number (6/0)
Jan  3 08:11:34 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:11:34 boston kernel: usb-storage: queuecommand() called
Jan  3 08:11:34 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:11:34 boston kernel: usb-storage: Bad target number (7/0)
Jan  3 08:11:34 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:11:34 boston kernel: WARNING: USB Mass Storage data integrity not assured
Jan  3 08:11:34 boston kernel: USB Mass Storage device found at 2
Jan  3 08:11:34 boston kernel: usb.c: usb-storage driver claimed interface f6d8a560
Jan  3 08:11:34 boston kernel: usb.c: kusbd: /sbin/hotplug add 2
Jan  3 08:11:34 boston kernel: usb.c: kusbd policy returned 0xfffffffe
Jan  3 08:11:34 boston kernel: hub.c: port 1, portstatus 100, change 0, 12 Mb/s
Jan  3 08:11:34 boston kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s


*********  issuing "tstdvd" ...
Jan  3 08:17:48 boston kernel: usb-storage: queuecommand() called
Jan  3 08:17:48 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:17:48 boston kernel: usb-storage: Command MODE_SENSE (6 bytes)
Jan  3 08:17:48 boston kernel: usb-storage: 1a 00 2a 00 80 00 5d f9 41 54 62 f9
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command S 0x43425355 T 0x2 Trg 0 LUN 0 L 128 F 128 CL 6
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command transfer result=0
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): xfer 128 bytes
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 0/128
Jan  3 08:17:48 boston kernel: usb-storage: Bulk data transfer result 0x1
Jan  3 08:17:48 boston kernel: usb-storage: Attempting to get CSW...
Jan  3 08:17:48 boston kernel: usb-storage: clearing endpoint halt for pipe 0xc0010280
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_clear_halt: result=0
Jan  3 08:17:48 boston kernel: usb-storage: Attempting to get CSW (2nd try)...
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status result = 0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status Sig 0x53425355 T 0x2 R 128 Stat 0x1
Jan  3 08:17:48 boston kernel: usb-storage: -- transport indicates command failure
Jan  3 08:17:48 boston kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command S 0x43425355 T 0x3 Trg 0 LUN 0 L 18 F 128 CL 6
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command transfer result=0
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan  3 08:17:48 boston kernel: usb-storage: Bulk data transfer result 0x0
Jan  3 08:17:48 boston kernel: usb-storage: Attempting to get CSW...
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status result = 0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status Sig 0x53425355 T 0x3 R 0 Stat 0x0
Jan  3 08:17:48 boston kernel: usb-storage: -- Result from auto-sense is 0
Jan  3 08:17:48 boston kernel: usb-storage: -- code: 0x70, key: 0x5, ASC: 0x20, ASCQ: 0x0
Jan  3 08:17:48 boston kernel: usb-storage: Illegal Request: invalid command operation code
Jan  3 08:17:48 boston kernel: usb-storage: scsi cmd done, result=0x2
Jan  3 08:17:48 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:17:48 boston kernel: usb-storage: queuecommand() called
Jan  3 08:17:48 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:17:48 boston kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jan  3 08:17:48 boston kernel: usb-storage: 00 00 00 00 00 00 00 00 d3 87 10 c0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command S 0x43425355 T 0x4 Trg 0 LUN 0 L 0 F 0 CL 6
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command transfer result=0
Jan  3 08:17:48 boston kernel: usb-storage: Attempting to get CSW...
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status result = 0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status Sig 0x53425355 T 0x4 R 0 Stat 0x0
Jan  3 08:17:48 boston kernel: usb-storage: scsi cmd done, result=0x0
Jan  3 08:17:48 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:17:48 boston kernel: usb-storage: queuecommand() called
Jan  3 08:17:48 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:17:48 boston kernel: usb-storage: Command READ_TOC (10 bytes)
Jan  3 08:17:48 boston kernel: usb-storage: 43 00 00 00 00 00 00 00 0c 40 00 00
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command S 0x43425355 T 0x5 Trg 0 LUN 0 L 12 F 128 CL 10
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command transfer result=0
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan  3 08:17:48 boston kernel: usb-storage: Bulk data transfer result 0x0
Jan  3 08:17:48 boston kernel: usb-storage: Attempting to get CSW...
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status result = 0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status Sig 0x53425355 T 0x5 R 0 Stat 0x0
Jan  3 08:17:48 boston kernel: usb-storage: scsi cmd done, result=0x0
Jan  3 08:17:48 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:17:48 boston kernel: usb-storage: queuecommand() called
Jan  3 08:17:48 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:17:48 boston kernel: usb-storage: Command READ_TOC (10 bytes)
Jan  3 08:17:48 boston kernel: usb-storage: 43 00 00 00 00 00 00 00 0c 00 8e f6
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command S 0x43425355 T 0x6 Trg 0 LUN 0 L 12 F 128 CL 10
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command transfer result=0
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan  3 08:17:48 boston kernel: usb-storage: Bulk data transfer result 0x0
Jan  3 08:17:48 boston kernel: usb-storage: Attempting to get CSW...
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status result = 0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status Sig 0x53425355 T 0x6 R 0 Stat 0x0
Jan  3 08:17:48 boston kernel: usb-storage: scsi cmd done, result=0x0
Jan  3 08:17:48 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:17:48 boston kernel: usb-storage: queuecommand() called
Jan  3 08:17:48 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:17:48 boston kernel: usb-storage: Command READ_TOC (10 bytes)
Jan  3 08:17:48 boston kernel: usb-storage: 43 00 00 00 00 00 01 00 0c 00 8e f6
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command S 0x43425355 T 0x7 Trg 0 LUN 0 L 12 F 128 CL 10
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command transfer result=0
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan  3 08:17:48 boston kernel: usb-storage: Bulk data transfer result 0x0
Jan  3 08:17:48 boston kernel: usb-storage: Attempting to get CSW...
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status result = 0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status Sig 0x53425355 T 0x7 R 0 Stat 0x0
Jan  3 08:17:48 boston kernel: usb-storage: scsi cmd done, result=0x0
Jan  3 08:17:48 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:17:48 boston kernel: usb-storage: queuecommand() called
Jan  3 08:17:48 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:17:48 boston kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jan  3 08:17:48 boston kernel: usb-storage: 25 00 00 00 00 00 00 00 00 00 bd f6
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command S 0x43425355 T 0x8 Trg 0 LUN 0 L 8 F 128 CL 10
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command transfer result=0
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 8/8
Jan  3 08:17:48 boston kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jan  3 08:17:48 boston kernel: usb-storage: Bulk data transfer result 0x0
Jan  3 08:17:48 boston kernel: usb-storage: Attempting to get CSW...
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status result = 0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status Sig 0x53425355 T 0x8 R 0 Stat 0x0
Jan  3 08:17:48 boston kernel: usb-storage: scsi cmd done, result=0x0
Jan  3 08:17:48 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:17:48 boston kernel: usb-storage: queuecommand() called
Jan  3 08:17:48 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:17:48 boston kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jan  3 08:17:48 boston kernel: usb-storage: 00 00 00 00 00 00 2c c0 00 d0 2c c0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command S 0x43425355 T 0x9 Trg 0 LUN 0 L 0 F 0 CL 6
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command transfer result=0
Jan  3 08:17:48 boston kernel: usb-storage: Attempting to get CSW...
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status result = 0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status Sig 0x53425355 T 0x9 R 0 Stat 0x0
Jan  3 08:17:48 boston kernel: usb-storage: scsi cmd done, result=0x0
Jan  3 08:17:48 boston kernel: usb-storage: *** thread sleeping.
Jan  3 08:17:48 boston kernel: usb-storage: queuecommand() called
Jan  3 08:17:48 boston kernel: usb-storage: *** thread awakened.
Jan  3 08:17:48 boston kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
Jan  3 08:17:48 boston kernel: usb-storage: 1e 00 00 00 00 00 8e f6 00 00 00 00
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command S 0x43425355 T 0xa Trg 0 LUN 0 L 0 F 0 CL 6
Jan  3 08:17:48 boston kernel: usb-storage: Bulk command transfer result=0
Jan  3 08:17:48 boston kernel: usb-storage: Attempting to get CSW...
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status result = 0
Jan  3 08:17:48 boston kernel: usb-storage: Bulk status Sig 0x53425355 T 0xa R 0 Stat 0x0
Jan  3 08:17:48 boston kernel: usb-storage: scsi cmd done, result=0x0
Jan  3 08:17:48 boston kernel: usb-storage: *** thread sleeping.

