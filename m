Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130190AbQKFVUs>; Mon, 6 Nov 2000 16:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130325AbQKFVUj>; Mon, 6 Nov 2000 16:20:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19296 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130190AbQKFVUb>; Mon, 6 Nov 2000 16:20:31 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 6 Nov 2000 21:19:48 +0000 (GMT)
Cc: oxymoron@waste.org (Oliver Xymoron), dwmw2@infradead.org (David Woodhouse),
        alan@lxorguk.ukuu.org.uk (Alan Cox), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3A06FA73.948357F6@mandrakesoft.com> from "Jeff Garzik" at Nov 06, 2000 01:37:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13stgE-0006dO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some devices have a firmware.h that is compiled into the driver.  A few
> sound devices use a function that loads a firmware file from userspace,
> given a filename.  The comment in drivers/sound/sound_firmware.c says
> that this is a poor method, and that the recommended method for
> uploading firmware to a device is via ioctl.

modutils has a post-install facility that supports firmware load via ioctl
beautifully too

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
