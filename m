Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130572AbRAaIaq>; Wed, 31 Jan 2001 03:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131226AbRAaIag>; Wed, 31 Jan 2001 03:30:36 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:4361 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S130572AbRAaIaW>;
	Wed, 31 Jan 2001 03:30:22 -0500
X-Envelope-From: kraxel@goldbach.in-berlin.de
Date: Wed, 31 Jan 2001 08:41:45 +0100
From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Message-Id: <200101310741.f0V7fj600833@bogomips.masq.in-berlin.de>
To: msg2@po.cwru.edu, John Jasen <jjasen1@umbc.edu>
Cc: <linux-kernel@vger.kernel.org>, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: bttv problems in 2.4.0/2.4.1
In-Reply-To: <Pine.LNX.4.32.0101302004420.1138-100000@cheetah.STUDENT.cwru.edu>
In-Reply-To: <Pine.SGI.4.31L.02.0101301951040.887333-100000@irix2.gl.umbc.edu> <Pine.LNX.4.32.0101302004420.1138-100000@cheetah.STUDENT.cwru.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I have sent all this info to Gerd Knorr but, as far as I know, he hasn't
> > > been able to track down the bug yet.  I thought that by posting here,
> > > more eyes might at least make more reports of similar situations that
> > > might help track down the problem.
> >
> > Try flipping the card into a different slot. A lot of the cards
> > exceptionally do not like IRQ/DMA sharing, and a lot of the motherboards
> > share them between different slots.
> 
> I will try this, but my card has (and does) worked with irq sharing for
> a long time.  Its entry in /proc/interrupts:
>   9:     164935     165896   IO-APIC-level  acpi, bttv
                                              ^^^^
What happens with acpi disabled?  The power-down at boot could be caused by
the acpi power management maybe ...

  Gerd

-- 
Get back there in front of the computer NOW. Christmas can wait.
	-- Linus "the Grinch" Torvalds,  24 Dec 2000 on linux-kernel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
