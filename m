Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSLMROn>; Fri, 13 Dec 2002 12:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbSLMROm>; Fri, 13 Dec 2002 12:14:42 -0500
Received: from bitmover.com ([192.132.92.2]:61650 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265196AbSLMROk>;
	Fri, 13 Dec 2002 12:14:40 -0500
Date: Fri, 13 Dec 2002 09:22:29 -0800
From: Larry McVoy <lm@bitmover.com>
To: Donald Becker <becker@scyld.com>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Roger Luethi <rl@hellgate.ch>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Networking/Becker et al [was Re: pci-skeleton duplex check]
Message-ID: <20021213092229.D9973@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Donald Becker <becker@scyld.com>,
	"David S. Miller" <davem@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, Roger Luethi <rl@hellgate.ch>,
	netdev@oss.sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the for what it is worth department...  My brain dump on this situation.

I know Dave Miller, Don Becker, and Jeff Garzik personally, we've spent
time face to face.  These are all good guys, very important guys to the
kernel effort.

I've known Don for a long time and we've had a bunch of talks about why
his style and the Linux style doesn't mesh well.  Here's my view, which
may or may not be shared.

Don is a careful, thoughtful guy.  He is quite conservative when it comes
to programming.  His style most closely matches the Sun kernel style of
development; it does not match the Linux style at all.  The Linux style
is a lot more free wheeling, stuff changes a lot and the kernel team
depends heavily on the fact that it is has this vast army of free testers.
Without that army, I shudder to think what things would be like, I do not
think the current development style would work anywhere near as well.

But it does work, and it violates a lot of engineering disciplines that
old farts, like me and Don, respect.  I've learned to live with it, even
respect the fact that the Linux team does so well.  Don is having a much
tougher time.  He really wants the Linux team to work more like he works
and the Linux team doesn't want to do that at all, they point at their
success and believe that their development style is part of that success.

It is worth putting on the record that Don has done a lot for the Linux
effort, a huge amount, in fact.  Without Don, Linux would be dramatically
less far along than it is.  I've been here since before it had networking
and it really took off when Don started writing drivers.

It's also pointing out that I think he's right about the networking
regressions, suspend/resume on laptops used to work and now the network
is almost always hosed after I do that.

I doubt that either side is likely to change their view.  But, the real
point is how to we get Don's brain engaged on the kernel networking
drivers?  A few thoughts:

    a) Don is going to have to accept that the Linux kernel approach is
       the way it is.  Sitting on the sidelines and whining is not going
       to change how the kernel is developed.  Either get with the 
       program or not, but don't sit there and complain but refuse
       to work the way the rest of the people work.

    b) The kernel folks need to listen to Don more.  Draw him into the
       conversations about interface changes, try and extract the 
       knowledge he has, it's worth it.  Not doing so just means you
       are wasting time.

    c) Don needs to kill those mailing lists he maintains or merge them
       with the appropriate kernel lists.  That is a big part of the
       problem, the interesting stuff seems to be happening over in 
       Don's part of the world and the mainstream kernel team isn't
       aware of it.

    d) Beer.  More beer.  Much more beer and some face time.  If there
       is a tech conference coming up, I think we should get Don to 
       come and give him the first lifetime achievement award for
       Linux kernel development.  Then shove him and the other network
       hackers into a room with a keg and not let them out until they
       are smiling.  BitMover will kick in some money towards this if
       needed.

--lm

On Fri, Dec 13, 2002 at 11:56:17AM -0500, Donald Becker wrote:
> On 13 Dec 2002, David S. Miller wrote:
> > On Thu, 2002-12-12 at 17:18, Donald Becker wrote:
> > > Or perhaps recognizing that when someone that has been a significant,
> > > continuous contributer since the early days of Linux
> > 
> > Until you learn to play nice with people and mesh within the
> > fabric of Linux development, I adamently do not classify you
> > as you appear to self-classify yourself.  You don't contribute,
> > you sit in your sandbox and then point fingers at the people who
> > do know how to work with other human beings and say "see how much
> > that stuff sucks?  well my stuff works, nyah!"
> ..
> > If Linux itself is worse off and went backwards in time for a while...
> 
> The development criteria used to be technically based, and that is still
> the public statement.  Now, as your statement makes clear, working code
> is an irrelevant criteria.
> 
> You comments immediately moved the subject from the technical merit and
> correctness of the code to an ad hominem attack.  The facts, and the
> code, clearly show the long term interaction and contribution.  In most
> cases the code and interfaces we are talking about were written and
> defined by me throughout the past decade.
> 
> 
> 
> -- 
> Donald Becker				becker@scyld.com
> Scyld Computing Corporation		http://www.scyld.com
> 410 Severn Ave. Suite 210		Scyld Beowulf cluster system
> Annapolis MD 21403			410-990-9993
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
