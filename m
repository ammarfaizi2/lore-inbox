Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbQLCIzX>; Sun, 3 Dec 2000 03:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQLCIzN>; Sun, 3 Dec 2000 03:55:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4114 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129501AbQLCIzH>; Sun, 3 Dec 2000 03:55:07 -0500
Date: Sun, 3 Dec 2000 00:23:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Transmeta and Linux-2.4.0-test12-pre3
In-Reply-To: <E142CLF-0001WT-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012030011130.7633-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Dec 2000, Alan Cox wrote:
> 
> > But the camera is cool, and works beautifully (once you get XFree86
> > happy) thanks to Andrew Tridgell.  (If I could just coax the X server
> > into giving my a YUV overlay I could play DVD's with this thing). 
> 
> Start at http://www.core.binghamton.edu/~insomnia/gatos/

Heh.

I integrated "ati_video.c" from ati_xv into the current XFree86 CVS
sources, and yup, sure as h*ll, I can play movies fine. Quite smooth (at
least the 24 fps stuff - I bet it drops frames like mad for any 30fps
movies). It's quite cute.

There's some redraw bug in the overlay code, and it doesn't understand
virtual desktops larger than the physical desktop. Details, details. 

	Thanks for the pointer,

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
