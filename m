Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276247AbRJPNvG>; Tue, 16 Oct 2001 09:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRJPNu5>; Tue, 16 Oct 2001 09:50:57 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:58639 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276247AbRJPNuy>; Tue, 16 Oct 2001 09:50:54 -0400
Date: Tue, 16 Oct 2001 09:51:27 -0400
From: Bill Davidsen <davidsen@deathstar.prodigy.com>
Message-Id: <200110161351.f9GDpRd01294@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VM
X-Newsgroups: linux.dev.kernel
In-Reply-To: <9qg46l$378$1@penguin.transmeta.com>
Organization: Prodigy http://www.prodigy.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9qg46l$378$1@penguin.transmeta.com> torvalds@transmeta.com wrote:
>In article <20011015211216.A1314@localhost>,
>Patrick McFarland  <unknown@panax.com> wrote:
>>
>>Why is the simple vm system still in place on the linus tree? I would
>think the smart vm system in the ac tree would be better suited to .. 
>oh..  say ..  everything.
>
>"complex" != "smart".
>
>The benchmarks I've seen says that the simple VM performs better - both
>in terms of repeatability and in terms of absolute performance. Search
>this list yourself if you don't believe me.

  The problem may be one of perception. There has been a lot of effort
to fix large memory cases, and that's good. I have a load of 2-4GB
machines in remote locations with heavy load. I would like dead stable
and good performance, and that may be coming in either case.

  But for busy little machines, uni, small memory, which represent the
majority of desktops, I find the -ac VM seems to be significantly
faster in starting X, or netscape, or changing desktops. I haven't
tried 2.4.12, because I want to be sure to avoid another 2.4.11oh-shit
debacle. But at 2.4.10 the difference was significant, particularly on
small machines with slow disk. I'll try 2.4.12 Thursday unless major
bugs pop up and see how that does, 2.4.10-ac12 has been stable and
responsive, and I'm out of the office tomorrow and can't reboot if I
get an oops.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
