Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268078AbRG2Qai>; Sun, 29 Jul 2001 12:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268084AbRG2Qa1>; Sun, 29 Jul 2001 12:30:27 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:23446 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S268078AbRG2QaU>; Sun, 29 Jul 2001 12:30:20 -0400
Date: Sun, 29 Jul 2001 11:30:08 -0500
From: "Glenn C. Hofmann" <hofmanng@swbell.net>
Subject: Re: Problems with 2.4.7 and VIA IDE
In-Reply-To: <E15QWqv-0007qf-00@the-village.bc.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rodrigo Ventura <yoda@isr.ist.utl.pt>, linux-kernel@vger.kernel.org
Message-id: <996424209.20545.7.camel@hofmann1>
MIME-version: 1.0
X-Mailer: Evolution/0.11.99 (Preview Release)
Content-type: text/plain
Content-transfer-encoding: 7bit
In-Reply-To: <E15QWqv-0007qf-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I think I can help verify your suspicions with the PCI problems, since I
get the error with my ethernet device (3C905B), although I do not get
the ide errors.  I went from kernel 2.4.7-pre3 to 2.4.8 and started
receiving these errors.  I have a WinTV Go board that is notorious for
locking things up which shares an IRQ with the ethernet controller.  I
started up my tv viewer program and lost my ethernet connection.  If
there is anything I can do that might help further, let me know.

Chris

On 28 Jul 2001 17:22:09 +0100, Alan Cox wrote:
> >         This is sort of a continuation of my last msg. I tried a rpm
> > -Va on one xterm and a tar cf /dev/null / on another, and I got
> > another dma error:
> > 
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> BadCRC is normally a cable error, but I'm suspicious that its also one of
> the things caused by PCI bus problems on the VIA stuff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


