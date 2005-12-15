Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVLOPZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVLOPZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 10:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVLOPZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 10:25:24 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:53375 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750763AbVLOPZY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 10:25:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jxdaWAZz60AxU0baQF0HM3iUgm2TQX6LDAoQutinNi8kkggq72oUB8+zN+SFFT53cVazvfHfB2yhTWE2jnBCbfiUfLL9n+Nmb7Mk9avjYVd/YH2VGqY+2v4tTjNmhzPSAi3+ImllJBVh8qTC74qSxUeXlLMtG0ceALDWxzRB22U=
Message-ID: <9871ee5f0512150725u53e5f373nf715539886fcae09@mail.gmail.com>
Date: Thu, 15 Dec 2005 10:25:23 -0500
From: Timothy Miller <theosib@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Binary drivers, Open Graphics Project
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Open Graphics Project was mentioned in LKML, and an observer on
your list suggested that I comment.  Please forgive me if what I say
is out of date or redundant.  Also, I'm not subscribed, so please CC
me on anything you want me to see.

Having been faced with Linux hardware-support challenges many times
myself, I've certainly thought of circumstances where allowing binary
drivers would be a good short-term solution, but I believe condoning
that is a slippery slope that will make our situation worse.  I'm not
the kind of purist that believes all proprietary software is evil, but
Linux is great in large part because it's open source (and stays that
way because it's free software).

I thought about mentioning stable ABI's, but it's been discussed to
death, and most people seem to realize it's a bad idea.  The moment we
give old-school hardware vendors that opening is the moment we lose a
lot of ground in our progress towards ubiquitous free
software.  It is this open source requirement for Linux that has
spawned so much innovation and sharing of ideas and is the only reason
why you can use so many x86-specific peripherals on a PowerPC
platforms.

As for other graphics vendors like ATI and nVidia, I honestly don't
fault them for their business models.  To them, it's far more
profitable to sell to Windows users, and Linux users are in such small
number by comparison that it likely costs them more to support us than
they make from selling us cards.

So why don't ATI and nVidia just release specs so WE can write drivers
for them?  Because their drivers are a significant part of their
competitive advantage.  As a hardware designer, I always strive to
strike the best balance between software and hardware.  Hardware costs
a lot of money to make, so when you can do something in software
instead without it being a burden on the system, that's what you
should do.  For ATI and nVidia, exposing their register interfaces
would expose too much about the internal workings of their designs,
thereby giving away too much information to each other and other
competitors.  It is the capitalist thing to do to compete in whatever
way makes the most sense.  ATI and nVidia compete not just on what
their chips do but also HOW their chips do it; letting those secrets
out would be letting go of a major competitive advantage.

With the help of the Open Graphics Project community, I and two
colleagues of mine have set out to develop open architecture graphics
hardware that can be used with just about any OS and just about any
architecture.  We are the hardware vendor for the Open Graphics
Project and we call ourselves Traversal Technology.  We have developed
a business model that we believe will allow us to do this.

For Traversal Technology, the Open Graphics Project is an interesting
risk.  To some extent, we can afford to do this, because we are small
and have integrated ourselves into the community to a huge degree.  We
stand as a niche player, and based on that, we create a reasonable
business model.  What will sell our products is the fact that they are
open architecture.  Although the near-term business goals of ATI and
nVidia make sense, the future goes beyond just open source.  It isn't
enough to just release source to your drivers.  Other developers need
to be able to understand them and add support for features in your
hardware that you didn't.  And they need to be able to use your
hardware in ways that you didn't anticipate.  (I think that part's the
most fun!)  Although I don't expect hardware vendors in the future to
release the internals of their hardware, as Traversal intends to do, I
do believe we'll reach a point where every piece of hardware we use
has published specs with sufficient detail that we can write good
drivers for them.  That's the direction we need to be headed.  Let's
not delay that inevitable outcome by giving hardware vendors an excuse
to slide back into the old ways of doing things.

Someone pointed out to me that there was a subthread on LKML
pertaining to OGP's ability to compete with ATI and nVidia.  It has
never been our goal to compete with them on raw speed.  We're not
targeting gamers.  This is not what "Joe Sixpack" wants, mostly
because Joe Sixpack doesn't know very much about graphics cards.  This
card is intended for desktop and workstation users and to accelerate
the kinds of things that will be seen on Linux desktops in the near
future.  (We may be the first graphics vendor to fully support EXA.) 
We are not going to compete with other companies on raw 3D performance
because we do not have the manpower or money to do it.  Instead, we
are carving out a niche in the graphics market for users who demand
that their OS of choice works trouble-free with all of their hardware,
which for us means open specifications and OSS drivers with full
support for all features available.  Our goal is to produce one of the
few graphics cards on the market that you can plug into a Linux
workstation and have it "just work," with no broken drivers to hassle
with.

If freedom is what you're all about, if you want to see the slippery
slope tilt in favor of Free Software, then you'll stop trying to give
exceptions to those who won't or can't play by our rules.  Start
giving your support to those who do and will support Free Software in
the full spirit of Free Software and the community of cooperation,
sharing, and creativity that so many have worked so hard to create.
