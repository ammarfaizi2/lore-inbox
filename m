Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129612AbRBAMdp>; Thu, 1 Feb 2001 07:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129589AbRBAMdg>; Thu, 1 Feb 2001 07:33:36 -0500
Received: from celebris.bdk.pl ([212.182.99.100]:27923 "EHLO celebris.bdk.pl")
	by vger.kernel.org with ESMTP id <S129348AbRBAMdW>;
	Thu, 1 Feb 2001 07:33:22 -0500
Date: Thu, 1 Feb 2001 13:34:08 +0100 (CET)
From: Wojtek Pilorz <wpilorz@bdk.pl>
To: Robert Kaiser <rob@sysgo.de>
cc: Patrizio Bruno <patrizio@dada.it>, linux-kernel@vger.kernel.org
Subject: Re: Disk is cheap?
In-Reply-To: <200101311612.RAA02360@rob.devdep.sysgo.de>
Message-ID: <Pine.LNX.4.21.0102011326330.11671-100000@celebris.bdk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Robert Kaiser wrote:

> Date: Wed, 31 Jan 2001 17:12:47 +0100
> From: Robert Kaiser <rob@sysgo.de>
> To: Patrizio Bruno <patrizio@dada.it>, linux-kernel@vger.kernel.org
> Subject: Re: Disk is cheap?
> 
> In article <Pine.LNX.4.10.10101311550150.3588-100000@blacksheep.at.dada.it>,
> 	patrizio@dada.it (Patrizio Bruno) writes:
> > I built a embedded dvd/cdda/mp3 player based on linux, using a p200mmx
> > with 24mb with a bus of 75mhx, but it still takes about 20 seconds to boot,
> > I think that an embedded device (for home use) should boot in less than
> > 5 seconds, how could be possible with a slow p133? (I've also tried a p133
> > on 66mhz of bus and it takes almost 35 seconds to boot)
> 
> Usually most of the startup time is spent by the BIOS doing
> extensive self-test stuff and for firing up services (http,
> inetd, sendmail, ...) that many embedded systems have little use for.
> 
> I have a 25MHz 386EX (~2.2 Bogomips) here that boots Linux out of ROM
> in roughly 30 seconds. Most of _that_ time however is spent decompressing
> the kernel.
>
[...]
If someone would modify kernel to allow LZO compression then the
decompression would be 3 times faster at the expense of
compressed part of the image being 9..10% larger (assuming LZO1X-999/9
method used by lzop -9)
(I have done decompression speed tests on Pentium MMX 166 MHz)

Best regards,

Wojtek
--------------------
Wojtek Pilorz
Wojtek.Pilorz@bdk.pl


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
