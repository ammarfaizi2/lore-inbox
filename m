Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265046AbSKFNkr>; Wed, 6 Nov 2002 08:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSKFNkr>; Wed, 6 Nov 2002 08:40:47 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:13953 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265046AbSKFNkq>;
	Wed, 6 Nov 2002 08:40:46 -0500
Date: Wed, 6 Nov 2002 14:46:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: busmouse support (2 of them?)
In-Reply-To: <20021106114215.E25154@ucw.cz>
Message-ID: <Pine.GSO.4.21.0211061445560.25960-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Vojtech Pavlik wrote:
> On Tue, Nov 05, 2002 at 05:37:37PM -0800, Randy.Dunlap wrote:
> > In (menu)config, there is
> >   Character Devices, Mice --->, Bus mouse support
> > and then there is
> >   Input drivers, Mice, Inport busmouse
> > 
> > Are both of these needed?  I.e., can the first one be removed?
> 
> The first can be removed once all the drivers using the busmouse.c
> infrastructure are removed. They were all removed on i386 and other
> modern architectures, but I'm not 100% sure some Atari driver is not
> using it.

Atari busmouse support was removed. However, there's no new-style input layer
driver for it yet.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

