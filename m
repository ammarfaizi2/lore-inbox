Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUJCLqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUJCLqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 07:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUJCLqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 07:46:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:48145 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S267807AbUJCLqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 07:46:21 -0400
Date: Sun, 3 Oct 2004 13:46:02 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Jeff V. Merkey" <jmerkey@drdos.com>, jonathan@jonmasters.org,
       "jmerkey@comcast.net" <jmerkey@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible GPL Violation of Linux in Amstrad's E3 Videophone
Message-ID: <20041003114602.GA19761@alpha.home.local>
References: <100120041740.9915.415D967600014EC2000026BB2200758942970A059D0A0306@comcast.net> <35fb2e590410011509712b7d1@mail.gmail.com> <415DD1ED.6030101@drdos.com> <1096738439.25290.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096738439.25290.13.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 06:34:01PM +0100, Alan Cox wrote:
> If you look at the motivation you'd then have to ask yourself why they
> would want to do that given that a) They from the start said publically
> "its using Linux" and b) Are dropping custom (well probably bought in
> mostly) apps onto a generic reference platform.

Alan, you put the finger on the right thing : motivation.

People ask what motivation has this vendor not to show his code. But the
reality is different. The vendor waits for some motivation to show it.
It costs lost of time and sometimes even documentation to open some modified
code, and for various time-to-market reasons, vendors sometimes think they
will do it later. I've already been in such a situation : I packaged something
for a customer. Yes I used Linux kernel and GPL tools, and yes I patched some
of them, but considering the time it would take to package something clean
with lots of sources when I knew for sure that the customer does not even
care, I did not do it. Just told the customer that if he wanted, he could
have everything, but when he replies "no thanks", I have no motivation
loosing my time. So from time to time, I put together new patches on my
web site to stay compliant, but there's no urge in that. And the GPL only
says that you have to provide the code or a way to get the code. So when
the customer says that he does not want it, the best way for him to get
the code when he changes his mind is to ask where I finally put it, then
for me to check that everything is up to date.

There is a second level of motivation at not opening the code from the
beginning : there still are some customers who are afraid that they
will use some code that anybody can see ! One of my customers, for
example was very reluctant to use my reverse-proxy (haproxy) because
he felt that if anybody found a flaw in the code, he could exploit it.
So I had to start the long story again from the dinosaurs ;-)

As long as vendors are honnest, and respect their customers' rights, I
don't see any problem. The problem arises when vendors explicitly refuse
to open anything. But most of the time, I suspect it's just a matter of
time and cleanness, and we should not expect too much from vendors who
already acknowledge that they are using GPL software and that they are
doing their best to publish the code ASAP.

> Not only they seem to be behaving but I can see no obvious game
> advantages for them to cheat.

I sometimes wonder if it does not bring cheap advertisement. For example,
Linksys is known to sell linux boxes because of the GPL war they started.
Nowadays, many people buy their boxes because they are both the cheapest
and the most complete devices a linux kernel can run on.

> One thing that certainly would be interesting as a thought experiment
> for the legal bods (the real ones) would be what occurs if the license
> on a couple of essential bits of the kernel was to say
> 
> 	GPL v 2 blah bla 
> 
> 	or you may choose to distribute the software without source
> 	code for $100,000 per product you ship it in.
> 
> This would then also give both a Judge and the thief a clear crystalised
> value for damages....

Hmmm interesting clause which would make them think before they steal the
code. Perhaps they would take more time to separate open and closed code
then. The problem is to define whom this money should be sent to.
 
Willy

