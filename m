Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271401AbUJVQAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271401AbUJVQAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271400AbUJVQAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:00:01 -0400
Received: from kalmia.hozed.org ([209.234.73.41]:63120 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S271404AbUJVP7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:59:54 -0400
Date: Fri, 22 Oct 2004 10:59:53 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Timothy Miller <miller@techsource.com>
Cc: John Ripley <jripley@rioaudio.com>,
       "'Greg Buchholz'" <linux@sleepingsquirrel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041022155953.GD8088@kalmia.hozed.org>
References: <82D5E38355314D46AF3015FF55F6955802F83515@CORPMAIL3> <4177FF47.5040005@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <4177FF47.5040005@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 02:26:15PM -0400, Timothy Miller wrote:
> 
> 
> John Ripley wrote:
> 
> >
> >It would also really reduce the cost and effort involved in producing the
> >card. It wouldn't take much (heh) to get it up and running as a simple 
> >frame
> >buffer + blitter, but it could be scaled to do fancy multi-texture ops over
> >time - all just by reprogramming the FPGA. All the manufacturer needs to
> >provide is a "getting started" FPGA file and output to a video DAC. The
> >community would do the rest over time.
> >
> >I think "Open" hardware is one thing, but open *and* completely
> >reprogrammable is a far greater hook, at least for me. I'd be prepared to
> >shell out a few $100 for something as hackable as that. Hey, it's an FPGA 
> >on
> >a PCI Express card at the end of the day, what can't you do with it!
> >
> 
> 
> Ok, I'll bite.  What you're suggesting is that instead of developing 
> just a graphics card, I should develop a card populated with a bunch of 
> FPGA's that's reprogrammable.  Putting aside the logic design tool issue 
> (which may be difficult), what you'd get is a very expensive 
> reprogrammable card with some RAM and some video output hardware.
> 
> How much would you pay for THIS card?  $2000?
> 
> Now, the thing is, this card is SO generic that Tech Source would have 
> very little value-add.  Say we populate it with a bunch of Spartan 3 
> 400's... well, you'd download Xilinx's WebPack, code up your design in 
> Verilog (Do you want to learn chip design???  It's not like programming 
> in C!!!), and then use our open source utility to upload your code.
> 
> GREAT... until some other company comes along and clones it, which would 
> be WAY too easy to do.  Now, for the users of this sort of product, it's 
> a fine thing.  But it becomes a pointless investment for Tech Source, 
> which is where I work and who pays me to work on this stuff, which they 
> wouldn't do if it's not worth it.

Make a PCI-Express card -> dual DVI output, with whatever number of
FPGA's gets you to $500 cost. If people want to play with reconfigurable
whatever, let them go ahead.

Techsource's value-add is an *optimized* high-performance bitstream that
implements a nice graphics card that has fully documented open-source
linux drivers. You can sell the hardware at cost, but what people really
want (and will pay for) is the fastest high-end 3d rendering stuff for
engineering and technical applications. They will probably also pay for
subscribtion updates where techsource takes the latest innovate ideas
that someone implemented on this hardware as a research project, and
then someone with the experience in graphics and hardware design can
make it go fast and work with the rest of the other optimized features.

You could go so far as to do something like ghostscript and release the
verilog source after 2 years when nobody cares about the old hardware it
runs on anymore (execept the hobbyists).
