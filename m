Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRFRTVa>; Mon, 18 Jun 2001 15:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbRFRTVV>; Mon, 18 Jun 2001 15:21:21 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:50373 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S262436AbRFRTVG>;
	Mon, 18 Jun 2001 15:21:06 -0400
Date: Mon, 18 Jun 2001 21:20:53 +0200 (MEST)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: very strange (semi-)lockups in 2.4.5
In-Reply-To: <200106181710.f5IHA1R458562@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.30.0106182118260.20838-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First I thought this was an X-issue, but now I'm 100% sure that it isn't,
as I met the desscribed hangup while working on the console too.

The NMI card would be interesting, if anyone tells me how to make one, and
how to patch the kernel to show useable information i'm looking forward to
do it, and send reports.


regards
Balazs Pozsar.

On Mon, 18 Jun 2001, Albert D. Cahalan wrote:

> Pozsar Balazs writes:
>
> > I'm having ~2 lockups a day. The following happens:
> >  If I was under X, i only can use the magic-key, but no other keyboard (eg
> > numlock) or mouse response, the screen freezes, processes stop.
> >  If i was using textmode:
> >   numlock still works
> >   cursor blinks
> >   processess stop (eg, gpm doesn't work, outputs freeze)
> >   i can still switch vt's.
> >   BUT, i can only type into a few vt's, last time into 3,5,6,7,8, but not
> > into 1,2 or 4!
> >
> > I cannot give you any traces, as i dont have any.
> >
> > Also note that magic-key works, and it says that it umounts filesystems if
> > i press magic-u, but next time at mount i see that reiserfs is replaying
> > transactions.
> >
> >
> > Any ideas?
> >
> > The machine is a P3-750, 512M ram, abit vp6 mb. No overclocking, and it
> > passes memtest86.
>
> I think I'm getting the same thing, but I don't have the magic-key
> compiled in. I'm going to hook up a VT510 to the serial port, in case
> this is just XFree86 crashing. For anyone collecting statistics:
>
> kernels 2.4.4-pre6 (?) and now 2.4.6-pre3
> plain Pentium MMX @ 200 MHz
> Intel motherboard -- see below
> stable since 1996, on a UPS, dust-free, and the fan works
> one lockup per day with desktop usage
>
> In case the serial console doesn't work, could someone post plans
> for a safe NMI board? (both ISA and PCI) The best I found:
> http://www.sandelman.ottawa.on.ca/linux-ipsec/html/2000/02/msg00425.html
> http://www.sandelman.ottawa.on.ca/linux-ipsec/html/2000/02/msg00391.html
> (for PCI you're supposed to assert SERR# on the clock -- how?)
>
> 00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
> 00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
> 00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> 00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
> 00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
> 00:11.0 Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip] (rev 23)
> 00:13.0 Ethernet controller: Lite-On Communications Inc LNE100TX Fast Ethernet Adapter (rev 25)
> 00:14.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP (rev 5c)
>


-- 


