Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWBEWHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWBEWHy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 17:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWBEWHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 17:07:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10168 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750751AbWBEWHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 17:07:53 -0500
Date: Sun, 5 Feb 2006 23:07:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: suspend2-devel@lists.suspend2.net, Bojan Smojver <bojan@rexursive.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060205220740.GA3755@elf.ucw.cz>
References: <200602030918.07006.nigel@suspend2.net> <1139015620.2191.39.camel@coyote.rexursive.com> <20060204085301.GI3291@elf.ucw.cz> <200602042009.06462.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602042009.06462.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This was personal email. It is pretty rude to post it to public lists.
> >
> > > But hey, you seem to be bent on not having it - and you seem to be the
> > > one making that calls, so the rest of us that just want to use the
> > > notebooks properly will have to patch until someone decides that
> > > having something that works is more important than being right all the
> > > time.
> >
> > In the end, it is important what is right, not what works. If you do
> > not understand that -- bad for you.
> 
> True, but in something like putting code in the kernel vs in userspace, 
> people apply different criteria in determining what is right. God hasn't 
> written "You shall do suspend to disk in userspace" (and we'd probably 

Would written notice from Linus be good enough? :-))))

> best way is. Is userspace the 'right' solution? Well, yes, it does let you 
> add features without adding to kernel code. But it also creates other 
> problems. Putting it in kernel space has issues too - some things like 
> userui are best left where they won't necessary take down the whole 
> process if they don't work right. Personally, I think we're getting too 
> polarised here. I've already accepted that there's a space for userspace 
> code by merging (into Suspend2) code that puts the user interface there, 
> along with management of storage. You agree that somethings, such as
> the 

I did not know about storage management.

> atomic copy, simply can't be done in userspace. Without having looked 
> seriously at the code yet, I'd be pretty sure that you're also leaving the 
> calculation of what pages to store in the kernel. That just leaves how to 
> store the image. Aren't we actually a lot closer than it has appeared?

Well, perhaps we are. It should be possible to move suspend2 into
userspace, and at that point we can share all the kernel-level code
(and probably all the user-level code, too :-).
								Pavel
-- 
Thanks, Sharp!
