Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131329AbRANJpY>; Sun, 14 Jan 2001 04:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRANJpO>; Sun, 14 Jan 2001 04:45:14 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:27908 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S131329AbRANJpG>;
	Sun, 14 Jan 2001 04:45:06 -0500
Date: Sun, 14 Jan 2001 09:45:09 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount, getting closer
In-Reply-To: <20010114094447.A365@suse.cz>
Message-ID: <Pine.LNX.4.30.0101140937470.6203-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001, Vojtech Pavlik wrote:
> On Sat, Jan 13, 2001 at 11:36:13PM +0100, Tobias Ringstrom wrote:
>
> > I have now tried the SAMSUNG VG34323A disk with two other controllers at
> > home (Promise ATA100 an VIA vt82c686a rev 0x22, both on an ASUS A7V
> > motherboard), and there are no problems to be found with DMA enabled.
> > Streaming 10 MB/s without glitches.
>
> So the drive *did* work on the vt82c686a in the A7V board? You tested it
> both on the Promise and on the 686a? But doesn't work on the 686a in
> your other board?

Yes, on both the Promise and on the 686a.  But the device revisions are
different.  The machine that does NOT work:

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 1b)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)

The machine that works:

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)

The one the works is a 1 GHz Athlon, and the other is an 800 MHz
Pentium-III.

> > no matter what cable I use.  When I get this, the machine does not recover
> > most of the time, and I have to reset or power cycle.
>
> It should be able to recover in a couple (up to 10) minutes ...

Who waits 10 minutes for a timeout?  Can it be lowered?

Expect another mail with the data you requested within a couple of hours.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
