Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291235AbSBLXAF>; Tue, 12 Feb 2002 18:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291236AbSBLW74>; Tue, 12 Feb 2002 17:59:56 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:50189 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291235AbSBLW7n>;
	Tue, 12 Feb 2002 17:59:43 -0500
Date: Tue, 12 Feb 2002 20:59:34 -0200 (BRST)
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
In-Reply-To: <20020130092529.O23269@work.bitmover.com>
Message-ID: <Pine.LNX.4.33L.0202122058150.12554-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Larry McVoy wrote:

> and then you added one change below that, multiple times.  If you were to
> combine all of those changes in a BK tree, it would look like
>
> 			[older changes]
> 			      v
> 			  [2.5.3-pre4]
> 			      v
> 			  [2.5.3-pre5]
>   [sched1] [sched2] [sched3] [sched4] [sched5] [sched6] [sched7]

I'm porting rmap to 2.5 now, doing just this.

One thing I noticed was that the space usage of all the
bk trees I'm using in order to keep the different changes
individually pullable is about 1.5 GB now.

Not too big an issue for me, but it might be an issue if
every bkbits.net user starts doing this ... ;)

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

