Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWGCWts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWGCWts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWGCWts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:49:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28103 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932169AbWGCWtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:49:47 -0400
Date: Tue, 4 Jul 2006 00:49:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp regression
Message-ID: <20060703224936.GT1674@elf.ucw.cz>
References: <44A99DFB.50106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A99DFB.50106@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> when suspending machine with hyperthreading, only Freezing cpus appears and then
> it loops somewhere. 

Does it fail to freeze, or just lock up at that point?

Does it work okay in UP mode?

> I tried to catch some more info by pressing sysrq-p. Here
> are some captures:
> http://www.fi.muni.cz/~xslaby/sklad/03072006074.gif
> http://www.fi.muni.cz/~xslaby/sklad/03072006075.gif
> 
> It was working just perfect in 2.6.17-rcX-mmXs, but from 2.6.17-mmX times (maybe
> X>=3) it doesn't sleep anymore -- I may be lucky sometimes, and it is successful
> also in 2.6.17-mm5, but most time everything I get is Freezing and nothing is
> frozen but fishes in my fridge.

:-).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
