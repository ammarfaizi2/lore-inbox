Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290125AbSAQUGP>; Thu, 17 Jan 2002 15:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290332AbSAQUGG>; Thu, 17 Jan 2002 15:06:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:781 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290125AbSAQUFz>; Thu, 17 Jan 2002 15:05:55 -0500
Date: Thu, 17 Jan 2002 14:52:31 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [o(1) sched J0] higher priority smaller timeslices, in fact
In-Reply-To: <Pine.LNX.4.44.0201161412140.3787-100000@chemcca18.ucsd.edu>
Message-ID: <Pine.LNX.3.96.1020117144949.2890A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Alexei Podtelezhnikov wrote:

> I still suggest a different set as faster and more readable at least to 
> me. Just two operations instead of 4!
> 
> #define NICE_TO_TIMESLICE(n) (((n)+21)*(HZ/10))  // should be positive!
> #define MAX_TIMESLICE  NICE_TO_TIMESLICE(19)
> #define MIN_TIMESLICE  NICE_TO_TIMESLICE(-20)

Looks more readable. I wouldn't bet on faster, but definitely more
readable.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

