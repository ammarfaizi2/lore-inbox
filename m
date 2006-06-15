Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031371AbWFOVBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031371AbWFOVBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 17:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031369AbWFOVBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 17:01:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18882 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1031363AbWFOVA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 17:00:59 -0400
Date: Thu, 15 Jun 2006 23:00:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Daniel Drake <dsd@gentoo.org>
Cc: Jiri Benc <jbenc@suse.cz>, linville@tuxdriver.com,
       kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [patch] workaround zd1201 interference problem
Message-ID: <20060615210011.GA2232@elf.ucw.cz>
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

> Pavel Machek wrote:
> >if you plug zd1201 into USB, it starts jamming radio,
> >immediately. Enable/disable, or iwlist wlan0 scan, or basically any
> >operation unjams the radio. This patch works it around:
> 
> Can we be any more specific?
> 
> At which precise point does the interference start? Does it happen even 
> without the driver loaded?
> 
> Which operation is the one which stops the interference, the enable or 
> the disable?

enable alone is enough to stop the interference, but leaving card
enabled after load seems like a dirty hack.

> Does this happen on every plug in, or just sometimes? Is it affected by 
> usage patterns such as having the device plugged in throughout boot, 
> reloading the module, etc?

If I remove the firmware file, interference does not start... that
should be close to "not having module loaded".

I think I've answered all the questions now? :-).

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
