Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWGHXyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWGHXyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 19:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWGHXyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 19:54:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26514 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932345AbWGHXyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 19:54:08 -0400
Date: Sun, 9 Jul 2006 01:53:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Bojan Smojver <bojan@rexursive.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Arjan van de Ven <arjan@infradead.org>,
       Sunil Kumar <devsku@gmail.com>, Avuton Olrich <avuton@gmail.com>,
       Olivier Galibert <galibert@pobox.com>, Jan Rychter <jan@rychter.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060708235336.GF2546@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com> <1152377434.3120.69.camel@laptopd505.fenrus.org> <200607082125.12819.rjw@sisk.pl> <1152402366.2584.10.camel@coyote.rexursive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152402366.2584.10.camel@coyote.rexursive.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-07-09 09:46:06, Bojan Smojver wrote:
> On Sat, 2006-07-08 at 21:25 +0200, Rafael J. Wysocki wrote:
> 
> > Now there seem to be two possible ways to go:
> > 1) Drop the implementation that already is in the kernel and replace it with
> > the out-of-the-tree one.
> > 2) Improve the one that already is in the kernel incrementally, possibly
> > merging some code from the out-of-the-tree implementation, so that it's as
> > feature-rich as the other one.
> > 
> > Apparently 1) is what Nigel is trying to make happen and 2) is what I'd like
> > to do.
> 
> I didn't get the impression from 1) at all. If anything, Nigel has been
> busy making Suspend2 use swsusp machinery *more*, not less as of
> recently. If he wanted to drop swsusp completely, why would he do
> something like that?
> 
> But, the confusing bit for me here is 2). Given that you're the man for
> uswsusp, why would you want to keep any of the in-kernel
> implementations? The only thing that crosses my mind right now is that
> uswsusp may be a bit heavy on setup, so Linux distros/users that may not
> have the luxury of doing all that would be left without a suspend/resume
> solution. Is that why you want to keep an in-kernel implementation as
> well? Or is there some other reason?

swsusp/uswsusp share 75% or so of code, and we can't really drop
swsusp soon, because that would break existing setups. Warning
year-or-so ahead is needed to do such big changes. Plus you are quite
right n that "heavy to setup" thing.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
