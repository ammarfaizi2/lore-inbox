Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTBXH3c>; Mon, 24 Feb 2003 02:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTBXH3c>; Mon, 24 Feb 2003 02:29:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48082 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261364AbTBXH3a>; Mon, 24 Feb 2003 02:29:30 -0500
Date: Sun, 23 Feb 2003 23:39:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <1630000.1046072374@[10.10.2.4]>
In-Reply-To: <20030224065826.GA5665@work.bitmover.com>
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmast
 er.ca> <1510000.1045942974@[10.10.2.4]>
 <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]>
 <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]>
 <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]>
 <20030224065826.GA5665@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ummm ... now go back to what we were actually talking about. Linux
>> margins.  You think a significant percentage of the desktops they sell
>> run Linux?
> 
> The real discussion was the justification for scaling work beyond the
> small SMPs.  You tried to make the point that there is no money in PC's so
> any work to scale Linux up would help hardware companies stay financially
> healthy.

More or less, yes.

> The point being that there is a company generating $32B/year in sales and
> almost all of that is in uniprocessors.  Directly countering your
> statement that there is no margin in PC's.  They are making $2B/year in
> profits, QED.

Which is totally irrelevant. It's the *LINUX* market that matters. What
part of that do you find so hard to understand? 
 
> Which brings us back to the point.  If the world is not heading towards
> an 8 way on every desk then it is really questionable to make a lot of
> changes to the kernel to make it work really well on 8-ways.  Yeah, I'm
> sure it makes you feel good, but it's more of a intellectual exercise than
> anything which really benefits the vast majority of the kernel user base.

It makes IBM money, ergo they pay me. I enjoy doing it, ergo I work for
them. Most of the work benefits smaller systems as well, ergo we get our
patches accepted. So everyone's happy, apart from you, who keeps whining.
 
>> Because I don't see why I should waste my time running benchmarks just to
>> prove you wrong. I don't respect you that much, and it seems the
>> maintainers don't either. When you become somebody with the stature in
>> the Linux community of, say, Linus or Andrew I'd be prepared to spend a
>> lot more time running benchmarks on any concerns you might have.
> 
> Who cares if you respect me, what does that have to do with proper
> engineering?   Do you think that I'm the only person who wants to see
> numbers?  You think Linus doesn't care about this?  Maybe you missed
> the whole IA32 vs IA64 instruction cache thread.  It sure sounded like
> he cares.  How about Alan?  He stepped up and pointed out that less
> is more.  How about Mark?  He knows a thing or two about the topic?
> In fact, I think you'd be hard pressed to find anyone who wouldn't be
> interested in seeing the cache effects of a patch.

So now we've slid from talking about bus traffic from fine-grained locking,
which is mostly just you whining in ignorance of the big picture, to cache
effects, which are obviously important. Nice try at twisting the
conversation. Again.

> People care about performance, both scaling up and scaling down.  A lot of
> performance changes are measured poorly, in a way that makes the changes
> look good but doesn't expose the hidden costs of the change.  What I'm
> saying is that those sorts of measurements screwed over performance in
> the past, why are you trying to repeat old mistakes?

One way to measure those changes poorly would be to do what you were
advocating earlier - look at one tiny metric of a microbenchmark, rather
than the actual throughput of the machine. So pardon me if I take your
concerns, and file them in the appropriate place.
 
> My argument is different because every effort which has gone in the
> direction you are going has ended up with a kernel that worked well on
> big boxes and sucked rocks on little boxes.  And all of them started
> with kernels which performed quite nicely on uniprocessors.

So you're trying to say that fine-grained locking ruins uniprocessor
performance now? Or did you have some other change in mind?

> If I was waving my hands and saying "I'm an old fart and I think this
> won't work" and that was it, you'd have every right to tell me to piss
> off.  I'd tell me to piss off.  But that's not what is going on here.
> What's going on is that a pile of smart people have tried over and over
> to do what you claim you will do and they all failed.  They all ended up
> with kernels that gave up lots of uniprocessor performance and justified
> it by throwing more processors at that problem.  You haven't said a 
> single thing to refute that and when challenged to measure the parts
> which lead to those results you respond with "nah, nah, I don't respect
> you so I don't have to measure it".  Come on, *you* should want to know
> if what I'm saying is true.  You're an engineer, not a marketing drone,
> of course you should want to know, why wouldn't you?

You just don't get it, do you? Your head is so vastly inflated that you
think everyone should run around researching whatever *you* happen to think
is interesting. Do your own benchmarking if you think it's a problem.
You're the one whining about this.
 
> Linux is a really fast system right now.  The code paths are short and
> it is possible to use the OS almost as if it were a library, the cost is
> so little that you really can mmap stuff in as you need, something that
> people have wanted since Multics.  There will always be many more uses
> of Linux in small systems than large, simply because there will always
> be more small systems.  Keeping Linux working well on small systems is
> going to have a dramatically larger positive benefit for the world than
> scaling it to 64 processors.  So who do you want to help?  An elite
> few or everyone?

Everyone. And we can do that, and make large systems work at the same time.
Despite the fact you don't believe me. And despite the fact that you can't
grasp the difference between the number 16 and the number 64.

M.
