Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbRBADVA>; Wed, 31 Jan 2001 22:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130053AbRBADUv>; Wed, 31 Jan 2001 22:20:51 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:26296 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S129820AbRBADUf>;
	Wed, 31 Jan 2001 22:20:35 -0500
Date: Wed, 31 Jan 2001 22:20:33 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Greg from Systems <chandler@d2.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bummer...
In-Reply-To: <Pine.SGI.4.10.10101311509400.29904-100000@hell.d2.com>
Message-ID: <Pine.SGI.4.31L.02.0101312218130.32454-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Greg from Systems wrote:

> I've been playing with the 2.4.0 kernel scince you gave me the patch for
> the alphas...
>
> What I have found is that it tends to randomly hang...
> No Panic, no OOPs, no nothing...
> The machine is a PC164, Which falls under the EB164 class.
> It exhibits this behaviour on both the "generic" and "eb164" cpu types
> {compile option}  It doesn't even boot compiled as pc164..
> I'm also seeing this problem on my A/S 4100, "Rawhide"..

I've been having IDE problems under alpha (API UP1100 motherboard) with
the ALI M1535D pci-isa bridge/ide controller and the AIC7xxx drivers.
Under 2.4.0, any heavy disk access "dd if=/dev/hda of=/dev/null" will
immediately lock the system, and under 2.4.1, it won't finish booting ...

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
