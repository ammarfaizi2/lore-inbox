Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWIYFD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWIYFD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 01:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWIYFD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 01:03:27 -0400
Received: from 1wt.eu ([62.212.114.60]:17683 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751152AbWIYFD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 01:03:26 -0400
Date: Mon, 25 Sep 2006 06:40:10 +0200
From: Willy Tarreau <w@1wt.eu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: An Ode to GPLv2 (was Re: GPLv3 Position Statement)
Message-ID: <20060925044010.GN541@1wt.eu>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0609241917520.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609241917520.3952@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Sep 24, 2006 at 07:44:59PM -0700, Linus Torvalds wrote:
[...]
> And thus spake PJ in response:
>    "GPLv2 is not compatible with the Apache license.  It doesn't cover
>     Bitstream.  It is ambiguous about web downloads.  It allows Tivo to
>     forbid modification.  It has no patent protection clause.  It isn't
>     internationally useful everywhere, due to not matching the terms of
>     art used elsewhere.  It has no DMCA workaround or solution.  It is
>     silent about DRM."
> 
> Exactly!
> 
> That's why the GPLv2 is so great.  Exactly because it doesn't bother or
> talk about anything else than the very generic issue of "tit-for-tat". 
> 
> You see it as a failure.  I see it as a huge advantage.  The GPLv2 covers 
> the only thing that really matters, and the only thing that everybody can 
> agree on ("tit-for-tat" is really something everybody understands, and 
> sees the same way - it's totally independent of any moral judgement and 
> any philosophical, cultural or economic background).
> 
> The thing is, exactly because the GPLv2 is not talking about the details, 
> but instead talks entirely about just a very simple issue, people can get 
> together around it.  You don't have to believe in the FSF or the tooth 
> fairy to see the point of the GPLv2.  It doesn't matter if you're black or 
> white, commercial or non-commercial, man or woman, an individual or a 
> corporation - you understand tit-or-tat.

[...]
> That's also why I ended up changing the kernel license to the GPLv2. The 
> original Linux source license said basically: "Give all source back, and 
> never charge any money".  It took me a few months, but I realized that the 
> "never charge any money" part was just asinine.  It wasn't the point.  
> The point was always "give back in kind".

[...]
> And that's what the GPLv2 is.  It's "fair".  It asks everybody - 
> regardless of circumstance - for the same thing.  It asks for the effort 
> that was put into improving the software to be given back to the common 
> good.  You can use the end result any way you want (and if you want to use 
> it for "bad" things, be my guest), but we ask the same exact thing of 
> everybody - give your modifications back.
> 
> That's true grace.  Realizing that the petty concerns don't matter, 
> whether they are money or DRM, or patents, or anything else.
> 
> And that's why I chose the GPLv2.  I did it back when the $169 I paid for 
> Minix still stung me, because I just decided that that wasn't what it was 
> all about.
> 
> And I look at the additions to the GPLv3, and I still say: "That's not 
> what it's all about".
> 
> My original license was petty and into details.  I don't need to go back 
> to those days.  I found a better license.  And it's the GPLv2.

That's an interesting analysis, and it somehow reflects one I had to
do a few months back. After all the fuss about binary-only modules
incompatibility with GPLv2, I wanted to change the license of haproxy
to explicitly permit external binary-only code to be linked with it. It's
a TCP/HTTP load balancer and people might sometimes have to implement
algorithms under NDA for specific protocols, and I don't want to have
to decide for them if it is the right tool for them or not. I don't
either want to force them to release their code if I don't use it and
if nobody has contributed to it. I just wanted them to give back any
change they bring to the core.

I spend a full week-end reading other licenses, and many others looked
appealing but added specific clauses for patents, DRM, etc... which were
too restrictive for the end user. Others in turn did not make provisions
for feedback. I finally gave up, and decided that the GPLv2 was definitely
the best one for the job. I only changed all the interfacing headers to
LGPL and added a note to explicitly state that my intent was to allow
people to write binary-only modules as long as they gave back their
fixes or work on the core system they use.

As a result, developers are free to choose how they work, and the type
of contribution they expect from others, but they must respect the
work of others. *That* is what I consider fair use.

Just my 2 cents,
Willy

