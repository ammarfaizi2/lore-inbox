Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbULNJkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbULNJkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 04:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbULNJkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 04:40:15 -0500
Received: from gprs214-98.eurotel.cz ([160.218.214.98]:22656 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261469AbULNJkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 04:40:12 -0500
Date: Tue, 14 Dec 2004 10:39:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041214093954.GB1063@elf.ucw.cz>
References: <41BCD5F3.80401@kolivas.org> <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <20041214023651.GT16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214023651.GT16322@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	do_single_shot_in(delay);
> 
> The only other way would be to use the 64bit tsc as the only source for
> the system time (perhaps that's what you mean with the above
> pseudocode?). But the calibration code would need changes to allow
> that.

Yes, that's what I meant.

> Even before thinking at using the one-shot timer, I would like to
> fix the lost tick compensation of current production 2.6.9, only then we
> can talk about tickless by using a one-shot timer. If we can't do the
> lost-tick compensation without screwing the system time, I don't see how
> we can do the one-shot timer without screwing the system time.

Okay, I'll take a look.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
