Return-Path: <linux-kernel-owner+w=401wt.eu-S1754228AbWLXJgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbWLXJgI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 04:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbWLXJgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 04:36:08 -0500
Received: from anchor-fallback-96.mail.demon.net ([194.217.242.83]:57259 "EHLO
	anchor-fallback-96.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754240AbWLXJgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 04:36:07 -0500
Message-ID: <45811AA6.1070508@superbug.co.uk>
Date: Thu, 14 Dec 2006 09:34:30 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 13 Dec 2006, Greg KH wrote:
>> Numerous kernel developers feel that loading non-GPL drivers into the
>> kernel violates the license of the kernel and their copyright.  Because
>> of this, a one year notice for everyone to address any non-GPL
>> compatible modules has been set.
> 
> Btw, I really think this is shortsighted.
> 
> It will only result in _exactly_ the crap we were just trying to avoid, 
> namely stupid "shell game" drivers that don't actually help anything at 
> all, and move code into user space instead.
> 
> What was the point again?
> 
> Was the point to alienate people by showing how we're less about the 
> technology than about licenses?
> 
> Was the point to show that we think we can extend our reach past derived 
> work boundaries by just saying so? 
> 
> The silly thing is, the people who tend to push most for this are the 
> exact SAME people who say that the RIAA etc should not be able to tell 
> people what to do with the music copyrights that they own, and that the 
> DMCA is bad because it puts technical limits over the rights expressly 
> granted by copyright law.
> 
> Doesn't anybody else see that as being hypocritical?
> 
> So it's ok when we do it, but bad when other people do it? Somehow I'm not 
> surprised, but I still think it's sad how you guys are showing a marked 
> two-facedness about this.
> 
> The fact is, the reason I don't think we should force the issue is very 
> simple: copyright law is simply _better_off_ when you honor the admittedly 
> gray issue of "derived work". It's gray. It's not black-and-white. But 
> being gray is _good_. Putting artificial black-and-white technical 
> counter-measures is actually bad. It's bad when the RIAA does it, it's bad 
> when anybody else does it.
> 
> If a module arguably isn't a derived work, we simply shouldn't try to say 
> that its authors have to conform to our worldview.
> 
> We should make decisions on TECHNICAL MERIT. And this one is clearly being 
> pushed on anything but.
> 

I agree with Linus on these points. The kernel should not be enforcing 
these issues. Leave the lawyers to do that bit. If companies want to 
play in the "Grey Area", then it is at their own risk. Binary drivers 
are already difficult and expensive for the companies because they have 
to keep updating them as we change the kernel versions. If they do open 
source drivers, we update them for them as we change the kernel 
versions, so it works out cheaper for the companies involved.

The open source community tends to be able to reverse engineer all 
drivers eventually anyway in order to ensure compatibility with all 
kernel versions and also ensure that the code is well reviewed and 
therefore contains fewer security loopholes, e.g. Atheros Wireless open 
source HAL. This also tends to make it rather pointless for companies to 
do binary drivers, because all it does is delay the open source version 
of the driver and increase the security risk to users. One other example 
I have, is that I reverse engineered a sound card driver so that we had 
an open source driver for it. Once I had manually documented the sound 
card, so we had details of all the registers and how to use them, the 
manufacturer finally sent the datasheet to me! A bit late really, but it 
certainly did encourage the manufacturer to pass datasheets to 
developers. I now have a large array of datasheets from this 
manufacturer that save me having to reverse engineer other sound cards 
in their range.
Making binary drivers is therefore not a viable way to protect IP. We 
are slowly removing the excuses that companies can hide behind as 
reasons for not releasing datasheets to open source driver developers.

James

