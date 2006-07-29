Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWG2WzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWG2WzD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 18:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWG2WzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 18:55:01 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:43393 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750740AbWG2WzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 18:55:00 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Hua Zhong" <hzhong@gmail.com>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Date: Sun, 30 Jul 2006 00:54:18 +0200
User-Agent: KMail/1.9.3
Cc: "'Bill Davidsen'" <davidsen@tmr.com>, "'Pavel Machek'" <pavel@ucw.cz>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <005701c6b359$dacc6f50$0200a8c0@nuitysystems.com>
In-Reply-To: <005701c6b359$dacc6f50$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607300054.18231.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 July 2006 23:56, Hua Zhong wrote:
> > Moreover, if the swsusp's resume doesn't work for you and 
> > suspend2's resume does, this probably means that suspend2 
> > contains some driver fixes that haven't been submitted for merging.
> 
> This statement worries me for several reasons.
> 
> First, I've seen repeatedly blame for "drivers". People might buy it if
> there was not a working suspend2. I never saw Nigal blame 
> drivers;

I don't _blame_ drivers.  I only wanted to say this: "If Nigel knows that some
drivers need to be fixed and he has working fixes for these drivers, he
should have submitted these fixes for merging instead of just keeping
them in suspend2".  Period.

If I know of a fix for a driver, I always do my best to make sure the fix
will get considered for merging at least.  The problem is I'm not a driver
expert and I can't provide the fixes myself.

> instead he makes sure to provide working code. In the end, users want
> a working suspend, and that's what counts.  
> 
> Second, if the current swsusp maintainers have genuine interest for the
> users (not just "it works on my machine"), I would think they'd have taken
> a serious look at why suspend2 has a higher success rate. But from the
> above comment, you are not even sure why  that is, and could only speculate
> "this probably means (drivers)".

No, I'm not sure.  If I were, I would fix the problem.  Also I'm not quite sure
about the higher success rate of suspend2.

> I could hardly be convinced that the current maintainers have been trying to
> work with Nigal to improve Linux suspend.

This is an offensive comment.

> At last, "maintainer" is not just a title or a feeling of superiority, it's
> a responsibility of providing a great system to the users. I'll just quote
> Linus when he was flaming suspend-to-ram a couple of months ago.
> Replace it with suspend-to-disk at your own will:

This also is offensive, because the current swsusp _does_ work for many
people.  Actually I've recently tried a couple of various machines on which
it "just works", so I will not replace suspend-to-ram with suspend-to-disk
below, sorry.

Moreover, if it doesn't and the problem is reported, we do our best to trace
it and fix it, but sometimes we just can't do this without access to the
hardware in question.

> "The fact that worries me is that suspend-to-ram DOES NOT WORK FOR PEOPLE. 
> I have never _ever_ met a laptop or machine of mine that "just worked". 
> I've always had to fix something, and people always end up having to do 
> something ridiculous like unlink all modules etc.
> 
> If that isn't what worries you, you're on the wrong page."

And that's very true.  For example, the suspend-to-ram doesn't fully work
on my own box and I'm not sure it ever will.  However, that's not a fault
of anyone who works on this, just broken BIOS and the lack of documentation.
This is worrisome and many people work on improving these things, but
the matter is notoriously difficult.

Greetings,
Rafael

