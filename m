Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265357AbSIWKWn>; Mon, 23 Sep 2002 06:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265358AbSIWKWm>; Mon, 23 Sep 2002 06:22:42 -0400
Received: from jack.stev.org ([217.79.103.51]:54438 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id <S265357AbSIWKWm>;
	Mon, 23 Sep 2002 06:22:42 -0400
Message-ID: <017e01c262ec$876bfb80$0cfea8c0@ezdsp.com>
From: "James Stevenson" <james@stev.org>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "Kernel" <linux-kernel@vger.kernel.org>
References: <017801c262eb$010a3d00$0cfea8c0@ezdsp.com> <3D8EEB48.6010105@mandrakesoft.com>
Subject: Re: via82cxxxx.c ?
Date: Mon, 23 Sep 2002 11:32:33 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> James Stevenson wrote:
> > Hi
> >
> > i have the following on motherboard card.
> >
> >  Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio
> > Controller (rev 48).
> >
> > there appears ot be a driver for it. But i am havign a few problems with
it
> > when the driver loads it says it picks the card up no problem
> > and stays loaded and has the ioports, irq in /proc/*
>
>
> sounds like an old kernel -- the driver doesn't support your chip at
> all.  I removed the pci id in later kernels so it wouldn't even load.

yeah i was wondering what was with the pci ids disappearing.
they were in 2.4.18-redhat-7.3 kernel and were there in the
driver download from the sourceforge site but not in 2.4.19

> It needs VT8233 support added to it (on my todo list), or you can use
> ALSA, which supports VT8233.

i would attempt to add support for it myself but i dont know where
to get the docs from for the chipset from.


    James





