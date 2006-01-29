Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWA2PMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWA2PMh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 10:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWA2PMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 10:12:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11993 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750811AbWA2PMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 10:12:36 -0500
Date: Sun, 29 Jan 2006 16:12:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marc <marvin24@gmx.de>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: patching arm-linux 2.4.18 on sharp zaurus sl-5500
Message-ID: <20060129151221.GB1764@elf.ucw.cz>
References: <a76b68304d1cadc77190142ba67324a6@cs.pitt.edu> <20060127143832.GG3673@harddisk-recovery.com> <200601272030.24079.marvin24@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601272030.24079.marvin24@gmx.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > We are a group of researchers at University of Pittbsurgh trying to
> > > implement an ad-hoc routing protocol on the Sharp Zaurus 5500 pda.  Our
> > > network is running the following environment:
> > >       -arm-linux kernel 2.4.18-pxa3-embedix-021129
> >
> > ncftp /pub/linux/kernel/v2.4 > dir patch-2.4.18.bz2
> > -rw-rw-r--    1 536      536       826105   Feb 25  2002   
> > patch-2.4.18.bz2
> >
> > Any particular reason why you're using a 4 year old kernel?
> >
> > >       -OpenZaurus 3.5.1
> 
> as far as I know, OpenZaurus 3.5.4 is comming soon, but the standard kernel is 
> still 2.4.18-xyz. The Zaurus 5500 was not ported to newer kernels, because 
> the implementation from sharp/lineo was just to ugly. Instead a direct 2.6 
> port was started but not finished up to now (see 
> http://www.cs.wisc.edu/~lenz/zaurus).

Actually we are way better now. Latest 2.6 is close to booting on
zaurus, missing pieces are proper mtd support (hacky patch is
available, and proper patch works read-only), touchscreen and battery charging.

> Pavel Machek has send some patches recently to lkml for the 2.6 kernel, but I 
> don't know what the status is right now.

Aha :-). I ran out of time, I should have some more time for Zaurus in
3 weeks or so. Extra developers would be nice :-).
								Pavel

-- 
Thanks, Sharp!
