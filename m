Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129629AbRBAE5M>; Wed, 31 Jan 2001 23:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129715AbRBAE5D>; Wed, 31 Jan 2001 23:57:03 -0500
Received: from goalkeeper.d2.com ([198.211.88.26]:60704 "HELO
	goalkeeper.d2.com") by vger.kernel.org with SMTP id <S129629AbRBAE4y>;
	Wed, 31 Jan 2001 23:56:54 -0500
Date: Wed, 31 Jan 2001 20:51:37 -0800
From: Greg from Systems <chandler@d2.com>
To: John Jasen <jjasen1@umbc.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bummer...
In-Reply-To: <Pine.SGI.4.31L.02.0101312218130.32454-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.SGI.4.10.10101311933320.29904-100000@hell.d2.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the kind of problem I have been experiancing.
It either hangs on boot, or in a compile...
However I am using an NCR 810 and a scsi disk..
My board is the Compaq PC164 {some nasty partnumber}

The Servers all have the Qlogic ISP controller for the main disk.

both setups have only the boot disk on the boot controller, no other
devices....

On Wed, 31 Jan 2001, John Jasen wrote:

> On Wed, 31 Jan 2001, Greg from Systems wrote:
> 
> > I've been playing with the 2.4.0 kernel scince you gave me the patch for
> > the alphas...
> >
> > What I have found is that it tends to randomly hang...
> > No Panic, no OOPs, no nothing...
> > The machine is a PC164, Which falls under the EB164 class.
> > It exhibits this behaviour on both the "generic" and "eb164" cpu types
> > {compile option}  It doesn't even boot compiled as pc164..
> > I'm also seeing this problem on my A/S 4100, "Rawhide"..
> 
> I've been having IDE problems under alpha (API UP1100 motherboard) with
> the ALI M1535D pci-isa bridge/ide controller and the AIC7xxx drivers.
> Under 2.4.0, any heavy disk access "dd if=/dev/hda of=/dev/null" will
> immediately lock the system, and under 2.4.1, it won't finish booting ...
> 
> --
> -- John E. Jasen (jjasen1@umbc.edu)
> -- In theory, theory and practise are the same. In practise, they aren't.
> 

----------------------------------------------------------------------------

IGNOTUM PER IGNOTIUS

"Grasshopper always wrong in argument with chicken"

The "socratic approach" is what you call starting an argument by
asking questions.

The human race will begin solving it's problems on the day that it 
ceases taking itself so seriously.

                                        PRINCIPIA DISCORDIA


                Published by POEE Head Temple - San Francisco
                      " On The Future Site of Beautiful
                             San Andreas Canyon"


                                                Please do not use this
                                                document as toilet tissue
Fnord


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
