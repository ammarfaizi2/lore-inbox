Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261774AbTCGUzq>; Fri, 7 Mar 2003 15:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261777AbTCGUzp>; Fri, 7 Mar 2003 15:55:45 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:19074 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S261774AbTCGUzh>;
	Fri, 7 Mar 2003 15:55:37 -0500
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303072136590.22681-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303072136590.22681-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047071156.29990.5.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Mar 2003 22:05:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 21:39, Ingo Molnar wrote:
> On 7 Mar 2003, Martin Josefsson wrote:
> 
> > Some negative things:
> 
> if you have time/interest, could you re-test the negative things with X
> reniced to -10, to further isolate the problem? Another thing to try is to
> renice xmms to -10 (or RT priority). Which one makes the larger
> difference?

X niced to -10 makes the xmms mouse-jerkyness disappear. but it can
still skip right after a songchange. If I renice xmms to -10 as well I
get the mouse-jerkyness again, it I renice it to -5 it seems to behave
quite well, no mouse-jerkyness and so far I havn't heard any skips, but
it can take some time until a skip occurs.

With X reniced to -10 it feels like the wiggle_a_window while a
'make -j10' and a movie is playing gets a bit more sluggish.

And sawfish still takes 30 second naps when executing a bunch of
aumix's.

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
