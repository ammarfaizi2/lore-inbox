Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVBWQPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVBWQPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 11:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVBWQPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 11:15:11 -0500
Received: from webd.globtel.pl ([62.233.149.230]:16031 "EHLO globtel.pl")
	by vger.kernel.org with ESMTP id S261452AbVBWQO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 11:14:58 -0500
Date: Sun, 20 Feb 2005 18:26:08 +0100
From: Sebastian Fabrycki <cellsan@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: USB Storage problem (usb hangs)
Message-ID: <20050220172608.GA2944@globtel.pl>
Reply-To: Sebastian Fabrycki <cellsan@interia.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

Hi.

The device is: USB2.0 to IDE 3.5" hard disk enclosure.
Producer: Seven.

Part of /var/log/messages with USB debug enabled in kernel is
attached to this email.

Kernel: 2.6.9, 2.6.10 (i cant remember from which one is attached log).
Distribution: Gentoo.

I'm not subscribed to the list, pleas CC me.

-- 
Regards
Sebastian Fabrycki
cellsan@interia.pl

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="usb-msg.txt"

Jan 10 23:34:30 globtel usb-storage: USB Mass Storage device detected
Jan 10 23:34:30 globtel usb-storage: -- associate_dev
Jan 10 23:34:30 globtel usb-storage: Vendor: 0x05e3, Product: 0x0702, Revision: 0x0002
Jan 10 23:34:30 globtel usb-storage: Interface Subclass: 0x06, Protocol: 0x50
Jan 10 23:34:30 globtel usb-storage: Vendor: Genesys Logic,  Product: USB TO IDE
Jan 10 23:34:30 globtel usb-storage: Transport: Bulk
Jan 10 23:34:30 globtel usb-storage: Protocol: Transparent SCSI
Jan 10 23:34:30 globtel usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
Jan 10 23:34:30 globtel usb-storage: GetMaxLUN command result is 1, data is 0
Jan 10 23:34:30 globtel usb-storage: *** thread sleeping.
Jan 10 23:34:30 globtel scsi0 : SCSI emulation for USB Mass Storage devices
Jan 10 23:34:30 globtel usb-storage: queuecommand called
Jan 10 23:34:30 globtel usb-storage: *** thread awakened.
Jan 10 23:34:30 globtel usb-storage: Faking INQUIRY command
Jan 10 23:34:30 globtel usb-storage: scsi cmd done, result=0x0
Jan 10 23:34:30 globtel usb-storage: *** thread sleeping.
Jan 10 23:34:30 globtel Vendor: Genesys   Model: USB to IDE Disk   Rev: 0002
Jan 10 23:34:30 globtel Type:   Direct-Access                      ANSI SCSI revision: 02
Jan 10 23:34:30 globtel usb-storage: queuecommand called
Jan 10 23:34:30 globtel usb-storage: *** thread awakened.
Jan 10 23:34:30 globtel usb-storage: Command TEST_UNIT_READY (6 bytes)
Jan 10 23:34:30 globtel usb-storage:  00 00 00 00 00 00
Jan 10 23:34:30 globtel usb-storage: Bulk Command S 0x43425355 T 0x2 L 0 F 0 Trg 0 LUN 0 CL 6
Jan 10 23:34:30 globtel usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jan 10 23:34:30 globtel usb-storage: Status code 0; transferred 31/31
Jan 10 23:34:30 globtel usb-storage: -- transfer complete
Jan 10 23:34:30 globtel usb-storage: Bulk command transfer result=0
Jan 10 23:34:30 globtel usb-storage: Attempting to get CSW...
Jan 10 23:34:30 globtel usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jan 10 23:34:40 globtel scsi.agent[7459]: Attribute /sys/devices/pci0000:00/0000:00:1d.7/usb1/1-4/1-4:1.0/host0/0:0:0:0/type does not exist
Jan 10 23:35:00 globtel usb-storage: command_abort called
Jan 10 23:35:00 globtel usb-storage: usb_stor_stop_transport called
Jan 10 23:35:00 globtel usb-storage: -- cancelling URB
Jan 10 23:35:00 globtel usb-storage: Status code -104; transferred 0/13
Jan 10 23:35:00 globtel usb-storage: -- transfer cancelled
Jan 10 23:35:00 globtel usb-storage: Bulk status result = 4
Jan 10 23:35:00 globtel usb-storage: -- command was aborted
Jan 10 23:35:00 globtel usb-storage: usb_stor_Bulk_reset called
Jan 10 23:35:00 globtel usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jan 10 23:35:20 globtel usb-storage: Timeout -- cancelling URB
Jan 10 23:35:20 globtel usb-storage: Soft reset failed: -104
Jan 10 23:35:20 globtel usb-storage: scsi command aborted
Jan 10 23:35:20 globtel usb-storage: *** thread sleeping.
Jan 10 23:35:20 globtel usb-storage: queuecommand called
Jan 10 23:35:20 globtel usb-storage: *** thread awakened.
Jan 10 23:35:20 globtel usb-storage: Command TEST_UNIT_READY (6 bytes)
Jan 10 23:35:20 globtel usb-storage:  00 00 00 00 00 00
Jan 10 23:35:20 globtel usb-storage: Bulk Command S 0x43425355 T 0x2 L 0 F 0 Trg 0 LUN 0 CL 6
Jan 10 23:35:20 globtel usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jan 10 23:35:20 globtel usb-storage: Status code 0; transferred 31/31
Jan 10 23:35:20 globtel usb-storage: -- transfer complete
Jan 10 23:35:20 globtel usb-storage: Bulk command transfer result=0
Jan 10 23:35:20 globtel usb-storage: Attempting to get CSW...
Jan 10 23:35:20 globtel usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jan 10 23:35:30 globtel usb-storage: command_abort called
Jan 10 23:35:30 globtel usb-storage: usb_stor_stop_transport called
Jan 10 23:35:30 globtel usb-storage: -- cancelling URB
Jan 10 23:35:30 globtel usb-storage: Status code -104; transferred 0/13
Jan 10 23:35:30 globtel usb-storage: -- transfer cancelled
Jan 10 23:35:30 globtel usb-storage: Bulk status result = 4
Jan 10 23:35:30 globtel usb-storage: -- command was aborted
Jan 10 23:35:30 globtel usb-storage: usb_stor_Bulk_reset called
Jan 10 23:35:30 globtel usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jan 10 23:35:50 globtel usb-storage: Timeout -- cancelling URB
Jan 10 23:35:50 globtel usb-storage: Soft reset failed: -104
Jan 10 23:35:50 globtel usb-storage: scsi command aborted
Jan 10 23:35:50 globtel usb-storage: *** thread sleeping.
Jan 10 23:35:50 globtel usb-storage: device_reset called
Jan 10 23:35:50 globtel usb-storage: usb_stor_Bulk_reset called
Jan 10 23:35:50 globtel usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jan 10 23:36:10 globtel usb-storage: Timeout -- cancelling URB
Jan 10 23:36:10 globtel usb-storage: Soft reset failed: -104
Jan 10 23:36:10 globtel usb-storage: bus_reset called
...
...

--4Ckj6UjgE2iN1+kY--
