Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132740AbRBRLJg>; Sun, 18 Feb 2001 06:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132757AbRBRLJR>; Sun, 18 Feb 2001 06:09:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15626 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132740AbRBRLJM>;
	Sun, 18 Feb 2001 06:09:12 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102180927.f1I9R8o15804@flint.arm.linux.org.uk>
Subject: Re: [LONG RANT] Re: Linux stifles innovation...
To: hps@intermeta.de
Date: Sun, 18 Feb 2001 09:27:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010217201539.B13970@forge.intermeta.de> from "Henning P . Schmiedehausen" at Feb 17, 2001 08:15:39 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Please don't reply directly to me, either via CC: or To:.
*** I'll pick up any replies via linux-kernel.  Thanks.

Henning P . Schmiedehausen writes:
> Maybe not. But you can use this print engine API to pay anyone to
> write a driver for you. What you just said, is exactly my point. You
> said:
> 
> "If a company does not write a driver which works on all hardware
>  platforms in all cases and gives us the source, then it is better,
>  that the company writes no drivers at all."

That is not what I said.  I said the opposite - "If I company writes a
closed source driver, it will be x86 specific and will ignore the rest
of the Linux community.  However, that company is free to write such
a driver; I won't stop them because I can't stop them."

> "If I can't force a company to write a driver for everyone, then I
>  don't want to write them any driver at all."

Please restate - this sentence does not make sense at all.  No one is
forcing anyone to write drivers.

> IMHO you're like a spoiled kid: "If I can't have it, noone should have it".

Please, don't decend into flame wars.

> If you need a printer driver for the ARM, you're able to approach the
> company XXX and either pay for an ARM specific driver (and they will
> listen to you because they already have made a driver for another
> Linux platform, learned that they can make money with Linux software
> and have experience with driver(s) for Linux. And it will be just a
> recompile most of the time).

Oh, and how many users can afford to pay $10000s for a company to develop
such a driver?  Yes, the driver will cost lots of money because the
company has to put effort into it, and they believe that they won't
see a reasonable return on it.  Also, since the company has its name
to think about, it will want to test it to some degree (I'll mention
here that some drivers seem on MS Windows seem to be untested), which
again adds to the cost.  What you end up with is a price structure
such as:

1. Cost of driver for x86 platform for device x = $50
2. Cost of driver for other platforms for same device x = $10000

Now, can you see an individual person finding $10000 to pay some company
to get the driver?  If you try to, then you're stark raving mad, and
they'll tell you to go away.

Getting closed source software ported by companies is an extremely
expensive business which no user can afford.

There are things that I would really like to say about closed source
software at this point, which will come as no surprise to anyone, but
unfortunately I would get sued to buggery for doing so.  Note however
that they don't relate to the "open source" argument, but to personal
experience of a sector of the software industry.

> We're talking about a driver. If Company XX won't sell it to you for
> your architecture, it's their right to do so. There is software that
> I've written that you might want to have, too. If I chose not to sell
> it to you, what do you do? You can say "company XX sucks" and buy an
> equal product with an ARM driver from YY which listens to you. _THAT_
> is IMHO open. Not forcing everyone to comply with your ideology.

I'm sorry, I think you misinterpreted what I said.  First point - agreed.
Second point - if you choose not to sell it to me, and I have your
hardware product, I will attempt to find out how to make this hardware
product work on ARM, and open source the driver that I come up with.
If I do not have your hardware product, and there are alternatives that
do have usable drivers, then I'll buy theirs instead.

Once the open source driver is out there, then it is a fact of human
nature that people will go for the open source driver.  If the open
source driver is crap, then they have a few choices:

1. berate me and my driver, just like people berate companies
2. improve on the open source driver to make it better
3. buy your driver because its soo much better

Note that at no point have I forced you to write open source drivers here.

> Can you get a Legato Networker Client for Linux-ARM? Can you get one for
> Linux-MIPS? Why? Because someone payed for the port.

Not AFAIK.

> Because IMHO some companies shy away from the aggressive and sometime
> openly hostile behaviour of the Open Source community ("If you don't
> support your application on Linux/SPARC with an B/W framebuffer, you
> suck. Go away") towards commercial companies.  ("If you don't support
> Gnome 1.0 but just KDE 2.1, you suck. Go away"). And billg laughs and
> just points the confused companies towards the "stable" and "easy to
> use" M$ OS.

I'm sorry, I've never approached a company, not even Netscape and said
"you don't support ARM, you suck, go away".  About the only question
that would get asked is "Can you supply a port to ARM", and the answer
will be either "what's ARM?" or "No".  There won't even be a price tag
fixed on it.

> In your opinion, it is better, that I can't get some programs at all
> than paying money for them.

What you're saying here isn't clear.  Can you please restate this bit?

> So tolerate the fact that some companies chose to release a program as
> closed source for only one Linux platform. It is better than not
> releasing at all.

And then we'll be dead in the water.  Thanks, but no thanks.

One of the major points that you're missing is that the people who start
open source projects do not start out with the idea that all commercial
companies have to be flattened and pulverised until they give in.  They
start the project because they think it is a good idea, and they think
that they can do a better job at it.  It is their choice to do that.

After a while, if a company comes along and attempts to get support for
a version of the project that is one, or even two years old, the response
will be "Please upgrade to the latest version".  That is very reasonable,
and even people like M$ will give you that response, so long as you've
paid their support costs.

That response is certainly my response for questions about Linux kernel
2.4.0-test1.  Why?

1. I can't remember, and I don't keep a log of the problems with
   2.4.0-test1.  2.4.0-test1 is a version I choose not to support because
   it is not an officially released stable version.
2. We've fix a lot of problems that were in 2.4.0-test1, and chances are
   that the problem is already fixed.
3. The company is not offering any money for 2.4.0-test1 to be supported.

Now, I'd suggest that if companies that wanted support for old versions
of open-source software were to offer money to the people they were trying
to get support from, the response would not be your suggested "you suck,
go away" but "we'd be pleased to help you.  We'll look into your problem."

Anyway, this is a more or less pointless discussion.  You've got your
ideas and ideals set in your mind, I've got mine.

Thank you for sharing your mind with us.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

