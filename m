Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131532AbRANJse>; Sun, 14 Jan 2001 04:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRANJsY>; Sun, 14 Jan 2001 04:48:24 -0500
Received: from styx.suse.cz ([195.70.145.226]:65275 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131532AbRANJsG>;
	Sun, 14 Jan 2001 04:48:06 -0500
Date: Sun, 14 Jan 2001 10:48:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount, getting closer
Message-ID: <20010114104802.A804@suse.cz>
In-Reply-To: <20010114094447.A365@suse.cz> <Pine.LNX.4.30.0101140937470.6203-100000@svea.tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101140937470.6203-100000@svea.tellus>; from tori@tellus.mine.nu on Sun, Jan 14, 2001 at 09:45:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 09:45:09AM +0100, Tobias Ringstrom wrote:
> On Sun, 14 Jan 2001, Vojtech Pavlik wrote:
> > On Sat, Jan 13, 2001 at 11:36:13PM +0100, Tobias Ringstrom wrote:
> >
> > > I have now tried the SAMSUNG VG34323A disk with two other controllers at
> > > home (Promise ATA100 an VIA vt82c686a rev 0x22, both on an ASUS A7V
> > > motherboard), and there are no problems to be found with DMA enabled.
> > > Streaming 10 MB/s without glitches.
> >
> > So the drive *did* work on the vt82c686a in the A7V board? You tested it
> > both on the Promise and on the 686a? But doesn't work on the 686a in
> > your other board?
> 
> Yes, on both the Promise and on the 686a.  But the device revisions are
> different.  The machine that does NOT work:
> 
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 1b)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
> 
> The machine that works:
> 
> 00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
> 00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
> 
> The one the works is a 1 GHz Athlon, and the other is an 800 MHz
> Pentium-III.
> 
> > > no matter what cable I use.  When I get this, the machine does not recover
> > > most of the time, and I have to reset or power cycle.
> >
> > It should be able to recover in a couple (up to 10) minutes ...
> 
> Who waits 10 minutes for a timeout?  Can it be lowered?

It's not a 10 minute timeout, it's a shorter timeout retried many times.
Not my code, though - this is generic PCI IDE code, and is a huge mess.

> Expect another mail with the data you requested within a couple of hours.

Thanks a lot.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
