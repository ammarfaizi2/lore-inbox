Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274646AbRITUnR>; Thu, 20 Sep 2001 16:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274642AbRITUnH>; Thu, 20 Sep 2001 16:43:07 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:41273 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S274645AbRITUmz>; Thu, 20 Sep 2001 16:42:55 -0400
Date: Thu, 20 Sep 2001 16:43:19 -0400
Message-Id: <200109202043.f8KKhJ202923@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon/K7-Opimisation problems
X-Newsgroups: linux.dev.kernel
In-Reply-To: <01090915115400.00173@c779218-a>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01090915115400.00173@c779218-a> you write:
| On Sunday 09 September 2001 10:07 am, Carsten Leonhardt wrote:
| > Hi,
| >
| > here's my data regarding the K7 optimisation problem.
| >
| > Until last week I had a 1GHz Athlon with 133MHz FSB. I then bought a
| > 1.4GHz Athlon, again 133MHz FSB.
| >
| > I never had any problems with the 1GHz processor, but as soon as I
| > stuck the 1.4GHz processor in, the kernel oopsed itself to
| > oblivion. (That was with kernel 2.4.5-ac5, approximately)
| 
| This is common enough it's becoming absurd.

Never had a slower Athlon than 1.4, but I suppose the system could be
underclocked as well;-) However, I have to think there's other stuff
happen, see below.

| >
| > I also noticed that the computer booted ok with the Debian
| > bootfloppies, which use a kernel compiled for i386. So after several
| > kernel compile/boot cycles, I found out that I had to disable K7
| > optimisation to make the system boot again.
| >
| > The mainboard is a Tyan Trinity KT-A (S2390B) with a VIA KT133A
| > chipset.
| >
| > After reading here that it may be the PSU, I upgraded my 300W PSU to a
| > 431W Enermax, which made no difference.
| >
| > The only difference I can make out between the working and the
| > non-working CPU is the internal clockspeed of the CPU and the
| > stepping (old: 2, new: 4).
| 
| Heat anyone? stepping 4 hasn't seemed to be the problem, at least not 
| directly
| What's the tempature difference between your 1Ghz and 1.4Ghz? both CPU 
| and system? What kind of cooling do you have?

In my case, if I compile a 686 kernel it is nice and stable, while an
Athlon kernel is not. With all due respect I bet the temperature is dead
the same regardless of kernel, so I can't blame temperature.

The problem I have is seen only when I use Athlon code enabled with
menuconfig, so the question is if the code is bad (as in timing
sensitive), or if the compiler might be generating bad code for Athlon.

Just a data point, I believe that the problems (at least those which are
bugging me) are releated to something other than temperature.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
