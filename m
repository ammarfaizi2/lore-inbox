Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVACTyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVACTyG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVACTyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:54:06 -0500
Received: from gprs215-62.eurotel.cz ([160.218.215.62]:25319 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261648AbVACTxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:53:53 -0500
Date: Mon, 3 Jan 2005 20:47:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Francisco Martins <fmartins@di.fc.ul.pt>, linux-kernel@vger.kernel.org
Subject: Re: Suspend/resume to disk problem
Message-ID: <20050103194753.GA25250@elf.ucw.cz>
References: <1104715228.8402.34.camel@pad.di.fc.ul.pt> <20050103172459.GA4194@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103172459.GA4194@ip68-4-98-123.oc.oc.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm using Debian GNU/linux 3.1 with kernel 2.6.10 on my IBM Thinkpad
> > R40, and I'm experiencing a strange problem with suspend to disk.
> > 
> > If I configure the kernel options 
> > #
> > # Power management options (ACPI, APM)
> > #
> > CONFIG_PM=y
> > # CONFIG_PM_DEBUG is not set
> > CONFIG_SOFTWARE_SUSPEND=y
> > CONFIG_PM_STD_PARTITION="/dev/hda5",
> 
> AFAIK the typical way people do it (or at least what I'm doing, which
> isn't hitting this bug) is to set CONFIG_PM_STD_PARTITION to "" then to
> add (in your case) "resume=/dev/hda5" to the kernel boot command line.
> 
> This won't really fix your bug, but it should let you use swsusp in the
> meantime.

Perhaps its time for CONFIG_PM_STD_PARTITION to go away?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
