Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131093AbQKUWUw>; Tue, 21 Nov 2000 17:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131465AbQKUWUn>; Tue, 21 Nov 2000 17:20:43 -0500
Received: from rogue.dsndata.com ([198.183.6.123]:46340 "EHLO
	rogue.dsndata.com") by vger.kernel.org with ESMTP
	id <S131093AbQKUWU2>; Tue, 21 Nov 2000 17:20:28 -0500
Date: Tue, 21 Nov 2000 15:50:27 -0600
From: Jeff Epler <jepler@inetnebr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux
Message-ID: <20001121155027.I7090@inetnebr.com>
Mail-Followup-To: Jeff Epler <jepler@inetnebr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200011202032.eAKKWQi06469@pincoya.inf.utfsm.cl> <3A1AE442.E8C83873@the-rileys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.7i
In-Reply-To: <3A1AE442.E8C83873@the-rileys.net>; from oscar@the-rileys.net on Tue, Nov 21, 2000 at 04:08:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 04:08:26PM -0500, David Riley wrote:
> Windoze is not the only OS to handle bad hardware better than Linux.  On
> my Mac, I had a bad DIMM that worked fine on the MacOS side, but kept
> causing random bus-type errors in Linux.  Same as when I accidentally
> (long story) overclocked the bus on the CPU.  I think that more
> tolerance for faulty hardware (more than just poorly programmed BIOS or
> chipsets with known bugs) is something that might be worth looking into.

And how do you propose to do that?

For instance, in some other operating systems having the top bit flip
in a pointer will cause silent use of incorrect data.  On Linux, this
will cause a signal 11.  Which do you prefer, bad results or an error
message?

Can you suggest a specific way in which Linux can react correctly to
e.g. flipped bits in RAM or cache which cannot be detected at the hardware
level?  Or maybe tell me how Linux can react correctly when an overclocked
CPU starts producing incorrect results for right shifts once every few
thousand instructions?

There exists hardware specifically intended to be able to diagnose and
contain its own failures, but the number of such features on a common
home PC is probably a big fat zero.

>  I'm sure it would solve problems like this (which I clearly identify as
> a hardware problem, because the same thing happened with the bad DIMM,
> the overclocked bus, and two different overclocked processors (AMD 5x86
> and AMD K6-2 500) and went away when I remedied the offending problem). 

And that's what you have to do --- fix the problem.  In a few situations,
you might be able to isolate and exclude the section of RAM which is
bad (in fact, there are patches for this and tools to diagnose the
problem), but what do you want Linux to do about a processor which cannot
reliably execute instructions?

> Additionally, overclockers (I myself am a reformed one) might appreciate
> more tolerance for such things.

I've got a better idea:  Overclockers can go to hell, and their bug reports
to the trash, until they "reform" like you and I have.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
