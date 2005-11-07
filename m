Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVKGMnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVKGMnQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVKGMnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:43:16 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:12183 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932476AbVKGMnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:43:15 -0500
Subject: Re: 3D video card recommendations
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1131349343.2858.11.camel@laptopd505.fenrus.org>
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <1131349343.2858.11.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 07 Nov 2005 07:42:51 -0500
Message-Id: <1131367371.14381.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 08:42 +0100, Arjan van de Ven wrote:

> people who buy a 3D card for linux that depends on a closed source
> module take a few risks, and they should be aware of them (I suspect
> they are) so let me make some of them explicit:

Are there good 3D cards that don't depend on a proprietary module, that
can run on a AMD64 board?  That was pretty much my questing to begin
with :)
 
> 
> By buying a piece of hardware that requires a closed module you take the
> risk that one of the following can happen at any time

Yep, I know all these, since I've been a NVidia user for some time.  But
NVidia was good enough for my needs since the only times I needed 3D was
when I wasn't playing with experimental kernels.

> 
> 1) The vendor in the future stops considering linux important and you're
> stuck with old kernels; for example as a side-effect of getting a good
> deal to supply graphics chips to a certain game console maker

I was able to get some hacks out for NVidia on some new kernels before
they were official released.  But they were not great, just worked.

> 2) The vendor in the future stops considering the hardware you bought
> important enough to spend time on; after all they got their cash and the
> product cycles for consumer hardware are often in the 3 to 6 month
> timeframe. Result: you're stuck with old kernels.

So far NVidia is good at having one driver to do most of their boards.
It would take a major design change of a model to stop this, and by
then, I would probably have a new video card anyway.

> 3) The vendor gets sued and convicted for GPL violations and stops doing
> linux as a result. (not saying it will happen, but it sure is a risk you
> are taking)

Could happen, but I doubt it.  This might happen if one of the above do
first :)

> 4) The linux kernel developers change the kernel in a way that the
> module in question no longer is possible and the vendor stops updating
> the driver

I've also hacked my kernel to get NVidia working. (Changing
EXPORT_SYMBOL_GPL back to EXPORT_SYMBOL)  It's ok as long as I'm using
this just for myself.  Which currently I am.

> 5) The vendor goes out of business and thus stops updating the driver

MS folks would have the same problem.

> 6) The vendor doesn't release an x86-64 binary (or other architecture)
> and your next PC can't use the module anymore

Hmm, x86-64 _is_ what I'll be using this on :-/

> 7) The vendor starts charging money for the driver or updates thereof.

Good way to lose customers.

> 
> Open source is not just something for developers, but also for users. It
> means that you or anyone else can keep the open driver going even when
> the manufacturer stops doing so. By using a closed driver you get all
> the disadvantages of the open source model (yes there are some just that
> normally the benefits outweigh them by far) without getting the gains.
> Be very sure you want to do this before spending your hard earned money
> on hardware that doesn't work without closed drivers.
> 

I totally agree with you on this, that's why my question was about a
good "Open Source" 3D card in the first place.  I want to try out 3D on
Ingo's RT patch set and NVidia (because of the above that you mentioned)
doesn't cut it anymore.  I've heard that the Radeon open source drive
isn't too bad so I went with them. I don't need the best 3D, but I do
need something.

So you are right.  I've been a loyal NVidia customer for several years
now, but since there is no alternative of a reliable 3D driver for them,
I had to leave them to do what I needed. Now they risk me never going
back if I find out that I like ATI better.

-- Steve


