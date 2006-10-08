Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWJHTMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWJHTMd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWJHTMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:12:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29371 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751343AbWJHTMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:12:32 -0400
Date: Sun, 8 Oct 2006 21:12:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 V9] drivers: add LCD support
Message-ID: <20061008191217.GA3788@elf.ucw.cz>
References: <20061006002950.49b25189.maxextreme@gmail.com> <20061008182438.GA4033@ucw.cz> <653402b90610081137g7885fc85h54e5e94de682a246@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653402b90610081137g7885fc85h54e5e94de682a246@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >No, I'm sorry. And I have to apologize for being blind.
> >
> >I was going to say 'this is very important, because cellphones *do*
> >have secondary displays, and we want to use them'. And yes it is
> >important, but you got the interface wrong.
> >
> >So you have 128x64 pixels b/w display, and invented completely new
> >interface to control it.
> >
> >Fortunately we already have good interface for the display... It is
> >called fbcon, and is more flexible than 128x64 b/w... but can do
> >128x64 b/w just fine.
> >
> >Please use it. It is way more flexible, and it is right thing to do.
> 
> Hum, excuse me if I haven't understood you, but this LCD has nothing
> to do with cellphones or fbcon.

To the contrary.

If you take a look at clamshell cellphone, it often has small status
display on the outside; sometimes black&white. (What I'm trying to say
is "this kind of status displays is going to become very common in future).

And fbcon is perfectly capable of driving your display, and there are
no downsides in using fbcon to do that... and when your VGA card dies,
you'll be able to login using keyboard + tiny display :-))).

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
