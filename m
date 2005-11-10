Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVKJKjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVKJKjV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 05:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVKJKjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 05:39:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62385 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750735AbVKJKjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 05:39:20 -0500
Date: Thu, 10 Nov 2005 11:38:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Todd Poynor <tpoynor@mvista.com>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051110103823.GB2401@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz> <4372B7A8.5060904@mvista.com> <20051110095050.GC2021@elf.ucw.cz> <1131616948.27347.174.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131616948.27347.174.camel@baythorne.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is there easy way to get at linux-mtd CVS? Attached is my current
> > version of sharp.c; map_read32/map_write32 was deleted thanks to
> > Richard Purdue.
> 
> http://www.linux-mtd.infradead.org/source.html has a reference to
> anoncvs.
> 
> I'd really prefer not to see sharp.c revived -- it's supposed to be
> dying, in favour of the CFI chipset drivers and jedec_probe code.
> Can we try to work out what's wrong with those, instead?

This is quite hard to debug -- I do not even have serial console for
collie, and I know nothing about mtd.

Another issue is that collie is in pretty poor state -- it never
worked in mainline. Getting it working in mainline, even with
deprecated sharp.c driver, would bea big plus as I should get
users/testers at that point.

That said... I can certainly do few experiments. Switching map_name
from "sharp" to "cfi" should be theoretically enough to get new code
up?
								Pavel
-- 
Thanks, Sharp!
