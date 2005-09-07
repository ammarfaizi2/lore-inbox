Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVIGPSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVIGPSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVIGPSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:18:24 -0400
Received: from bender.bawue.de ([193.7.176.20]:60133 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S932168AbVIGPSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 11:18:23 -0400
Date: Wed, 7 Sep 2005 17:18:03 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20050907151803.GA29871@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@suse.cz>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050901201434.GA8728@sommrey.de> <20050905145240.GB2142@openzaurus.ucw.cz> <20050905154311.GV5734@atomide.com> <20050905202831.GD2142@openzaurus.ucw.cz> <20050907070000.GA5804@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907070000.GA5804@atomide.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 10:00:01AM +0300, Tony Lindgren wrote:
> * Pavel Machek <pavel@suse.cz> [050906 15:28]:
> > Hi!
> > 
> > > > > +NOTE: Currently there's a bug somewhere where the reading the
> > > > > +      P_LVL2 for the first time causes the system to sleep instead of 
> > > > > +      idling. This means that you need to hit the power button once to
> > > > > +      wake the system after loading the module for the first time after
> > > > > +      reboot. After that the system idles as supposed.
> > > > > +      (Only observed on Tony's system.)
> > > > 
> > > > Could you fix this before merge?
> > > 
> > > I think this is some BIOS issue or hardware bug. It happens only on
> > > Tyan S2460. I tried dumping the registers few years ago on my
> > > Tyan s2460, but no luck.
> > > 
> > > Low chance for anybody fixing it...
> > > 
> > 
> > So at least DMI-blacklist it...
> 
> I rarely have access to that hardware, so don't count on me doing
> this...
> 
I'm unable to do this neither.  Looks like this won't be fixed.

-jo

-- 
-rw-r--r--  1 jo users 63 2005-09-06 20:21 /home/jo/.signature
