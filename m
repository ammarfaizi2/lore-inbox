Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263127AbVG3TXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbVG3TXu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbVG3TWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:22:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20950 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263126AbVG3TSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:18:39 -0400
Date: Sat, 30 Jul 2005 21:18:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -rc4: arm broken?
Message-ID: <20050730191835.GC2093@elf.ucw.cz>
References: <20050730130406.GA4285@elf.ucw.cz> <1122741937.7650.27.camel@localhost.localdomain> <20050730201508.B26592@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730201508.B26592@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I merged -rc4 into my zaurus tree, and now zaurus will not boot. I see
> > > oops-like display, and it seems to be __call_usermodehelper /
> > > do_execve / load_script related. Anyone seen it before?
> > 
> > For the record -rc4 works fine on my Zaurus c760 (which is pxa255 based
> > rather than sa1100).
> 
> It appears to work fine on Intel Assabet.

I had preempt enabled, and that's apparently broken in -rc4-git. I
turned off preempt and now it boots.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
