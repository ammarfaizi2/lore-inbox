Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268439AbUJUSVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268439AbUJUSVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270785AbUJUSRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:17:19 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:35340 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268987AbUJUSOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:14:30 -0400
Message-ID: <4177FF47.5040005@techsource.com>
Date: Thu, 21 Oct 2004 14:26:15 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: John Ripley <jripley@rioaudio.com>
CC: "'Greg Buchholz'" <linux@sleepingsquirrel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <82D5E38355314D46AF3015FF55F6955802F83515@CORPMAIL3>
In-Reply-To: <82D5E38355314D46AF3015FF55F6955802F83515@CORPMAIL3>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Ripley wrote:

> 
> It would also really reduce the cost and effort involved in producing the
> card. It wouldn't take much (heh) to get it up and running as a simple frame
> buffer + blitter, but it could be scaled to do fancy multi-texture ops over
> time - all just by reprogramming the FPGA. All the manufacturer needs to
> provide is a "getting started" FPGA file and output to a video DAC. The
> community would do the rest over time.
> 
> I think "Open" hardware is one thing, but open *and* completely
> reprogrammable is a far greater hook, at least for me. I'd be prepared to
> shell out a few $100 for something as hackable as that. Hey, it's an FPGA on
> a PCI Express card at the end of the day, what can't you do with it!
> 


Ok, I'll bite.  What you're suggesting is that instead of developing 
just a graphics card, I should develop a card populated with a bunch of 
FPGA's that's reprogrammable.  Putting aside the logic design tool issue 
(which may be difficult), what you'd get is a very expensive 
reprogrammable card with some RAM and some video output hardware.

How much would you pay for THIS card?  $2000?

Now, the thing is, this card is SO generic that Tech Source would have 
very little value-add.  Say we populate it with a bunch of Spartan 3 
400's... well, you'd download Xilinx's WebPack, code up your design in 
Verilog (Do you want to learn chip design???  It's not like programming 
in C!!!), and then use our open source utility to upload your code.

GREAT... until some other company comes along and clones it, which would 
be WAY too easy to do.  Now, for the users of this sort of product, it's 
a fine thing.  But it becomes a pointless investment for Tech Source, 
which is where I work and who pays me to work on this stuff, which they 
wouldn't do if it's not worth it.


