Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbVIOCYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVIOCYV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbVIOCYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:24:21 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:59305 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030346AbVIOCYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:24:20 -0400
Subject: Re: [linux-pm] swsusp3: push image reading/writing into userspace
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Daniel Goller <morfic@gentoo.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200509142113.03763.morfic@gentoo.org>
References: <20050914223206.GA2376@elf.ucw.cz>
	 <1126749596.3987.5.camel@localhost>  <200509142113.03763.morfic@gentoo.org>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1126751058.3987.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 15 Sep 2005 12:24:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-09-15 at 12:13, Daniel Goller wrote:
> On Wednesday 14 September 2005 08:59 pm, Nigel Cunningham wrote:
> > Hi Pavel.
> >
> > On Thu, 2005-09-15 at 08:32, Pavel Machek wrote:
> > > Hi!
> > >
> > > Here's prototype code for swsusp3. It seems to work for me, but don't
> > > try it... yet. Code is very ugly at places, sorry, I know and will fix
> > > it. This is just proof that it can be done, and that it can be done
> > > without excessive ammount of code.
> >
> > No comments on the code sorry. Instead I want to ask, could you please
> > find a different name? swsusp3 is going to make people think that it's
> > Suspend2 redesigned. Since there hasn't been a swsusp2 (so far as I
> > know), 
> 
> swsusp2 seems to be the common/trivial name for suspend2 (at least while 
> struggling to get any kind of suspend working here, helpful people have 
> refered to suspend2 as swsusp2)

Yes, they do sometimes. But that's not right since 'sw' is at least
sometimes treated as an abbreviation for swap. Suspend2 isn't limited to
writing to swap. That (along with the fact that swsusp is an ugly
acronym) is the reason why I've tried to push away from using that term.

> > how about using that name instead? At least then we'll clearly 
> > differentiate the two implementations and you won't confuse/irritate
> > users.
> 
> if he would use that people would get quite confused and not know if people 
> mean your suspend2 or his swsusp2

If they're clearly differentiated, that shouldn't be a problem. In fact,
it would help differentiate them.

> Just a thought,

Thanks!

Nigel

> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 


