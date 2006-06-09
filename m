Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWFIWiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWFIWiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWFIWiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:38:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60874 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751416AbWFIWiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:38:50 -0400
Date: Sat, 10 Jun 2006 00:38:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Daniel Drake <dsd@gentoo.org>
Cc: Jiri Benc <jbenc@suse.cz>, linville@tuxdriver.com,
       kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [patch] workaround zd1201 interference problem
Message-ID: <20060609223804.GB3252@elf.ucw.cz>
References: <20060607140045.GB1936@elf.ucw.cz> <20060607160828.0045e7f5@griffin.suse.cz> <20060607141536.GD1936@elf.ucw.cz> <4486FD2F.8040205@gentoo.org> <20060608070525.GE3688@elf.ucw.cz> <4489ECD0.1030908@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489ECD0.1030908@gentoo.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'll try to.

> >if you plug zd1201 into USB, it starts jamming radio,
> >immediately. Enable/disable, or iwlist wlan0 scan, or basically any
> >operation unjams the radio. This patch works it around:
> 
> Can we be any more specific?
> 
> What is the interference - is it transmitting random packets, or just 
> emitting a magical cloud of invisible anti-wifi?

Magical cloud, I'm afraid.

> At which precise point does the interference start? 

When the card is inserted.

> Does it happen even 
> without the driver loaded?

Will try.

> Which operation is the one which stops the interference, the enable or 
> the disable?

Disable alone was not enough to stop interference.

> Does this happen on every plug in, or just sometimes? 

In 70% or so.

> Is it affected by 
> usage patterns such as having the device plugged in throughout boot, 
> reloading the module, etc?

Will try.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
