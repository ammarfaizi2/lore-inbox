Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbULIU3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbULIU3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbULIU3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:29:39 -0500
Received: from gprs215-221.eurotel.cz ([160.218.215.221]:7296 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261602AbULIU3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:29:38 -0500
Date: Thu, 9 Dec 2004 21:29:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux@horizon.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [please test] 2.6.10-rc3 swsusp speedups
Message-ID: <20041209202920.GA1150@elf.ucw.cz>
References: <20041208155950.GC2292@openzaurus.ucw.cz> <20041209180305.28052.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209180305.28052.qmail@science.horizon.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can you do cat /proc/cmdline; echo -n disk >state; dmesg
> > and send me results?
> 
> Thanks for your help.  Here you go.  It literally logs nothing.


Ouch, I see it here, something is wrong with /sys interface. Can you
echo 4  > /proc/acpi/sleep instead?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
