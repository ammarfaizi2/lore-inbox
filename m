Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132087AbRAPQkU>; Tue, 16 Jan 2001 11:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132084AbRAPQkL>; Tue, 16 Jan 2001 11:40:11 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:60686 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S131094AbRAPQkG>; Tue, 16 Jan 2001 11:40:06 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95190@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Brian Gerst'" <bgerst@didntduck.org>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'David Woodhouse'" <dwmw2@infradead.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 11:35:36 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When the cards are of different make the order is solely dependent on
> the order that the drivers are initialized in the kernel.  If you have
> modules enabled, only build the driver for your root device into the
> kernel image and have the other modular.  This lets you control the
> initialization order to your liking.
	[Venkatesh Ramamurthy]  I think there should be a better way to
handle this , compiling is one of the options, but an end-user should not
think of compiling. The end user needs to put an another card and connect
drives and get his system up and running. He should not think of compiling
the drivers, if it is already part of the kernel / initrd to get his system
running.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
