Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965828AbWKNOYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965828AbWKNOYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 09:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965843AbWKNOYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 09:24:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7086 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965828AbWKNOYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 09:24:10 -0500
Date: Tue, 14 Nov 2006 15:23:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Stefan Seyfried <seife@suse.de>, Zan Lynx <zlynx@acm.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Message-ID: <20061114142353.GB2340@elf.ucw.cz>
References: <200611121436.46436.arvidjaar@mail.ru> <1163455396.9482.38.camel@localhost> <20061113225818.GG2760@suse.de> <200611140707.17935.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611140707.17935.arvidjaar@mail.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Maybe its a journal size thing, you could try "sync" before suspend and
> > > see if it helps.
> >
> > We already sync inside the kernel, it does not help here, though.
> > Blockdev freezing might help.
> 
> is there patch applicable to vanilla kernel? After repairing reiser several 
> times (due to hard lockups during suspend-to-RAM) that sounds even more 
> interesting.

Could you do the test Stefan asked? I do not think you'll kill
reiserfs by single forced powerdown.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
