Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVB0TmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVB0TmF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 14:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVB0TmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 14:42:05 -0500
Received: from gprs215-59.eurotel.cz ([160.218.215.59]:22705 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261477AbVB0Tlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 14:41:50 -0500
Date: Sun, 27 Feb 2005 20:41:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Arjan van de Ven <arjan@infradead.org>, aj@suse.de
Cc: Michal Januszewski <spock@gentoo.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050227194123.GX1441@elf.ucw.cz>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050219230326.GB13135@kroah.com> <20050219232519.GC1372@elf.ucw.cz> <20050220132600.GA19700@spock.one.pl> <20050227165420.GD1441@elf.ucw.cz> <1109532700.15362.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109532700.15362.42.camel@laptopd505.fenrus.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I like rhgb the best (because it is 100% userspace and I do not
> > have to deal with it :-), but it seems like bootsplash should be
> > deprecated in favor of fbsplash.
> 
> well.. how much does it really need in kernel space? I mean, with all
> drivers as modules, and the "quiet" option, initramfs runs *really*
> fast. And that can just bang a bitmap to the framebuffer as first
> thing... (rhgb does it a bit later but that's a design choice in a
> feature vs early-boot tradeoff).

[aj added to the list].

Andreas, who is the person to talk about this? I like redhat's
solution the best. Pass "quiet", perhaps replace penguin with some big
picture including penguin and chameleon or something, and do the
interesting work in userspace...

That's the best solution, technically... Perhaps it is even acceptable
politically?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
