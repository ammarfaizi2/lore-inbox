Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291057AbSAaNBH>; Thu, 31 Jan 2002 08:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291058AbSAaNA5>; Thu, 31 Jan 2002 08:00:57 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:58386 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291057AbSAaNAm>;
	Thu, 31 Jan 2002 08:00:42 -0500
Date: Thu, 31 Jan 2002 11:00:24 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>, Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201301513040.14950-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0201311058290.32634-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Linus Torvalds wrote:
> On Wed, 30 Jan 2002, Larry McVoy wrote:
> >
> > And you just lost some useful information.
>
> No. If the useless crap ends up hiding the real points in the revision
> history, getting rid of crud is _good_.

Actually, allowing the deep merges to go past tags could
be useful for dragging bugfixes between the 2.4 and 2.5
kernels ...

... but I think the 'dragging' analogy is something we'll
want to keep here, not back merging across tags by default
but _trying_ to do the backmerge on demand only, when the
user wants to drag a changeset from 2.4 to 2.5.

We could just have a revtool-like interface for that.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

