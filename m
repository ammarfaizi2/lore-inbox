Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966882AbWKYRiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966882AbWKYRiO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 12:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966883AbWKYRiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 12:38:14 -0500
Received: from [212.33.161.223] ([212.33.161.223]:61312 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S966882AbWKYRiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 12:38:13 -0500
From: Al Boldi <a1426z@gawab.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] PM: suspend/resume debugging should depend on
Date: Sat, 25 Nov 2006 20:40:45 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200611192130.11542.a1426z@gawab.com> <20061124224130.GA4782@ucw.cz>
In-Reply-To: <20061124224130.GA4782@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611252040.45048.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Sun 19-11-06 21:30:11, Al Boldi wrote:
> > Mike Galbraith wrote:
> > > On Sun, 2006-11-19 at 09:33 -0800, Linus Torvalds wrote:
> > > > On Sun, 19 Nov 2006, Chuck Ebbert wrote:
> > > > > When doing 'make oldconfig' we should ask about suspend/resume
> > > > > debug features when SOFTWARE_SUSPEND is not enabled.
> > > >
> > > > That's wrong.
> > > >
> > > > I never use SOFTWARE_SUSPEND, and I think the whole concept is
> > > > totally broken.
> > > >
> > > > Sane people use suspend-to-ram, and that's when you need the suspend
> > > > and resume debugging.
> > >
> > > Here I am wishing I had the _opportunity_ to be sane.  With my ATI
> > > X850 AGP card, I have no choices except swsusp or reboot.
> >
> > You make it sound like suspend-to-ram is dependent on a correct display
> > adapter to work; it doesn't even work on a machine without a display
> > adapter.
> >
> > see http://bugzilla.kernel.org/show_bug.cgi?id=7037
>
> Well, on 'normal' machines, video card is the most common problem.

Ok, but it's normally well understood that when debugging, you should try to 
reduce the number of elements to a bare minimum for the problem to surface.

Are you saying that the ACPI STR spec requires a display-card to be attached?

If not, then all efforts should go into fixing STR with a bare minimum 
.config without even a display adapter.


Thanks!

--
Al

