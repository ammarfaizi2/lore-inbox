Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbULMTnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbULMTnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbULMTlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:41:16 -0500
Received: from gprs215-167.eurotel.cz ([160.218.215.167]:3968 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262286AbULMTEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 14:04:47 -0500
Date: Mon, 13 Dec 2004 20:04:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Stefan Seyfried <seife@suse.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Message-ID: <20041213190414.GA1052@elf.ucw.cz>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <41BD483B.1000704@suse.de> <20041213135820.A24748@flint.arm.linux.org.uk> <1102949565.2687.2.camel@localhost.localdomain> <20041213162355.E24748@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213162355.E24748@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Lets take an example.  Lets say that:
> > > * a CPU runs at about 245mA when active
> > > * 90mA when inactive
> > > * the timer interrupt takes 2us to execute 1000 times a second
> > > * no other processing is occuring
> > 
> > Now take a real laptop and the numbers are in the 20W (15A) range.
> 
> Roughly 650mA for my laptop while idle or just under 7W - by calculation
> from battery capacity and measured lifetime.  The question is how much
> of that is due to the CPU itself and how much is due to the
> peripherals.

On Arima notebook here, whole machine takes 28W on 800MHz, idle
(measured using external power meter), 33W with max backlight, and 68W
at 2GHz, computing. Going to HZ=100 makes it one Watt less. I'd say
that's quite significant. [17W number was based on internal power
meter when running on battery].

So yes, CPU *is* taking more than all other perihepals.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
