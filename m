Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271034AbUJVKcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271034AbUJVKcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271017AbUJVKcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:32:12 -0400
Received: from corpmailsmtp02.digitalnetworksna.com ([209.10.223.203]:65440
	"EHLO corpmailsmtp02.digitalnetworksna.com") by vger.kernel.org
	with ESMTP id S271034AbUJVKcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:32:01 -0400
Message-ID: <82D5E38355314D46AF3015FF55F6955802F83516@CORPMAIL3>
From: John Ripley <jripley@rioaudio.com>
To: "'Timothy Miller'" <miller@techsource.com>
Cc: "'Greg Buchholz'" <linux@sleepingsquirrel.org>,
       linux-kernel@vger.kernel.org
Subject: RE: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Date: Fri, 22 Oct 2004 03:31:57 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Timothy Miller [mailto:miller@techsource.com]
> Sent: 21 October 2004 19:26
> To: John Ripley
> Cc: 'Greg Buchholz'; linux-kernel@vger.kernel.org
> Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
> 
> John Ripley wrote:
> 
> > It would also really reduce the cost and effort involved in 
> > producing the
> > card. It wouldn't take much (heh) to get it up and running 
> > as a simple frame
> > buffer + blitter, but it could be scaled to do fancy 
> > multi-texture ops over
> > time - all just by reprogramming the FPGA. All the 
> > manufacturer needs to
> > provide is a "getting started" FPGA file and output to a 
> > video DAC. The
> > community would do the rest over time.
> > 
> > I think "Open" hardware is one thing, but open *and* completely
> > reprogrammable is a far greater hook, at least for me. I'd 
> > be prepared to
> > shell out a few $100 for something as hackable as that. 
> > Hey, it's an FPGA on
> > a PCI Express card at the end of the day, what can't you do with it!
> 
> 
> Ok, I'll bite.  What you're suggesting is that instead of developing 
> just a graphics card, I should develop a card populated with 
> a bunch of 
> FPGA's that's reprogrammable.  Putting aside the logic design 
> tool issue 
> (which may be difficult), what you'd get is a very expensive 
> reprogrammable card with some RAM and some video output hardware.
>
> How much would you pay for THIS card?  $2000?

Considering you can get a Spartan 2 300,000 gate chip on a board with SDRAM
etc for about $100... I'd say that's a very high estimate. Greg's pricing up
of about $300 sounds about right, and that's with 8 Spartan 3 chips on a
board.

> Now, the thing is, this card is SO generic that Tech Source 
> would have 
> very little value-add.  Say we populate it with a bunch of Spartan 3 
> 400's... well, you'd download Xilinx's WebPack, code up your 
> design in 
> Verilog (Do you want to learn chip design???  It's not like 
> programming 
> in C!!!), and then use our open source utility to upload your code.

I'm well aware that C programming doesn't translate to chip design skills.
I've been playing with Verilog on simulators for a while now and I'd love to
actually put it on some real FPGA hardware. There's plenty of people with
good chip design knowledge willing to provide Free source - just look at
opencores.org. I'm doing ALL of my Verilog toying with Free (properly)
software, and I think there's even a Free tool to interface to Xilinx FPGAs.

> GREAT... until some other company comes along and clones it, 
> which would 
> be WAY too easy to do.  Now, for the users of this sort of 
> product, it's 
> a fine thing.  But it becomes a pointless investment for Tech Source, 
> which is where I work and who pays me to work on this stuff, 
> which they wouldn't do if it's not worth it.

And what would stop them cloning a graphics card with completely Open specs?
That's always an issue no matter what you do.

- John Ripley
