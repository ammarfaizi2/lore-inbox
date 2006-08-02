Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWHBE2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWHBE2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWHBE2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:28:25 -0400
Received: from terminus.zytor.com ([192.83.249.54]:38633 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751140AbWHBE2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:28:25 -0400
Message-ID: <44D0296F.70707@zytor.com>
Date: Tue, 01 Aug 2006 21:26:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Dave Airlie <airlied@gmail.com>, Neil Horman <nhorman@tuxdriver.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <20060725174100.GA4608@hmsreliant.homelinux.net>	 <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>	 <20060725182833.GE4608@hmsreliant.homelinux.net>	 <44C66C91.8090700@zytor.com>	 <20060725192138.GI4608@hmsreliant.homelinux.net>	 <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org>	 <20060725194733.GJ4608@hmsreliant.homelinux.net>	 <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <1154490859.17171.12.camel@cog.beaverton.ibm.com>
In-Reply-To: <1154490859.17171.12.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> 
> Only lightly tested, so beware, and I've only added support so far for
> the TSC (so don't be surprised if you don't see a performance
> improvement if you using a different clocksource).
> 

We should be able to use HPET in userspace, too.

	-hpa
