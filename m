Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288020AbSAHSGC>; Tue, 8 Jan 2002 13:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288197AbSAHSFn>; Tue, 8 Jan 2002 13:05:43 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:10248 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288020AbSAHSFk>;
	Tue, 8 Jan 2002 13:05:40 -0500
Date: Tue, 8 Jan 2002 16:05:21 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: george anzinger <george@mvista.com>
Cc: Nathan <wfilardo@fuse.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, 2.4.17-B0, 2.5.2-pre8-B0.
In-Reply-To: <3C3B2429.6DFA0EAA@mvista.com>
Message-ID: <Pine.LNX.4.33L.0201081604460.872-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, george anzinger wrote:
> Nathan wrote:
> >
> > Out of sheer curiosity (and this might be a stupid question), is there
> > any effort to make the following lines of development all work together:
> > RML's preempt-kernel and lock-break (and netdev, but that doesn't touch
> > the other stuff), Rick's rmap VM, and the O(1) scheduler?  If so, is it

> No, not in concept.  Just that they collide in a couple of places and
> need a bit of sorting out.  Give us a moment.

I'm adding low latency reschedule points to page_launder_zone()
and refill_inactive_zone() right now ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

