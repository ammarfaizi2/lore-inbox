Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWIXVpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWIXVpW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWIXVpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:45:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59275 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751600AbWIXVpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:45:19 -0400
Date: Sun, 24 Sep 2006 23:45:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Locke <matt@nomadgs.com>
Cc: linux-pm@lists.osdl.org, "Scott E. Preece" <preece@motorola.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Message-ID: <20060924214517.GA1935@elf.ucw.cz>
References: <200609222034.k8MKYoDK008487@olwen.urbana.css.mot.com> <20060923111805.GF20778@elf.ucw.cz> <6c3c9c9fa4961ca081c2742684201418@nomadgs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c3c9c9fa4961ca081c2742684201418@nomadgs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> >Well, two objections to that
> >
> >a) current powerop code does not handle 256 CPU machine, because that
> >would need 256 independend bundles, and powerop has hardcoded "only
> >one bundle" rule.
> 
> The 256 is only a temporary implementation limitation.

Really? 256 CPUs mean 2^256 states. How do you handle that without
introducing vectors?

> >b) having some devices controlled by powerop and some by specific
> >subsystem is indeed ugly. I'd hope powerop would cover all the
> >devices. (Or maybe cover _no_ devices). Userland should not need to
> >know if touchscreen is part of SoC or if it happens to be independend
> >on given machine.
> 
> PowerOP does *not* cover devices.  It covers system level parameters 
> such clocks, buses, voltages.

I've seen "usb enabled" in one of examples.. and that sure seems like
device to me.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
