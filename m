Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVAKDQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVAKDQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVAKDPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:15:03 -0500
Received: from gprs215-170.eurotel.cz ([160.218.215.170]:129 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262501AbVAKDNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:13:05 -0500
Date: Tue, 11 Jan 2005 04:12:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Bernard Blackham <bernard@blackham.com.au>, Shaw <shawv@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050111031252.GA4092@elf.ucw.cz>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com> <20050109224711.GF1353@elf.ucw.cz> <200501092328.54092.shawv@comcast.net> <20050110074422.GA17710@mussel> <20050110105759.GM1353@elf.ucw.cz> <20050110174804.GC4641@blackham.com.au> <20050111001426.GF1444@elf.ucw.cz> <1105405842.2941.1.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105405842.2941.1.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If I do cli(); sleep(5 hours); sti();, system should survive that. If
> > you do cli(); sleep(5 hours); sti() but fail to compensate for lost
> > ticks, all sorts of funny things might happen if you are comunicating
> > with someone who did not sleep.
> 
> Wouldn't a thread that did that be fundamentally broken?

Well, sleeping for 5 hours with interrupts off is certainly wrong
thing to do... But what swsusp does is pretty much equivalent. Machine
is unresponsive for hours...
								Pavelp

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
