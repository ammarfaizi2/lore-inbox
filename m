Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWCVDhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWCVDhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 22:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWCVDhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 22:37:21 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:6305 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1750715AbWCVDhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 22:37:20 -0500
Date: Wed, 22 Mar 2006 05:37:18 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Chris Caputo <ccaputo@alt.net>
Cc: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org,
       erich@areca.com.tw
Subject: Re: New Areca driver in 2.6.16-rc6-mm2
Message-ID: <20060322033718.GA21614@mea-ext.zmailer.org>
References: <20060318044056.350a2931.akpm@osdl.org> <Pine.LNX.4.64.0603192016110.32337@mooru.gurulabs.com> <Pine.LNX.4.64.0603212345460.20655@nacho.alt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603212345460.20655@nacho.alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 11:49:32PM +0000, Chris Caputo wrote:
> On Sun, 19 Mar 2006, Dax Kelson wrote:
> > On Sat, 18 Mar 2006, Andrew Morton wrote:
> > > SCSI fixes
> > >
> > > +areca-raid-linux-scsi-driver-update4.patch
> > >
> > > Update areca-raid-linux-scsi-driver.patch
> > 
> > Has anyone had a chance to review this new update to see if it now passes
> > muster for mainline inclusion?
> 
> Unfortunately when the new driver is applied to 2.6.15.6 a bonnie++ test 
> results in the following endless spew:

Curious...   I didn't encounter this phenomena, but then, my 0.75 TB
raid5 volume is practically empty...

For the development phase it would be most useful, if  the driver
would be available in similar "this will compile for your currently
running kernel, or some other you care to name and have its config.h
files at hand"  as e.g. Nvidia drivers are (except that arcmsr is
in "all source form", whereas NV has this magic object blob..)

Such would allow (at least for me) to have a wee bit faster cycle 
with "pick vendor kernel, add this and that custom module"

I was apalled to learn that full cycle kernel compilation takes
_hours_ these days (Pentium-4 HT, 2.4 GHz, 2 GB memory -- and it
is about as slow as my first kernel compilation experience with
a 386/33MHz way back in ...)

>   ...
>   attempt to access beyond end of device
>   sdb1: rw=0, want=134744080, limit=128002016
>   ...
> 
> I have emailed the details to Erich.
> 
> Chris

/Matti Aarnio
