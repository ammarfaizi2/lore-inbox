Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132349AbRAaB6Y>; Tue, 30 Jan 2001 20:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132957AbRAaB6P>; Tue, 30 Jan 2001 20:58:15 -0500
Received: from getafix.lostland.net ([216.29.29.27]:60946 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S132349AbRAaB56>; Tue, 30 Jan 2001 20:57:58 -0500
Date: Tue, 30 Jan 2001 20:57:28 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: Prasanna P Subash <psubash@turbolinux.com>
cc: John Jasen <jjasen1@umbc.edu>, Matthew Gabeler-Lee <msg2@po.cwru.edu>,
        <linux-kernel@vger.kernel.org>, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: bttv problems in 2.4.0/2.4.1
In-Reply-To: <20010130171528.B25507@turbolinux.com>
Message-ID: <Pine.BSO.4.30.0101302052020.1103-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmmm,

   I have a bt848 based video capture card, and get near the same results:
2.4.0-test10 through 2.4.1 all lock when i2c registers the device.  The
card has its own interrupt.  With 2.2.18, the card initialized and the
kernel continued to boot.  Interesting.

Regards,
Adrian


On Tue, 30 Jan 2001, Prasanna P Subash wrote:

> I have experienced similar issues with 2.4.0 and its test. I have a bttv848 chipset.
> I even tried compiling in kdb as a part of the kernel to see if it oopses, but no luck.
>
> I will try trying 0.7.47 today.
>
> this works on 2.2.16, last time i tried.
>
> --
> Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
> ------------------------------------------------------------------------
> Linux, the choice          | "You've got to think about tomorrow!"
> of a GNU generation   -o)  | "TOMORROW!  I haven't even prepared for
> Kernel 2.4.0-ac4      /\\  | yesterday* yet!"
> on a i686            _\\_v |
>                            |
> ------------------------------------------------------------------------
>
> On Tue, Jan 30, 2001 at 07:53:11PM -0500, John Jasen wrote:
> > On Tue, 30 Jan 2001, Matthew Gabeler-Lee wrote:
> >
> > > These errors all occur in the same way (as near as I can tell) in
> > > kernels 2.4.0 and 2.4.1, using bttv drivers 0.7.50 (incl. w/ kernel),
> > > 0.7.53, and 0.7.55.
> > >
> > > I am currently using 2.4.0-test10 with bttv 0.7.47, which works fine.
> > >
> > > I have sent all this info to Gerd Knorr but, as far as I know, he hasn't
> > > been able to track down the bug yet.  I thought that by posting here,
> > > more eyes might at least make more reports of similar situations that
> > > might help track down the problem.
> >
> > Try flipping the card into a different slot. A lot of the cards
> > exceptionally do not like IRQ/DMA sharing, and a lot of the motherboards
> > share them between different slots.
> >
> > --
> > -- John E. Jasen (jjasen1@umbc.edu)
> > -- In theory, theory and practise are the same. In practise, they aren't.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
>
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
