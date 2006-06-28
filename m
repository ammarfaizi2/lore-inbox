Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWF1VgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWF1VgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWF1VgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:36:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31126 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751558AbWF1VgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:36:22 -0400
Date: Wed, 28 Jun 2006 23:05:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Olivier Galibert <galibert@pobox.com>, Rahul Karnik <rahul@genebrew.com>,
       nigel@suspend2.net, Jens Axboe <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
Message-ID: <20060628210556.GB13397@elf.ucw.cz>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271539.29540.nigel@suspend2.net> <20060627070505.GH22071@suse.de> <200606271739.13453.nigel@suspend2.net> <b29067a0606280428tff7b9dcp66bac3f2b83f4cc6@mail.gmail.com> <20060628143725.GC99263@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628143725.GC99263@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Pavel wants everything in userspace.  Nigel wants everything but the
> chrome in kernelspace.  Other kernels maintainers are split on the
> issue, or don't care apart from "it should have been working for
> years, damnit".  Andrew plainly said he doesn't know what's best, and
> Linus seems to be very careful not to talk about it.
> 
> What should have happened is that suspend2 should have been merged
> years ago, and then now transiting more of it to userspace or not
> could be experimented, starting on a decently working base.  Pavel's
> NIH-ing prevented that though.
> 
> In any case, don't use software suspend on a machine with data you
> care about, and especially not uswsusp.  Side effect of userspace code
> is that nobody from outside the project reviews it, and it's way too
> young to have any kind of confidence in it.

Well, swsusp is *way* better reviewed than suspend2, because it is
<10% of code size, and it is in kernel already (plus Rafael did the
reviews/rewriting).

Your point about uswsusp is "interesting", but notice that noone ever
reviewed suspend2, either. So... if you care about your data, swsusp
is currently the _safest_ way to go. (It may not have the _nicest_
progress indication :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
