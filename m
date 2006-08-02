Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWHBEfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWHBEfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWHBEfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:35:01 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:28626 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751153AbWHBEe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:34:59 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: john stultz <johnstul@us.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Airlie <airlied@gmail.com>, Neil Horman <nhorman@tuxdriver.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <44D0296F.70707@zytor.com>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>
	 <20060725182833.GE4608@hmsreliant.homelinux.net>
	 <44C66C91.8090700@zytor.com>
	 <20060725192138.GI4608@hmsreliant.homelinux.net>
	 <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org>
	 <20060725194733.GJ4608@hmsreliant.homelinux.net>
	 <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com>
	 <1154490859.17171.12.camel@cog.beaverton.ibm.com>
	 <44D0296F.70707@zytor.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 21:34:52 -0700
Message-Id: <1154493292.17171.15.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 21:26 -0700, H. Peter Anvin wrote:
> john stultz wrote:
> > 
> > Only lightly tested, so beware, and I've only added support so far for
> > the TSC (so don't be surprised if you don't see a performance
> > improvement if you using a different clocksource).
> > 
> 
> We should be able to use HPET in userspace, too.

Oh yes, HPET and Cyclone as well. It just requires mapping their mmio
page as user readable. I just haven't gotten to it yet. :)

-john

