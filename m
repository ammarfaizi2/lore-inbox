Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287254AbRL2Xds>; Sat, 29 Dec 2001 18:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287243AbRL2Xdj>; Sat, 29 Dec 2001 18:33:39 -0500
Received: from ns.suse.de ([213.95.15.193]:62221 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287245AbRL2Xda>;
	Sat, 29 Dec 2001 18:33:30 -0500
Date: Sun, 30 Dec 2001 00:33:29 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Larry McVoy <lm@bitmover.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
        Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011229151440.A21760@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0112300027400.1336-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Larry McVoy wrote:

> So that means that pretty much 100% of development to any one area is being
> done by one person?!?   That's cool, but doesn't it limit the speed at which
> forward progress can be made?

The closest approximation my minds-eye can make of how things work
look something like this..

h h h h h
\ | | | /
 m  m m
  \ |/
  ttt
   |
   l

h - random j hacker working on same file/subsystem different goals
m - maintainer for file/subsys
t - "forked" tree maintainer (-ac, -dj, -aa etc..)
l - Linus

Whilst development happens concurrently in parallel, the notion of
progress is somewhat serialised as changes work their way down to
Linus.

(This whole thing goes a little astray when random j hacker sends
 patches straight to Linus bypassing everyone else and they get
 merged, but the controlled anarchy prevails and everyone somehow
 gets back in sync).

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

