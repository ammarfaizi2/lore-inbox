Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267991AbTBXFGf>; Mon, 24 Feb 2003 00:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268074AbTBXFGf>; Mon, 24 Feb 2003 00:06:35 -0500
Received: from franka.aracnet.com ([216.99.193.44]:30360 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267991AbTBXFGc>; Mon, 24 Feb 2003 00:06:32 -0500
Date: Sun, 23 Feb 2003 21:16:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <48940000.1046063797@[10.10.2.4]>
In-Reply-To: <20030224045616.GB4215@work.bitmover.com>
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmast
 er.ca> <1510000.1045942974@[10.10.2.4]>
 <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]>
 <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]>
 <20030224045616.GB4215@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nonsense.  You were talking about 16/32/64 way boxes, go read your own
> mail. In fact, you said so in this message.

Where? I never mentioned 32 / 64 way boxes, for starters ...
 
> Furthermore, I can prove that isn't what you are talking about.  Show me
> the performance gains you are getting on 4way systems from your changes.
> Last I checked, things scaled pretty nicely on 4 ways.

Depends what you mean by "your changes". If you do a before and after
comparison on a 4x machine on the scalability changes IBM LTC has made, I
think you'd find a dramatic difference. Of course, it depends to some
extent on what tests you run. Maybe running bitkeeper (or whatever you're
testing) just eats cpu, and doesn't do much interprocess communication or
disk IO (compared to the CPU load), in which case it'll scale pretty well
on 
anything as long as it's multithreaded enough. If you're just worried about
one particular app, yes of course you could tweak the system to go faster
for it ... but that's not what a general purpose OS is about.

> Yes, we do.  You just don't like what the numbers are saying.  You can
> work backward from the size of the server market and the percentages
> claimed by Sun, HP, IBM, etc.  If you do that, you'll see that even
> if Dell was making 100% margins on every server they sold, that still
> wouldn't be 51% of their profits.

Ummm ... now go back to what we were actually talking about. Linux margins. 
You think a significant percentage of the desktops they sell run Linux?

>> > To refresh
>> > your memory: "I bet they still make more money on servers than desktops
>> > and notebooks combined".  Are you still claiming that?  
>> 
>> Yup.
> 
> Well, you are flat out 100% wrong.

In the context we were talking about (Linux), I seriously doubt it.
Apologies if I didn't feel the need to continously restate the context in
every email to stop you from trying to twist the argument.

> Ahh, now we're getting somewhere.  As soon as we get anywhere near real
> numbers, you don't want anything to do with it.  Why is that?

Because I don't see why I should waste my time running benchmarks just to
prove you wrong. I don't respect you that much, and it seems the
maintainers don't either. When you become somebody with the stature in the
Linux community of, say, Linus or Andrew I'd be prepared to spend a lot
more time running benchmarks on any concerns you might have.

>> I don't have to *prove* you wrong. I'm happy in my own personal knowledge
>> that you're wrong, and things seem to be going along just fine, thanks.
> 
> Wow.  Compelling.  "It is so because I say it is so".  Jeez, forgive me 
> if I'm not falling all over myself to have that sort of engineering being
> the basis for scaling work.

Ummm ... and your argument is different because of what? You've run some
tiny little microfocused benchmark, seen a couple of bus cycles, and
projected the results out? Not very impressive, really, is it? Go run a
real benchmark and prove it makes a difference if you want to sway people's
opinions. Until then, I suspect the  current status quo will continue in
terms of us getting patches accepted.

M.


