Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932789AbWKSS0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbWKSS0z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWKSS0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:26:55 -0500
Received: from [212.33.187.4] ([212.33.187.4]:60032 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932789AbWKSS0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:26:54 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] PM: suspend/resume debugging should depend on
Date: Sun, 19 Nov 2006 21:30:11 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611192130.11542.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Sun, 2006-11-19 at 09:33 -0800, Linus Torvalds wrote:
> > On Sun, 19 Nov 2006, Chuck Ebbert wrote:
> > > When doing 'make oldconfig' we should ask about suspend/resume
> > > debug features when SOFTWARE_SUSPEND is not enabled.
> >
> > That's wrong.
> >
> > I never use SOFTWARE_SUSPEND, and I think the whole concept is totally
> > broken.
> >
> > Sane people use suspend-to-ram, and that's when you need the suspend and
> > resume debugging.
>
> Here I am wishing I had the _opportunity_ to be sane.  With my ATI X850
> AGP card, I have no choices except swsusp or reboot.

You make it sound like suspend-to-ram is dependent on a correct display 
adapter to work; it doesn't even work on a machine without a display 
adapter.

see http://bugzilla.kernel.org/show_bug.cgi?id=7037


Thanks!

--
Al

