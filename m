Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRAWSPH>; Tue, 23 Jan 2001 13:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbRAWSOr>; Tue, 23 Jan 2001 13:14:47 -0500
Received: from [209.209.13.26] ([209.209.13.26]:62216 "EHLO smile.idiom.com")
	by vger.kernel.org with ESMTP id <S129406AbRAWSOm>;
	Tue, 23 Jan 2001 13:14:42 -0500
Message-Id: <200101231813.KAA24039@echo.vennerable.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)  (win98 not honoring partitioning)
In-Reply-To: Message from Ragnar Hojland Espinosa <ragnar@fuckmpaa.com> 
   of "Tue, 23 Jan 2001 13:43:33 +0100." <20010123134333.A1096@lightside.2y.net> 
Date: Tue, 23 Jan 2001 10:13:59 -0800
From: Jason Venner <jason@vennerable.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Windows 98 and possibly followons doesn't quite honor 'b' type
partitions in the extended area of the disk, particularily if you are
past the 8gig boundary and the partitions in question are over 2gig.
The above numbers are NOT hard boundaries, I have only seen this on 2
computers and those numbers are approximate.

Generally, I have to use partition magic to make partitions past that
point if I don't want windows to scribble all over my other
partitions.

This is quite a nightmare, and not all that easy to diagnose or fix.


> On Tue, Jan 23, 2001 at 12:33:45AM -0500, Mike A. Harris wrote:
> > On Mon, 15 Jan 2001, Trever Adams wrote:
> > 
> > >I had a similar experience.  All I can say is windows 98
> > >and ME seem to have it out for Linux drives running late
> > >2.3.x and 2.4.0 test and release.  I had windows completely
> > >fry my Linux drive and I lost everything.  I had some old
> > 
> > I don't see how Windows 9x can be at fault in any way shape or
> > form, if you can boot between 2.2.x kernel and 9x no problem, but
> > lose your disk if you boot Win98 and then 2.3.x/2.4.x and lose
> > everything.  Windows does not touch your Linux fs's, so if there
> 
> WS Windows might reprogram IDE / drives in some way that, being left in that
> state, conflict with linux's. .. well, ask Andre, he'll know :)
> 
> -- 
> ____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
> \ o.O|                                                   2F0D27DE025BE2302C
>  =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
>    U     chaos and madness await thee at its end."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
