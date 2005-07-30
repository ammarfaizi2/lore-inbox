Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263103AbVG3TCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbVG3TCe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVG3TCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:02:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18916 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263103AbVG3TCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:02:33 -0400
Date: Sat, 30 Jul 2005 21:02:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: Re: -rc4: arm broken?
Message-ID: <20050730190229.GA2093@elf.ucw.cz>
References: <20050730130406.GA4285@elf.ucw.cz> <1122741937.7650.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122741937.7650.27.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I merged -rc4 into my zaurus tree, and now zaurus will not boot. I see
> > oops-like display, and it seems to be __call_usermodehelper /
> > do_execve / load_script related. Anyone seen it before?
> 
> For the record -rc4 works fine on my Zaurus c760 (which is pxa255 based
> rather than sa1100).
> 
> Does there problem look like http://lkml.org/lkml/2005/7/30/46 ?
> That
> shouldn't be in -rc4 but it in current git. I've sent a fix for this
> to

Yes, I was running -rc4-git, and yes, the problem looks really similar.

> Linus/Andrew and LKML but it hasn't appeared for some reason. A link to
> the fix is:
> http://www.rpsys.net/openzaurus/patches/2.6.13-rc3-mm3_fix-r0.patch

Hmm, I guess I really should not be running -preempt on zaurus. Thanks!

									Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
