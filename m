Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVIEPnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVIEPnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVIEPnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:43:46 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:33228 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1751295AbVIEPnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:43:46 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 5 Sep 2005 18:43:11 +0300
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Joerg Sommrey <jo@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20050905154311.GV5734@atomide.com>
References: <20050901201434.GA8728@sommrey.de> <20050905145240.GB2142@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905145240.GB2142@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [050905 17:59]:
> Hi!
> 
> 
> > +NOTE: Currently there's a bug somewhere where the reading the
> > +      P_LVL2 for the first time causes the system to sleep instead of 
> > +      idling. This means that you need to hit the power button once to
> > +      wake the system after loading the module for the first time after
> > +      reboot. After that the system idles as supposed.
> > +      (Only observed on Tony's system.)
> 
> Could you fix this before merge?

I think this is some BIOS issue or hardware bug. It happens only on
Tyan S2460. I tried dumping the registers few years ago on my
Tyan s2460, but no luck.

Low chance for anybody fixing it...

Tony
