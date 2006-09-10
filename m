Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWIJT1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWIJT1l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 15:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWIJT1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 15:27:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47060 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932509AbWIJT1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 15:27:40 -0400
Date: Sun, 10 Sep 2006 21:27:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: curious <curious@zjeby.dyndns.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: swsusp problem
Message-ID: <20060910192716.GB5308@elf.ucw.cz>
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org> <200609101133.32931.rjw@sisk.pl> <Pine.LNX.4.63.0609102123080.2685@Jerry.zjeby.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609102123080.2685@Jerry.zjeby.dyndns.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-09-10 21:24:15, curious wrote:
> 
> On Sun, 10 Sep 2006, Rafael J. Wysocki wrote:
> 
> >Hi,
> >
> >On Sunday, 10 September 2006 02:13, curious wrote:
> >>hello.
> >>i write because swsuspend don't work for me.
> >>i try to echo disk > /sys/power/state
> >>and just nothing happens, i have blinking cursor and machine freezes.
> >>
> >>when i enabled debug i got :
> >>stopping tasks: ========|
> >>Shrinking memory... done (2684 pages freed)
> >>swsusp: Need to copy 1454 pages
> >>swsusp: critical section/: done (1454 pages copied)
> >>
> >>.... and machine just sits there , doing nothing.
> >>after reboot it boots like usual.
> >>
> >>machine is Ts30M Viglen Dossier 486 SM
> >>kernel is 2.6.18-rc5
> >>here is config : http://zjeby.dyndns.org:8242/viglen.config
> >
> >Could you boot the kernel with the init=/bin/bash command line argument
> >and do the following:
> >
> ># mount /proc
> ># mount /sys
> ># echo 8 > /proc/sys/kernel/printk
> ># swapon -a
> ># echo disk > /sys/power/state
> >
> >and see what happens?
> 
> same thing , except page count is different ofcourse.

What kind of machine is that? What cpu? Really 486?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
