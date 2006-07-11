Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWGKVpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWGKVpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWGKVpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:45:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25036 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932132AbWGKVpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:45:30 -0400
Date: Tue, 11 Jul 2006 14:42:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Fredrik Roubert <roubert@df.lth.se>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Magic Alt-SysRq change in 2.6.18-rc1
Message-ID: <20060711124226.GB2474@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org> <20060710094414.GD1640@igloo.df.lth.se> <Pine.LNX.4.64.0607102356460.17704@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607102356460.17704@scrub.home>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Before 2.6.18-rc1, I used to be able to use it as follows:
> > >
> > > 	Press and hold an Alt key,
> > > 	Press and hold the SysRq key,
> > > 	Release the Alt key,
> > > 	Press and release some hot key like S or T or 7,
> > > 	Repeat the previous step as many times as desired,
> > > 	Release the SysRq key.
> > >
> > > This scheme doesn't work any more,
> > 
> > The SysRq code has been updated to make it useable with keyboards that
> > are broken in other ways than your. With the new behaviour, you should
> > be able to use Magic SysRq with your keyboard in this way:
> 
> Apparently it changes existing well documented behaviour, which is a 
> really bad idea.

(Actually, I do not care much if current approach stays or goes, but
many keyboards can't use sysrq as a modifier, and that needs to be
somehow solved. 2.6.18-rc1 behaviour provides a solution.)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
