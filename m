Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVC1WTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVC1WTy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 17:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVC1WTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 17:19:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27533 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262091AbVC1WTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 17:19:34 -0500
Date: Tue, 29 Mar 2005 00:19:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jim Carter <jimc@math.ucla.edu>
Cc: linux-kernel@vger.kernel.org, hare@suse.de, seife@suse.de
Subject: Re: Disc driver is module, software suspend fails
Message-ID: <20050328221922.GD1389@elf.ucw.cz>
References: <Pine.LNX.4.61.0503242248530.7785@xena.cft.ca.us> <20050325081438.GA17245@elf.ucw.cz> <Pine.LNX.4.61.0503271623150.5513@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503271623150.5513@xena.cft.ca.us>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There's another feature that enables you to start resume manually with
> > some echo to /sys... Perhaps it needs to be documented better, I'm
> > looking for a patch ;-).
> 
> But how can it resume from a swap device for which it has no driver?

You insmod driver for your swap device, then you echo device numbers
to /sys... then initiate resume.

> Even if you copied the needed module(s) onto the swap device, the kernel
> needs the modules to be loaded before it can read anything.  The driver 
> would be there if resuming happened after the initrd loaded it.  But
> I wasn't able to make that actually work.

It should be possible, suse 9.3 does that...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
