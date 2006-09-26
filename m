Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWIZKYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWIZKYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 06:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWIZKYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 06:24:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17094 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751101AbWIZKYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 06:24:41 -0400
Date: Tue, 26 Sep 2006 12:24:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060926102434.GA2134@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de> <1159220043.12814.30.camel@nigel.suspend2.net> <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz> <20060925160648.de96b6fa.akpm@osdl.org> <20060925232151.GA1896@elf.ucw.cz> <20060925172240.5c389c25.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925172240.5c389c25.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Your machines spend 15 seconds in drivers? Ouch, I did not realize
> > _that_. 
> > 
> > (My machine suspends in 7 seconds, perhaps 2-3 of that are playing
> > with drivers, so I just failed to see where the problem is).
...
> It's my long-suffering Vaio laptop.
> 
> > Rafael has "fakesuspend" patches somewhere, but you can probably just
> > swapoff -a, then echo disk > /sys/power/state. If you are lucky, that
> > should be slow, too... fortunately you'll have useful dmesg buffer
> > when you are done. CONFIG_PRINTK_TIMING or something, and you should
> > have enough clues...?
> 
> That would help.

Is "swapoff -a; echo disk > /sys/power/state" slow for you? If so, we
have something reasonably easy to debug, if not, we'll try something
else...

> > 15 seconds spend within drivers is definitely _not_ okay.
> 
> I assumed it was the same for everyone else ;)

Ok, then I see why you was upset ;-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
