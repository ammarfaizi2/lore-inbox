Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWCFWXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWCFWXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWCFWXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:23:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57836 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932402AbWCFWXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:23:00 -0500
Date: Mon, 6 Mar 2006 23:22:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: M?ns Rullg?rd <mru@inprovide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [OT] inotify hack for locate
Message-ID: <20060306222228.GE4836@elf.ucw.cz>
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com> <1141594983.14714.121.camel@mindpipe> <20060305230821.GA20768@kvack.org> <yw1xu0acbhby.fsf@agrajag.inprovide.com> <20060306215332.GA4836@elf.ucw.cz> <yw1xzmk39qg3.fsf@agrajag.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xzmk39qg3.fsf@agrajag.inprovide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 06-03-06 22:08:28, M?ns Rullg?rd wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
> > On Ne 05-03-06 23:30:09, M?ns Rullg?rd wrote:
> >> Benjamin LaHaise <bcrl@kvack.org> writes:
> >> 
> >> > On Sun, Mar 05, 2006 at 04:43:03PM -0500, Lee Revell wrote:
> >> >> updatedb runs at nice 20 on most distros, and with the CFQ scheduler the
> >> >> IO priority follows the nice value, so why does it still kill the
> >> >> machine?
> >> >
> >> > Running updatedb on a laptop when you're sitting in an airplane running 
> >> > off of batteries is Not Nice to the user.  I know, I've had it happen far 
> >> > too many times.
> >> 
> >> Running updatedb only if AC powered shouldn't be too difficult.
> >
> > That makes locate useless on some machines. I have sharp zaurus C3000
> > here... It is either powered on *or* connected on AC, but very rarely
> > connected to ac while turned on. Well, its power plug located at weird
> > place and old software version that prevents charging while turned on
> > is contributory factor, but...
> 
> OK, although that surely must be an exception.  Most laptops run
> happily with AC connected, and the current power source is easily
> obtained from some file in /proc that I've forgotten the name of.

This is really small machine. Yes, it is an exception...

..and you could modify cron to know about AC power. Something like "do
every day at 4 am if you are on AC power; delay it if you are on DC
power, but for no more than 3 days"... should do the trick.

Actually that modification to cron would be probably useful for
non-updatedb stuff, too....
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
