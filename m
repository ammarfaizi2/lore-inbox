Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267988AbTCFKfF>; Thu, 6 Mar 2003 05:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267991AbTCFKfF>; Thu, 6 Mar 2003 05:35:05 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:63939 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S267988AbTCFKfE>;
	Thu, 6 Mar 2003 05:35:04 -0500
Date: Thu, 6 Mar 2003 11:44:53 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Osamu Tomita <tomita@cinet.co.jp>
cc: "'Christoph Hellwig '" <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (16/21) SCSI
In-Reply-To: <20030224135940.GA1115@yuzuki.cinet.co.jp>
Message-ID: <Pine.GSO.4.21.0303061141180.28248-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Osamu Tomita wrote:
> This is additional patch to support NEC PC-9800 subarchitecture
> against 2.5.62-ac1. (16/21) re-send
> 
> I re-write this patch. Comment please.
> 
> SCSI host adapter support.
>  - BIOS parameter change for PC98.
>  - Add pc980155 driver for old PC98.
>  - wd33c93.c compile fix.

By any chance, you don't have fixes for the wd33c93 abort and reset handling
(.eh_{abort,bus_reset}_handler)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

