Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWGCVgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWGCVgb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWGCVgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:36:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33229 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750745AbWGCVga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:36:30 -0400
Date: Mon, 3 Jul 2006 23:36:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Theodore Tso <tytso@mit.edu>, Jeff Bailey <jbailey@ubuntu.com>,
       "H. Peter Anvin" <hpa@zytor.com>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060703213617.GD1674@elf.ucw.cz>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain> <20060701150506.GA10517@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701150506.GA10517@thunk.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Fortunately there is a workaround by not building the MPT Fusion
> device driver as a module, but if Pavel succeeds in ejecting software
> suspend into userspace, and preventing suspend2 from getting merged,
> *and* distro's insist on doing their own thing with initramfs, we are
> going to be headed for a major trainwreck.

Well, uswsusp kernel <-> user interface should be stable (and is
already in 2.6.17)... So I'd in fact _like_ distros to use their own
versions of suspend/resume tools -- so they can get nice splash
screens, compression and encryption.

Version bundled with kernel will _not_ have those features... it
should be simple to get working, but will provide bare-bones
functionality.

(But as ABI is stable, there should be no problem).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
