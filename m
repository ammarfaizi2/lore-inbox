Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290185AbSA3RCi>; Wed, 30 Jan 2002 12:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290102AbSA3RBZ>; Wed, 30 Jan 2002 12:01:25 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:63753 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290103AbSA3RAA>;
	Wed, 30 Jan 2002 12:00:00 -0500
Date: Wed, 30 Jan 2002 14:59:32 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Ingo Molnar <mingo@elte.hu>, Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130084331.K23269@work.bitmover.com>
Message-ID: <Pine.LNX.4.33L.0201301452340.11594-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Larry McVoy wrote:
> On Wed, Jan 30, 2002 at 07:35:03PM +0100, Ingo Molnar wrote:
> > On Wed, 30 Jan 2002, Larry McVoy wrote:
> >
> > > How much of the out order stuff goes away if you could send changes
> > > out of order as long as they did not overlap (touch the same files)?
> >
> > could this be made: 'as long as they do not touch the same lines of code,
> > taking 3 lines of context into account'? (ie. unified diff definition of
> > 'collisions' context.)
>
> No.  What you described is diff/patch.  We have that already and if it
> really worked in all the cases there would be no need for BitKeeper to
> exist.  I'll be the first to admit that BK is too pedantic about
> change ordering and atomicity, but you need to see that there is a
> spectrum and if we slid BK over to what you described it would be a
> meaningless tool,

OK, so why not put the boundary at the same point as where
bitkeeper still manages to automatically merge branches and
where it gives up ?

(this seems to be somewhat finer grained than the whole-file
level, but more picky and intelligent than patch/diff)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

