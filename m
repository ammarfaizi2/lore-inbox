Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290541AbSARAAT>; Thu, 17 Jan 2002 19:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290543AbSARAAJ>; Thu, 17 Jan 2002 19:00:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:8717 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290541AbSAQX77>; Thu, 17 Jan 2002 18:59:59 -0500
Date: Thu, 17 Jan 2002 18:59:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] rmap VM 11c
In-Reply-To: <Pine.LNX.4.33L.0201171721230.32617-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.3.96.1020117185411.4089A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Rik van Riel wrote:

> For this release, IO tests are very much welcome ...
> 
> 
> The third maintenance release of the 11th version of the reverse
> mapping based VM is now available.
> This is an attempt at making a more robust and flexible VM
> subsystem, while cleaning up a lot of code at the same time.
> The patch is available from:
> 
>            http://surriel.com/patches/2.4/2.4.17-rmap-11c
> and        http://linuxvm.bkbits.net/

Rik, I tried a simple test, building a kernel in a 128M P-II-400, and when
the load average got up to 50 or so the system became slow;-) On the other
hand it was still usable for most normal things other then incoming mail
which properly blocks at LA>10 or so.

I'll be trying it on a large machine tomorrow, but it at least looks
stable. In real life no sane person would do that, would they? Make with a
nice -10 was essentially invisible.

Maybe tomorrow the lateest -aa kernel on the same machine, with and
without my own personal patch.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

