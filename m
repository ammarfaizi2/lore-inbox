Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbULNLHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbULNLHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 06:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbULNLHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 06:07:09 -0500
Received: from gprs214-98.eurotel.cz ([160.218.214.98]:25473 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261483AbULNLHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 06:07:05 -0500
Date: Tue, 14 Dec 2004 12:06:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [ACPI][2.6.10-rc3][SUSPEND] S3 mode - Cannot resume from PCI devices
Message-ID: <20041214110648.GA2291@elf.ucw.cz>
References: <200412100315.21725.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412100315.21725.shawn.starr@rogers.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have netconsole configured I can see kernel messages on a remote machine, but when I suspend the laptop it goes into S3.
> I am unable to capture the (oops) the laptop when bringing it out of S3. It remains in a half suspended-unsuspended state.
> (the crescent moon LED is solidly on, video is back on (can see the 'Back to C!' string), cannot use sysctl key combos, 
> netconsole doesn't display the output since no PCI devices resume (the video is AGP onboard).
> 
> Is there any way I can capture this output somehow? I don't think even serial would work (it would be a USB to serial converter which would be PCI)
> or even trying to get this to print to lp0 since the laptop is totally unresponsive in its state.
> 
> I booted into single and sh for init, mounted /proc /sys and with no kernel modules it would fail to resume after suspending.
> 
> This isn't a nice regression.

So what was the last kernel where it worked?
										Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
