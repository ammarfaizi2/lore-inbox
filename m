Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282912AbRLBRcv>; Sun, 2 Dec 2001 12:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRLBRco>; Sun, 2 Dec 2001 12:32:44 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:20242 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S283520AbRLBRc1>;
	Sun, 2 Dec 2001 12:32:27 -0500
Date: Sun, 2 Dec 2001 15:32:14 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Victor Yodaiken <yodaiken@fsmlabs.com>,
        Andrew Morton <akpm@zip.com.au>, Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <Pine.LNX.4.33.0112021910480.18232-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0112021528300.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, Ingo Molnar wrote:

> This whole effort called Linux might look structured on the micro-level
> (this world *does* appear to have some rules apart of chaos), but it
> simply *cannot* be anything better than random on the macro (longterm)
> level. So we better admit this to ourselves and adapt to it.

Note that this screams for some minimal kind of modularity
on the source level, trying to limit the "magic" to as small
a portion of the code base as possible.

Also, natural selection tends to favour the best return/effort
ratio, not the best end result. Letting a kernel take shape
due to natural selection pressure could well result in a system
which is relatively simple, works well for 95% of the population,
has the old cruft level at the upper limit of what's deemed
acceptable and completely breaks for the last 5% of the population.

That is, unless we give those last 5% of the population baseball
bats and Linus his house address, in which case there is some
biological pressure to merge the fixes needed for those folks ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

