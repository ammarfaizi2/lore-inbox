Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267617AbTBFUOq>; Thu, 6 Feb 2003 15:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbTBFUOq>; Thu, 6 Feb 2003 15:14:46 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11022 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267617AbTBFUOn>; Thu, 6 Feb 2003 15:14:43 -0500
Date: Thu, 6 Feb 2003 15:21:12 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HYPERTHREADING on older P4???
In-Reply-To: <200302051743.SAA11495@kim.it.uu.se>
Message-ID: <Pine.LNX.3.96.1030206151308.10754C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003, Dave Jones wrote:

> It means there is one 'thread'. Ergo, you do not have the possibility
> of running this as you would a true HT P4.  There are a limited number
> of Northwood P4's out there which do support HT and have >1 sibling,
> but asides from those, you'll need a Xeon to take advantage of it.

The 3.06G parts are pretty available, but the prices are just getting
silly. I suppose it will drop when the supply of parts exceeds the
demand of people who can't wait.

> There are countless rumours of being able to enable extra siblings
> by poking MSRs, but not one person has to my knowledge achieved this.
> Some folks have also allegedly found that snipping pins or wiring extra
> bits to them have enabled the 'extra sibling'. Whether this is true or
> not, and whether it is 100% equivalent to a real HT part is again,
> questionable.

There is one "fix" going around which supposedly works using the
firmware upgrade capability. I have no idea if it does or even could
work, I never had the guts to try it, because I'm not sure that changes
really go away on power cycle, and I didn't get it from a trusted
source. The idea of untrusted code running in the firmware is scarier
than booting Windows.



On Wed, 5 Feb 2003, Mikael Pettersson wrote:

> HT-capable P4s decide at RESET (or INIT?) time whether to enable
> the second thread or not by sampling one of the data or address pins.
> The chipset is supposed to drive that pin low or high according to
> how HT has been set up in the BIOS. This is mentioned in the
> 3.06 GHz P4 data sheet.

This is my understanding, and it makes the idea of a firmware fix sound
more possible, by just enabling the 2nd sibling if HT capability exists.
I'll still let wonone else check it out first...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

