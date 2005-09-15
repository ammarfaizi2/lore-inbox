Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbVIOHQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbVIOHQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVIOHQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:16:29 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:20201 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030462AbVIOHQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:16:24 -0400
Subject: Re: [linux-pm] swsusp3: push image reading/writing into userspace
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20050915063753.GA2691@elf.ucw.cz>
References: <20050914223206.GA2376@elf.ucw.cz>
	 <1126749596.3987.5.camel@localhost>  <20050915063753.GA2691@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1126768581.3987.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 15 Sep 2005 17:16:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-09-15 at 16:37, Pavel Machek wrote:
> Hi!
> 
> > > Here's prototype code for swsusp3. It seems to work for me, but don't
> > > try it... yet. Code is very ugly at places, sorry, I know and will fix
> > > it. This is just proof that it can be done, and that it can be done
> > > without excessive ammount of code.
> > 
> > No comments on the code sorry. Instead I want to ask, could you please
> > find a different name? swsusp3 is going to make people think that it's
> > Suspend2 redesigned. Since there hasn't been a swsusp2 (so far as I
> > know), how about using that name instead? At least then we'll clearly
> > differentiate the two implementations and you won't confuse/irritate
> > users.
> 
> swsusp2 can't be used, it is already "taken" by suspend2 (25000 hits
> on google). I was actually hoping that you would release suspend4
> (using swsusp3 infrastructure) :-).

You could reclaim it. There are 10 times as many hits (239,000) for
suspend2, and I've never wanted it to be called swsusp2 anyway :). As
for suspend4, at the moment, I'm not planning on ever progressing beyond
2.x.

> I guess I could call it "uswsusp".

u as in micro?

Regards,

Nigel

> 								Pavel
-- 


