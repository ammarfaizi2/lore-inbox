Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVCSANb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVCSANb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 19:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVCSANb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 19:13:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49124 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262188AbVCSAAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 19:00:25 -0500
Date: Sat, 19 Mar 2005 01:00:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: fix-u32-vs-pm_message_t-in-usb
Message-ID: <20050319000012.GG24449@elf.ucw.cz>
References: <20050310223353.47601d54.akpm@osdl.org> <20050311130831.GC1379@elf.ucw.cz> <20050318214335.GA17813@kroah.com> <20050318234440.GF24449@elf.ucw.cz> <20050318155313.60a4670f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318155313.60a4670f.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Care to just rediff off of 2.6.12-rc1?  Then we can hopefully get these
> >  > changes in :)
> > 
> >  I can do the rediff tommorow. I just hope there are not some other
> >  changis waiting in -mm to spoil this ;-).
> 
> I have a boatload of these darn pm_message_t patches floating about.  I
> don't know if they depend on Greg's stuff or not.
> 
> Should I just hose them at him?

I don't know what "hose" means in this context... Greg, can you take
those patches from Andrew? I think we managed to fix it right in his
tree.

								Pavel

> fix-pm_message_t-in-generic-code.patch
> fix-u32-vs-pm_message_t-in-usb.patch
> fix-u32-vs-pm_message_t-in-usb-fix.patch
> more-pm_message_t-fixes.patch
> fix-u32-vs-pm_message_t-confusion-in-oss.patch
> fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
> fix-u32-vs-pm_message_t-confusion-in-framebuffers.patch
> fix-u32-vs-pm_message_t-confusion-in-mmc.patch
> fix-u32-vs-pm_message_t-confusion-in-serials.patch
> fix-u32-vs-pm_message_t-in-macintosh.patch
> fix-u32-vs-pm_message_t-confusion-in-agp.patch
> 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
