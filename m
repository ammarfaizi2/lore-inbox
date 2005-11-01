Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVKAWzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVKAWzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVKAWzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:55:04 -0500
Received: from tim.rpsys.net ([194.106.48.114]:33453 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751388AbVKAWzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:55:03 -0500
Subject: Re: Make spitz compile again
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051101221410.GA21034@flint.arm.linux.org.uk>
References: <20051031134255.GA8093@elf.ucw.cz>
	 <1130773530.8353.39.camel@localhost.localdomain>
	 <20051101200516.GA7172@elf.ucw.cz>
	 <1130881612.8489.33.camel@localhost.localdomain>
	 <20051101221410.GA21034@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 22:54:53 +0000
Message-Id: <1130885693.8489.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 22:14 +0000, Russell King wrote: 
> On Tue, Nov 01, 2005 at 09:46:52PM +0000, Richard Purdie wrote:
> > I'd be interested to know if this helps your spitz kernel as its gets
> > c7x0 working again. Obviously the next step is to work out why this
> > breaks things but reverting it gets my Zaurus dev tree working again
> > which stops users c7x0 complaining :)
> 
> You need to at least follow my suggestion in order to move forward on
> this.  You're the only ones seeing a problem so far.

I realise that and I will debug this when I have time to do so. At least
that patch identifies roughly where the problem is and allows me to
think about merging more code now my dev tree works again.

I passed the patch on to Pavel in the hope that it might solve his
immediate problem and give him a clue as to where to look for the real
solution if it does. 

> Maybe when other folk try it out some pattern will emerge.
> 
> Shame this couldn't have been done a month ago though when I wrote the
> patch and it was fresh in my mind.

It is as I could have spent the time merging more Zaurus support instead
of chasing bugs. Several Zaurus related things I'd like to have seen
merged in 2.6.15 are looking unlikely to happen due to time
constraints :-(.

Richard


