Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966481AbWKYMeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966481AbWKYMeG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 07:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966503AbWKYMeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 07:34:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65291 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S966481AbWKYMeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 07:34:01 -0500
Date: Fri, 24 Nov 2006 22:41:30 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] PM: suspend/resume debugging should depend on
Message-ID: <20061124224130.GA4782@ucw.cz>
References: <200611192130.11542.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611192130.11542.a1426z@gawab.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-11-06 21:30:11, Al Boldi wrote:
> Mike Galbraith wrote:
> > On Sun, 2006-11-19 at 09:33 -0800, Linus Torvalds wrote:
> > > On Sun, 19 Nov 2006, Chuck Ebbert wrote:
> > > > When doing 'make oldconfig' we should ask about suspend/resume
> > > > debug features when SOFTWARE_SUSPEND is not enabled.
> > >
> > > That's wrong.
> > >
> > > I never use SOFTWARE_SUSPEND, and I think the whole concept is totally
> > > broken.
> > >
> > > Sane people use suspend-to-ram, and that's when you need the suspend and
> > > resume debugging.
> >
> > Here I am wishing I had the _opportunity_ to be sane.  With my ATI X850
> > AGP card, I have no choices except swsusp or reboot.
> 
> You make it sound like suspend-to-ram is dependent on a correct display 
> adapter to work; it doesn't even work on a machine without a display 
> adapter.
> 
> see http://bugzilla.kernel.org/show_bug.cgi?id=7037

Well, on 'normal' machines, video card is the most common problem.

							Pavel

-- 
Thanks for all the (sleeping) penguins.
