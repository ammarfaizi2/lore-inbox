Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273668AbRIURXG>; Fri, 21 Sep 2001 13:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273887AbRIURW5>; Fri, 21 Sep 2001 13:22:57 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:7696 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S273668AbRIURWl>; Fri, 21 Sep 2001 13:22:41 -0400
Date: Fri, 21 Sep 2001 13:22:20 -0400
Message-Id: <200109211722.f8LHMKI04360@deathstar.prodigy.com>
To: goemon@anime.net
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
X-Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.30.0109191249130.26700-100000@anime.net>
Organization: TMR Associates, Schenectady NY
Cc: linux-kernel@vger.kernel.org
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0109191249130.26700-100000@anime.net> you write:
| On Wed, 19 Sep 2001, Arjan van de Ven wrote:
| > If it were only 5%, I would vote for disabling the optimisation given the
| > number of problems; however it's 2x _and_ you can trigger the bug as normal
| > user from userspace too... so we need to fix the hardware/bios.
| 
| But we really dont know what the hell that bit is doing. It might trigger
| some other obscure bugs and make things a real mess.
| 
| Until we get some answer from VIA its IMHO a bad idea to start twiddling
| this bit willy-nilly on all machines.

We know one thing it's doing, keeping user programs from causing errors.
If the error didn't occur in user mode I would be more careful, but
having been shown that it does, I will use the fix. Since the older BIOS
versions set it the other way, I'm willing to assume it's safe and move
forward.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
