Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbTIXCEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 22:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTIXCEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 22:04:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29848
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261291AbTIXCD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 22:03:59 -0400
Date: Wed, 24 Sep 2003 04:04:09 +0200
From: andrea@kernel.org
To: Larry McVoy <lm@work.bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924020409.GL16314@velociraptor.random>
References: <20030923221528.GP1269@velociraptor.random> <Pine.LNX.4.44.0309231524160.24527-100000@home.osdl.org> <20030924003652.GI16314@velociraptor.random> <20030924011951.GA5615@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924011951.GA5615@work.bitmover.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 06:19:51PM -0700, Larry McVoy wrote:
> On Wed, Sep 24, 2003 at 02:36:52AM +0200, Andrea Arcangeli wrote:
> > You're right I should provide new code, and avoid comments on the a bit
> > inferior info in bkcvs (that Larry nicely offered to even improve after
> > cvs gets properly fixed), but I had no real interest in this area todate
> > and my job keeps most of my time full already and that's higher
> > priority.
> 
> The problem I have is as follows:
> 
> a) I understand your point of view and from the very first version of BK 
>    we released we addressed it.  100% of the data and the metadata is 
>    available from the command line with BK.  Always has been and always 
>    will be, if that's not true that is is a bug and we'll fix it.  People
>    use BK because they like it, not because we locked them in.
> 
> b) I understand your need to not be dependent on BitMover or BitKeeper. 
>    That's why we built the CVS gateway, so you wouldn't need to depend
>    on us, the data you care about is available in a form that doesn't
>    require any license agreements.
> 
> What the above two points demonstrate, dramatically so, is that we
> understand your concerns and agree with them.  We have spent a lot of
> time and money to make sure that you are happy.  Not whining, not 
> flaming, we were writing code to make you happy.  We were writing that
> code long before you ever heard of BitKeeper and we have the revision
> history to prove it.

I defininitely agree with that and I appreciate that you acknowledge my
requests when the bkcvs didn't exist.

(I was also using cvs for kernel development way before I ever heard of
bitkeeper too, then I had to giveup because it was too slow to handle
branches)

> What we expected in return was the same understanding.

that is not accurate, you also asked us to giveup the freedom of
development in your area. And I wouldn't be too interested in a closed
software anyways but at least I could consider using it in the meantime
without feeling tainted.

NOTE: I'm not asking you to remove that clause, nor I'm complaining
about it, I would feel bad for you if you had problems because you
removed that clause. I perfectly understand why you put that clause in
and it makes sense to me.

> Andrea, you need to grow up and learn that biting the hand that is held

It's because I grow up that I can actually better understand the deals
it's in my own (again speaking only for myself and not for anybody else)
interest to avoid.

(changing email address as well to make it clear I'm speaking only for
myself here)

Last but not the least, if I was required to use bitkeeper as part of my
job, then I would use it and I'd giveup that bit of freedom, but as far
as I'm free to choose, I will avoid it. But that's my own choice, it has
nothing to do with anybody else.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
