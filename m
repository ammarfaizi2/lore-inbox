Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbUKPSlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUKPSlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 13:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUKPSlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 13:41:42 -0500
Received: from mail.netshadow.at ([217.116.182.106]:49127 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S262085AbUKPSlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 13:41:04 -0500
Subject: Re: 2.6.10 usb-storage too verbose
From: Andreas Unterkircher <unki@netshadow.at>
Reply-To: unki@netshadow.at
To: linux-kernel list <linux-kernel@vger.kernel.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>
In-Reply-To: <4199CAF8.1000501@eyal.emu.id.au>
References: <4199CAF8.1000501@eyal.emu.id.au>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 19:40:48 +0100
Message-Id: <1100630448.1817.5.camel@kuecken.unki.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

don't know your .config & kernel version - but possible u should disable
CONFIG_USB_STORAGE_DEBUG there ;)

andi

Am Dienstag, den 16.11.2004, 20:40 +1100 schrieb Eyal Lebedinsky:
> When I mount/read/unmount a USB disk I end up with tons of messages like
> below. Should it be this verbose on a stable kernel (I would understand
> debugging)?
> 
> usb-storage: scsi cmd done, result=0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_10 (10 bytes)
> usb-storage:  28 00 00 0b 0d a8 00 00 80 00
> usb-storage: Bulk Command S 0x43425355 T 0x32c L 65536 F 128 Trg 0 LUN 0 CL 12
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_bulk_transfer_sglist: xfer 65536 bytes, 1 entries
> usb-storage: Status code 0; transferred 65536/65536
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result = 0
> usb-storage: Bulk Status S 0x53425355 T 0x32c R 0 Stat 0x0
> usb-storage: scsi cmd done, result=0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_10 (10 bytes)
> usb-storage:  28 00 00 0b 0e 28 00 00 80 00
> usb-storage: Bulk Command S 0x43425355 T 0x32d L 65536 F 128 Trg 0 LUN 0 CL 12
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_bulk_transfer_sglist: xfer 65536 bytes, 2 entries
> 

