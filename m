Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267713AbSLSW5z>; Thu, 19 Dec 2002 17:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267715AbSLSW5z>; Thu, 19 Dec 2002 17:57:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18960 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267713AbSLSW5y>; Thu, 19 Dec 2002 17:57:54 -0500
Date: Thu, 19 Dec 2002 18:04:09 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Takashi Iwai <tiwai@suse.de>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA update
In-Reply-To: <s5hof7ius93.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.3.96.1021219175821.29958C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Takashi Iwai wrote:

> At Wed, 18 Dec 2002 22:51:27 +0300 (MSK),
> Ruslan U. Zakirov <cubic@miee.ru> wrote:
> > 
> > Hello, Jaroslav and All.
> > How about other changes in new 2.5 kernel, like new PnP layer (Adam Belay)
> > or changes with module & boot params (Rusty Russel)? There are now some
> > changes in 2.5.52 kernel in sound/isa/opl3sa2.c that make this driver not
> > compatible with other kernels. May be it's better split your tree in
> > several trees for each version of kernels?
> 
> if possible, we'll build up some wrapper for 2.4 on alsa-driver (not
> the codebase for 2.5) tree.  if not possible, yes, splitting to two
> trees would be reasonable for such big changes...
> 
> thanks for noticing this issue.  i'll check them now.

If you really want single source you might use something like m4 to split
out both 2.4 and 2.5 versions which are less cluttered.

I admit this doesn't make your job a bit easier, but people reading the
drivers for one series or the other would have an easier job reading the
code. In a perfect world that would means they would find bugs for you and
just send patches. In reality you wouldn't have people telling you your
code was ugly.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

