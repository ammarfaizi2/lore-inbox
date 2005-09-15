Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbVIOHh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbVIOHh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVIOHh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:37:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17354 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030470AbVIOHh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:37:56 -0400
Date: Thu, 15 Sep 2005 09:37:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] swsusp3: push image reading/writing into userspace
Message-ID: <20050915073744.GA2725@elf.ucw.cz>
References: <20050914223206.GA2376@elf.ucw.cz> <1126749596.3987.5.camel@localhost> <20050915063753.GA2691@elf.ucw.cz> <1126768581.3987.31.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126768581.3987.31.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Here's prototype code for swsusp3. It seems to work for me, but don't
> > > > try it... yet. Code is very ugly at places, sorry, I know and will fix
> > > > it. This is just proof that it can be done, and that it can be done
> > > > without excessive ammount of code.
> > > 
> > > No comments on the code sorry. Instead I want to ask, could you please
> > > find a different name? swsusp3 is going to make people think that it's
> > > Suspend2 redesigned. Since there hasn't been a swsusp2 (so far as I
> > > know), how about using that name instead? At least then we'll clearly
> > > differentiate the two implementations and you won't confuse/irritate
> > > users.
> > 
> > swsusp2 can't be used, it is already "taken" by suspend2 (25000 hits
> > on google). I was actually hoping that you would release suspend4
> > (using swsusp3 infrastructure) :-).
> 
> You could reclaim it. There are 10 times as many hits (239,000) for
> suspend2, and I've never wanted it to be called swsusp2 anyway :). As
> for suspend4, at the moment, I'm not planning on ever progressing beyond
> 2.x.

Sorry, have to ask...

"not planning on progressing" == version number stays "2" no matter
what changes, or "not planning on progressing" == not plan to use
swsusp3/uswsusp infrastructure?

> > I guess I could call it "uswsusp".
> 
> u as in micro?

Originaly I thought about it as "userland-swsusp", but micro-swsusp
sounds nice, too.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
