Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVGZXLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVGZXLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVGZXLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:11:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261915AbVGZXKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:10:01 -0400
Date: Tue, 26 Jul 2005 16:11:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl>
Cc: mkrufky@m1k.net, linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
Message-Id: <20050726161149.0c9c36fa.akpm@osdl.org>
In-Reply-To: <20050727004932.1b25fc5d.astralstorm@gorzow.mm.pl>
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
	<42E692E4.4070105@m1k.net>
	<20050726221506.416e6e76.astralstorm@gorzow.mm.pl>
	<42E69C5B.80109@m1k.net>
	<20050726144149.0dc7b008.akpm@osdl.org>
	<20050727004932.1b25fc5d.astralstorm@gorzow.mm.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl> wrote:
>
> On Tue, 26 Jul 2005 14:41:49 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Michael Krufky <mkrufky@m1k.net> wrote:
> > >
> > > [ tracking mm stuff ]
> > >
> > 
> > Sigh, sorry.  It's hard.  -mm is always in flux.  I no longer send out the
> > `patch was dropped' message because it disturbs people. 
> 
> There were too many? 
> Or you were receiving a lot of mail from particular developers with
> requests of explanation? :)

I got lots of "waah, why did you drop my patch" from people whose patches
had been merged by Linus.  Which is a bit odd given that those people were
previously cc'ed on the me->linus patch anyway.  Ho hum.  Adding a "why
this was dropped" to the email seemed too tricky.

> > The mm-commits
> > list does not resend a patch when it is changed (other patches folded into
> > it, rejects fixed, changelog updated, rediffed, etc).  
> 
> This isn't so much a problem as the previous point. When there are rejects,
> it's easy (most of the time) to fix them by hand anyway as I pull the tree.
> 
> > Sometimes I'll comment out a patch but not fully drop it.  
> 
> Now I can see that, I can diff the series. 
> But if the change was large, the diff isn't very instructive.

OK.  I'm uploading the stripped series file at present (all the comments
are removed) because some versions of quilt don't like my new
comments-at-the-end-of-the-line feature.  That actually breaks some of my
stuff too, so I'll probably stop using it ;)

> > 
> > I spose I could emit a broken-out.tar.gz file occasionally (it'd be up to 5
> > times a day), but there's no guarantee that it'll compile, let alone run. 
> > I could also send a notification to mm-commits when I do so.  Would that
> > help?
> > 
> 
> Really, it would. Especially if it contained an up-to-date series file.
> I'd be very grateful. (And would test and fix it up some more.)

All done - let me know if it needs anything else.
