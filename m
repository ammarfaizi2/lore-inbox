Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284077AbRLALmi>; Sat, 1 Dec 2001 06:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284076AbRLALm3>; Sat, 1 Dec 2001 06:42:29 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:3592 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284077AbRLALmP>;
	Sat, 1 Dec 2001 06:42:15 -0500
Date: Sat, 1 Dec 2001 09:41:59 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@zip.com.au>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <20011130181415.C19152@work.bitmover.com>
Message-ID: <Pine.LNX.4.33L.0112010938450.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Larry McVoy wrote:
> On Fri, Nov 30, 2001 at 06:17:43PM -0800, Davide Libenzi wrote:

> > So, if these guys are smart, work hard and are professionals, why did they
> > take bad design decisions ?
> > Why didn't they implemented different solutions like, let's say "multiple
> > independent OSs running on clusters of 4 CPUs" ?
>
> Because, just like the prevailing wisdom in the Linux hackers, they
> thought it would be relatively straightforward to get SMP to work.
> They started at 2, went to 4, etc., etc.  Noone ever asked them to go
> from 1 to 100 in one shot.  It was always incremental.

Incremental stuff always breaks and misses out on the corner
cases. The same seems to be true for stuff coming out of
random mutation and biological selection ... natural selection
really doesn't care about corner cases.

This, for example, has always resulted in a VM subsystem which
works nicely under low load but falls apart under high load.
Any efforts to fix that corner case have been met with nothing
but resistance.

Lets face it, if you want to deal with corner cases you don't
want to deal with Linus.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

