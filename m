Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbSLIKK4>; Mon, 9 Dec 2002 05:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSLIKK4>; Mon, 9 Dec 2002 05:10:56 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:34539 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265039AbSLIKKz>;
	Mon, 9 Dec 2002 05:10:55 -0500
Date: Mon, 9 Dec 2002 11:14:39 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: erik@hensema.xs4all.nl
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: /proc/pci deprecation?
In-Reply-To: <slrnav6eq7.6d2.usenet@dexter.hensema.net>
Message-ID: <Pine.GSO.4.21.0212091113410.8137-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Dec 2002, Erik Hensema wrote:
> Petr Vandrovec (vandrove@vc.cvut.cz) wrote:
> > On Sat, Dec 07, 2002 at 02:14:24PM +0100, Tomas Szepe wrote:
> >> > > IMO, yes, since those tools provide the summary, and exist almost purely in
> >> > > userspace. I forgot to mention in the orginal email that we could also drop
> >> > > the PCI names database, right? This would save a considerable amount in the
> >> > > kernel image alone..
> >> > 
> >> > If you want, make it user configurable like it was during 2.2.x. But
> >> > I personally prefer descriptive names and system overview I can parse 
> >> > without having mounted /usr to get working lspci.
> >> 
> >> Actually I'm inclined to insist that lspci belong in /sbin.  Really.  :)
> > 
> > Try it. At least on Debian it is useless without name database, which lives in
> > /usr/share/misc/pci.ids...  I can read numbers directly from /proc/bus/pci, if
> > I want numbers.
> 
> Hmmmm, on SuSE 8.0 too. I consider this a bug. Or at least a misfeature.
> Binaries in /bin and /sbin should not need anything from /usr.

Originally pci.ids was in /etc/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

