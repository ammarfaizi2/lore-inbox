Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290753AbSA3X7l>; Wed, 30 Jan 2002 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290755AbSA3X7X>; Wed, 30 Jan 2002 18:59:23 -0500
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:59014 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S290753AbSA3X7K>;
	Wed, 30 Jan 2002 18:59:10 -0500
Message-ID: <3C588884.9643C0E@canit.se>
Date: Thu, 31 Jan 2002 00:57:56 +0100
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C586C8D.2C100509@inet.com> <Pine.LNX.4.33.0201301408290.2618-100000@penguin.transmeta.com> <20020130143608.I22323@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

> On Wed, Jan 30, 2002 at 02:17:05PM -0800, Linus Torvalds wrote:
> > The way BK works now, if we call the quick-and-dirty fix "A", and the real
> > fix "B", the developer has a really hard time just sending "B" to me. He'd
> > have to re-clone an earlier BK tree, re-do B in that tree, and then send
> > me the second version.
> >
> > I'm suggesting that he just send me B, and get rid of his tree. There are
> > no dependencies on A, and I do not want _crap_ in my tree just because A
> > was a temporary state for him.
>
> And you just lost some useful information.  The fact that so-and-so did
> fix A and then did B is actually useful.  It tells me that A didn't work
> and B does.  You think it's "crap" and by tossing it dooms all future
> developers to rethink the A->B transition.
>

I think Linus meant that A never got sent out before the developer did the B
version. Now A could be a even bigger bug than what it was intended to fix so the
developer really dont wan't the world to se that sucker but can't just send the B
changeset as it depends on A. So I guess he needs a easy way to make A just go
away. Basically just collaps A and B into the same changeset. This should probably
ony work on changeset that has not been pushed to other trees.



