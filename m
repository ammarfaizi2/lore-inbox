Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUJFMfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUJFMfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 08:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUJFMfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 08:35:23 -0400
Received: from gprs214-26.eurotel.cz ([160.218.214.26]:62080 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269243AbUJFMfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 08:35:16 -0400
Date: Wed, 6 Oct 2004 14:35:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steve M <stevenm@umd.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RadeonFB ACPI S3 patch fixed to not break S4. 2.6.8.1, 2.6.7
Message-ID: <20041006123503.GA19967@elf.ucw.cz>
References: <1096868582.10456.9.camel@stevenm-laptop.student.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096868582.10456.9.camel@stevenm-laptop.student.umd.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This applies to the patch written by Ole Rohne, ole.rohne_AT_cern.ch
> This applies to Radeon Mobility cards (mine is M9000 but it could work
> for others) on certain laptops that don't reinitialize the video BIOS
> upon resume (Mine is a Dell Insipron 600m but there are others).
> 
> This patch reinitializes the Radeon BIOS upon resume from an ACPI sleep
> state other than S4.
> 
> The original patch reinitialized the video bios from any ACPI resume,
> but this broke suspending to S4. The machine would begin to suspend,
> then the display would go dark and the system would become unresponsive.
> 
> I added an if statement to the part that patches radeon_pm.c so that it
> would NOT try to reinitialize the video BIOS if the machine is entering
> S4. This worked.

Ok.

> Given how much aggrivation this has given me, I figure submitting the
> new patch would be nice.

It needs to follow kernel coding style (see acpi sleep.c). On what
machine did you test it? I have machine (Arima) with radeon but ole's
patches did not work for me, I'll probably test this one too.

								Pavel 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
