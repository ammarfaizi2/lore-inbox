Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbULMMKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbULMMKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbULMMKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:10:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6873 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262236AbULMMKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:10:43 -0500
Date: Fri, 10 Dec 2004 15:20:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI][2.6.10-rc3][SUSPEND] S3 mode - Cannot resume from PCI devices
Message-ID: <20041210142010.GA3654@openzaurus.ucw.cz>
References: <200412100315.21725.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412100315.21725.shawn.starr@rogers.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have netconsole configured I can see kernel messages on a remote machine, but when I suspend the laptop it goes into S3.
> I am unable to capture the (oops) the laptop when bringing it out of S3. It remains in a half suspended-unsuspended state.
> (the crescent moon LED is solidly on, video is back on (can see the 'Back to C!' string), cannot use sysctl key combos, 
> netconsole doesn't display the output since no PCI devices resume (the video is AGP onboard).
> 
> Is there any way I can capture this output somehow? I don't think even serial would work (it would be a USB to serial converter which would be PCI)

If you can see Back to C, your video works, just capture oops
with paper and pencil.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

