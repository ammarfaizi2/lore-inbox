Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVBCWSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVBCWSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVBCWPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:15:33 -0500
Received: from gprs215-226.eurotel.cz ([160.218.215.226]:17612 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261825AbVBCWBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:01:13 -0500
Date: Thu, 3 Feb 2005 23:00:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Message-ID: <20050203220051.GA1098@elf.ucw.cz>
References: <200502021428.12134.rjw@sisk.pl> <20050203124006.GA18142@isilmar.linta.de> <20050203142057.GA1402@elf.ucw.cz> <200502032246.13057.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502032246.13057.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You may not run k8 notebook on max frequency on battery. Your system
> > will crash; and you might even damage battery.
> 
> When I don't compile in cpufreq, it seems to run at 1,8 GHz (the max)
> all the time, on AC power as well as on battery.  Along with what you're
> saying it leads to the conclusion that in fact I have to compile in cpufreq
> or I can damage the battery otherwise.  Is that right?

Yes.

[It is strange, k8 notebooks are supposed to boot at 800MHz. Older
arima prototype got it wrong and in 50% crashed during boot on battery
power. OTOH if your machine is stable at battery at 1.8GHz... well
then we'll have to search for other problem in cpufreq&resume....]

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
