Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290696AbSAYPFh>; Fri, 25 Jan 2002 10:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290702AbSAYPF1>; Fri, 25 Jan 2002 10:05:27 -0500
Received: from windsormachine.com ([206.48.122.28]:20243 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S290696AbSAYPFQ>; Fri, 25 Jan 2002 10:05:16 -0500
Date: Fri, 25 Jan 2002 10:05:08 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Marcel Kunath <kunathma@pilot.msu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ABIT BX6 Rev 2.0 and Kernel Oopses
In-Reply-To: <200201251243.g0PChCA34512@pilot05.cl.msu.edu>
Message-ID: <Pine.LNX.4.33.0201250956580.27568-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, Marcel Kunath wrote:

> I just got mail from Reid and he said he now slowed down his 450 CPu to a
> lower speed and it now boots Linux as well. I guess its a work around but
> there must be a bug to catch either in the kernel or in the BIOS or the
> engineering of the board itsxelf.
>
> I guess one can only find the bug by getting two original boards and flashing
> the BIOS of one of them and then comparing their functioning.
>
> mk
>
I use a BX6 at home, running Win98SE fine.  When I made the mistake of
installing Windows 2000, it loaded and ran fine for me.  Had to dump it
because of the lack of dual monitor support for a lot of cards that worked
fine in Win98SE.

As well, the machine ran Debian 2.2r3 with both 2.2.19 and early 2.4
kernels.

BX6r2, QR bios, Celeron 466 @ 466, 512 meg (2 x 256 meg Micron PC133 cas3)
Quantum LM 30 gig, Quantum KX 13.6, Advansys 960U scsi card
Creative Annihilator Geforce2 GTS(something like that, marketing sucks! :D)
ATI Mach64 based secondary video, SB Live!, DFE-530TX network card

My only problems is when the USB webcam(3com's high end one, don't
remember the name) is running in netmeeting, my sound breaks up.  Very
very frustrating, I've spent a lot of time trying to fix it, it's almost
to the point where i find my old sb32awe.

It sounds like something's not set right with your CMOS settings.
Something at 100mhz is causing problems that goes away at 66.  Try
underclocking to 456(5.5*83).  If that don't work, try 412(5.5*75).

Otherwise, try setting your cmos settings to default, and shut off ACPI,
cause I've ran into problems when that is enabled.

These boards can be tempermental, but stable once you get them setup
right.  I have maybe a dozen of them at the office running 95/98, and
haven't had problems, compared to some of the VIA chipset crap here that
ends up being bought in the interest of saving money.

mike

