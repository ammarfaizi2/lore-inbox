Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUFXQ4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUFXQ4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUFXQ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:56:54 -0400
Received: from holomorphy.com ([207.189.100.168]:59274 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266188AbUFXQ4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:56:51 -0400
Date: Thu, 24 Jun 2004 09:56:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624165629.GG21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
	Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
	discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20040623213643.GB32456@hygelac> <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624165200.GM30687@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 01:48:47AM +1000, Nick Piggin wrote:
>> 2.6 has the "incremental min" thing. What is wrong with that?
>> Though I think it is turned off by default.

On Thu, Jun 24, 2004 at 06:52:01PM +0200, Andrea Arcangeli wrote:
> sysctl_lower_zone_protection is an inferior implementation of the
> lower_zone_reserve_ratio, inferior because it has no way to give a
> different balance to each zone. As you said it's turned off by default
> so it had no tuning. The lower_zone_reserve_ratio has already been
> tuned in 2.4. Somebody can attempt a conversion but it'll never be equal
> since lower_zone_reserve_ratio is a superset of what
> sysctl_lower_zone_protection can do.

Is there any chance you could send in thise improved implementation of
zone fallback watermarks and describe the deficiencies in the current
scheme that it corrects?

Thanks.


-- wli
