Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265506AbUABMoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 07:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbUABMoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 07:44:23 -0500
Received: from witte.sonytel.be ([80.88.33.193]:49087 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265506AbUABMoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 07:44:21 -0500
Date: Fri, 2 Jan 2004 13:44:07 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Claas Langbehn <claas@rootdir.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       =?iso-8859-15?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
Subject: Re: 2.6.0: atyfb broken
In-Reply-To: <20040101215308.GA16921@rootdir.de>
Message-ID: <Pine.GSO.4.58.0401021341010.3062@waterleaf.sonytel.be>
References: <20031230212609.GA4267@rootdir.de> <Pine.GSO.4.58.0401011951510.2916@waterleaf.sonytel.be>
 <20040101215308.GA16921@rootdir.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jan 2004, Claas Langbehn wrote:
> > > I have got an HP omnibook 4150B. When booting with atyfb,
> > > the kernel messages look great:
> > >
> > > atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL, 230 MHz PLL, 50 Mhz MCLK
> > > fb0: ATY Mach64 frame buffer device on PCI
> > >
> > > But either the screen is black and I see only the cursor and Background
> > > colors (CONFIG_FRAMEBUFFER_CONSOLE disabled), but X11 starts fine.
> >
> > Does your notebook work with the atyfb in 2.4.23? With the one in 2.4.22 and
> > earlier?
>
> with 2.4.23 it does not work either.
>
> dmesg says:
>
> atyfb: using auxiliary register aperture
> atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
> atyfb: BIOS contains driver information table.
> atyfb: colour active matrix monitor detected: CPT CLAA141XB01
>         id=10, 1024x768 pixels, 262144 colours (LT mode)
>         supports 60 Hz refresh rates, default 60 Hz
>         LCD CRTC parameters: 15384 167 127 130 0 17 805 767 769 6
> atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL,
>        230 MHz PLL, 83 Mhz MCLK, 125 Mhz XCLK
> Console: switching to colour frame buffer device 80x25
> fb0: ATY Mach64 frame buffer device on PCI
>
>
> When booting the screen gets slowly flooded with white.
> X11 works anyway.
>
> dmesg's output shows different MCLK and XCLK with kernel 2.4.23
> (see above).

Does it work with 2.4.22 and earlier? Mobility support was changed a lot in
2.4.23.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
