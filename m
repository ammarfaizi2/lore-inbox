Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVB0Qy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVB0Qy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 11:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVB0Qy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 11:54:57 -0500
Received: from gprs215-59.eurotel.cz ([160.218.215.59]:5521 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261420AbVB0Qyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 11:54:32 -0500
Date: Sun, 27 Feb 2005 17:54:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michal Januszewski <spock@gentoo.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050227165420.GD1441@elf.ucw.cz>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050219230326.GB13135@kroah.com> <20050219232519.GC1372@elf.ucw.cz> <20050220132600.GA19700@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050220132600.GA19700@spock.one.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, I agree, almost anything is more sane than code I posted :-(. My
> > only requirement is that it works with radeonfb and similar low-level
> > drivers (so that I can get suspend-to-ram to work) and that it gets
> > past our branding people...   
> 
> I don't know about the branding people, but suspend-to-ram and radeonfb
> shouldn't be a problem for fbsplash :)
>  
> > How many distros do use some variant of bootsplash? SuSE does, from
> > above url I guess gentoo does, too... Does RedHat do something
> > similar? [Or do they just set log-level to very high giving them clean
> > look?] What about Debian?
> 
> As far as I know: SuSE uses bootsplash, Gentoo and PLD use fbsplash,
> RedHat uses rhgb (100% userspace solution, based on xvesa, doesn't
> provide graphical backgrounds on vt's - for that a kernel patch like
> bootsplash or fbsplash is necessary). I don't know about Debian - they
> probably have some (possibly unofficial) support for both bootsplash
> and fbsplash.

Well, I like rhgb the best (because it is 100% userspace and I do not
have to deal with it :-), but it seems like bootsplash should be
deprecated in favor of fbsplash.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
