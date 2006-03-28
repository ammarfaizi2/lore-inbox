Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWC1RPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWC1RPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWC1RPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:15:16 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:12744 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751131AbWC1RPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:15:15 -0500
Date: Tue, 28 Mar 2006 10:15:59 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, "Mark A. Greer" <mgreer@mvista.com>,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81 & m41t85 chips to m41t00 driver
Message-ID: <20060328171559.GA14170@mag.az.mvista.com>
References: <zt2d4LqL.1141645514.2993990.khali@localhost> <20060307170107.GA5250@mag.az.mvista.com> <20060318001254.GA14079@mag.az.mvista.com> <20060323210856.f1bfd02b.khali@linux-fr.org> <20060323203843.GA18912@mag.az.mvista.com> <20060324012406.GE9560@mag.az.mvista.com> <20060326145840.5e578fa4.akpm@osdl.org> <20060328002625.GE21077@mag.az.mvista.com> <20060327165120.35376d11.akpm@osdl.org> <20060328142114.e578cd7c.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328142114.e578cd7c.khali@linux-fr.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 02:21:14PM +0200, Jean Delvare wrote:
> Hi Mark, Andrew,
> 
> > Mark A. Greer wrote:
> > >
> > > Resend...
> > > ---
> > > 
> > >  drivers/i2c/chips/m41t00.c |  294 ++++++++++++++++++++++++++++++++++-----------
> > >  include/linux/m41t00.h     |   50 +++++++
> > 
> 
> Andrew Morton wrote:
> > Not sure what to make of this.  It has no changelog,

Oops.  My bad.

> > it doesn't apply on
> > top of your previous three patches:
> > 
> > rtc-m41t00-driver-should-use-workqueue-instead-of-tasklet.patch
> > rtc-m41t00-driver-cleanup.patch
> > rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch
> > 
> > and it doesn't apply when used to replace
> > rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch.
> 
> Replacing works for me, after also replacing the two first patches of
> the series with their new respective version. As for the changelog I
> picked the one from the original third patch.

Sorry for the confusion, Andrew.  The 3 patches I sent were all
replacement patches for the previous 3 patches.

> > An incremental patch against the three above patches would be ideal...

I would have done that but there wasn't a 2.6.16-mm2 patch yesterday
(that I see is there now) so I had nothing to diff against.

<snip>

> Mark, is it OK if this third patch adding the m41t81 and m41t85 support
> spends some time in Andrew's tree and only goes in mainline for 2.6.18,
> or do you need it in 2.6.17?

No, waiting is fine, Jean.

Thanks guys.

Mark
