Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291624AbSBVC4p>; Thu, 21 Feb 2002 21:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292556AbSBVC4f>; Thu, 21 Feb 2002 21:56:35 -0500
Received: from ginsberg.uol.com.br ([200.231.206.26]:7372 "EHLO
	ginsberg.uol.com.br") by vger.kernel.org with ESMTP
	id <S291624AbSBVC4U>; Thu, 21 Feb 2002 21:56:20 -0500
Date: Thu, 21 Feb 2002 23:55:34 -0300 (BRT)
From: Cesar Suga <sartre@linuxbr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HPT366: DMA errors?
In-Reply-To: <E16e5Zw-0000al-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0202212352001.222-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Alan Cox wrote:

> > through these messages when using the *original* ATA cable (never touched
> > before) or a replacement one:

> > hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hde: dma_intr: error=0x84 { DriveStatusError BadCRC }

> CRC error -> cable/wiring problem. If you are using UDMA66/100 you must
> have an 80pin cable. If you are using UDMA33 and can't pin it down then
> an 80pin cable doesnt do any harm

	Yes, I am using the 80pin cable. The BP6 board has the normal IDE
controller and the HPT controller. The normal IDE controller which I said
was the common 40pin one. The DMA66 cable, certainly, is the 80 pin.

	I cannot use the 80pin cable with the normal IDE for it does not
fit. But I tried with two 80-pin cables.

	Thanks,
	Cesar Suga <sartre@linuxbr.com>


