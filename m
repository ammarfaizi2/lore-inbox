Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbTBQVMY>; Mon, 17 Feb 2003 16:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbTBQVMY>; Mon, 17 Feb 2003 16:12:24 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:47510 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S267512AbTBQVMW>;
	Mon, 17 Feb 2003 16:12:22 -0500
Date: Mon, 17 Feb 2003 22:22:02 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Art Haas <ahaas@airmail.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] C99 initializers for drivers/macintosh/mac_hid.c
In-Reply-To: <200302171957.42597@enzo.bigblue.local>
Message-ID: <Pine.GSO.4.21.0302172221020.25406-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Franz Sirl wrote:
> On Monday 17 February 2003 10:40, Geert Uytterhoeven wrote:
> > On Sat, 15 Feb 2003, Art Haas wrote:
> > > This patch converts the file to use C99 initializers to improve
> > > readability and remove warnings if '-W' is used.
> > >
> > > Art Haas
> > >
> > > ===== drivers/macintosh/mac_hid.c 1.8 vs edited =====
> > > --- 1.8/drivers/macintosh/mac_hid.c	Tue Oct  8 05:51:31 2002
> > > +++ edited/drivers/macintosh/mac_hid.c	Sat Feb 15 13:19:37 2003
> >
> > Apparently this file is no longer used? I couldn't find
> > CONFIG_MAC_EMUMOUSEBTN in any Kconfig, unless it's in the PPC tree only.
> 
> Huh? It's in arch/ppc/Kconfig, even in plain Linus tree. Unfortunately it's 
> still impossible with current input layer (no way to prevent events from 
> reaching other handlers) to clean it up or move it to userspace, so it has to 
> stay :-(.

Aarghl, I keep on using grep with the CONFIG_ part included...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

