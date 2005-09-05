Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVIFM2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVIFM2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 08:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVIFM2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 08:28:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59275 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964838AbVIFM2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 08:28:19 -0400
Date: Mon, 5 Sep 2005 22:28:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Joerg Sommrey <jo@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20050905202831.GD2142@openzaurus.ucw.cz>
References: <20050901201434.GA8728@sommrey.de> <20050905145240.GB2142@openzaurus.ucw.cz> <20050905154311.GV5734@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905154311.GV5734@atomide.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +NOTE: Currently there's a bug somewhere where the reading the
> > > +      P_LVL2 for the first time causes the system to sleep instead of 
> > > +      idling. This means that you need to hit the power button once to
> > > +      wake the system after loading the module for the first time after
> > > +      reboot. After that the system idles as supposed.
> > > +      (Only observed on Tony's system.)
> > 
> > Could you fix this before merge?
> 
> I think this is some BIOS issue or hardware bug. It happens only on
> Tyan S2460. I tried dumping the registers few years ago on my
> Tyan s2460, but no luck.
> 
> Low chance for anybody fixing it...
> 

So at least DMI-blacklist it...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

