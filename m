Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVCCOXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVCCOXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVCCOWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:22:42 -0500
Received: from [213.188.213.77] ([213.188.213.77]:24485 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S261755AbVCCOVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:21:47 -0500
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'Jochen Striepe'" <jochen@tolot.escape.de>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel release numbering
Date: Thu, 3 Mar 2005 15:19:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20050303135215.GT11280@tolot.miese-zwerge.org>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
thread-index: AcUf+GI2E3//4MghTHC5Rqz4QuUg/QAAAjrw
Message-Id: <20050303142140.7986384008@server1.navynet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Striepe wrote: 
> On 03 Mar 2005, Massimo Cetra wrote:
> > So, why moving from 2.6.14 to 2.6.15 when, in 2/4 weeks, 
> i'll have a 
> > more stable 2.6.16 ?
> > Will users help testing an odd release to have a good even 
> release ? 
> > Or will they consider an even release as important as a -RC 
> release ?
> 
>  From my experience this won't work (at least it won't work 
> as inten- ded). I see a tendency of people going away from 
> Linux-2.6, going back to Linux-2.4, or even going to one of 
> the free BSD's. They go away because they have the feeling 
> they cannot rely any longer on the stabi- lity of the 2.6 
> kernel branch (there are other issues, but this one is common 
> with most people I talked).

I agree.

I have no problem testing new releases on my laptop.
I could't care less if it hangs or explode.

But when I have to upgrade a wide set of servers, 400 Km away from my desk,
I would be really happy if everything goes just fine.

This is the reason why I have 2.4 on my production systems and 2.6 on my
laptop.

Usable does not means that it simply works.
It means it works like as charm as the previous releases and has no
regressions.

> What you really need to avoid this (as far as I can see) is a 
> stable Kernel branch that does not give you a huge surprise 
> every time you do a kernel upgrade. Some mediocre statement 
> like "this one might be quite ok" is not enough -- you need 
> to declare that 2.6.EVEN is *stable*, that it is ready for 
> production use. When people give it a test, fix the bugs they 
> find, and release anew without adding any other 
> "improvements". This way the user gets the least surprises 
> when doing the next update -- and that is what gets you more 
> users on 2.6: the users will feel they can
> *rely* on the stable releases.
> 
> At least that's how it looks here. And yes, I *know* it's 
> harder to do development when you're stuck with maintaining a 
> stable branch. It's your choice.

The kernel renumbering would probably have some benefits over development,
but will _not_ enlarge the testing base.

That I think is that an enlargement of the testers is needed and it would
provide more regression reports.

As a mantainer of other products (not related to kernel and not as important
and big as the kernel), I have noticed that many people dowload patches but
only a few percentage reports error...

So... My proposal is simply this:
- TELL THE MEDIA (tv, radio, papers, websites) that users have to test to
help developing the kernel testing RC versions.

- write a clear monkey-proof howto on how to report regressions and bugs
 (many people does not even know how to do it)

- write some scripts to package a report and send it (almost) automatically
 (many people does not have time to gather informations)

- write a small script to  report working configurations (lspci,lsmod and
similar, kernel version & patches)
 (this would be used to have known working configurations)

It needs work, of course. It's not simple.

But the problem is avoiding bugs and regressions to have the stablest
kernel.
To avoid bugs, you have to know them.
To know them you need reports.
To have reports, you need a wide range of testers.
To let testers report problems, you need them to understand how to do it.

Tricking users with bogus stable releases is not a solution.

(obviously it is _NOT_ from a developer point of view.)

Massimo Cetra









