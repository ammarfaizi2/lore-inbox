Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUCZVXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbUCZVXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:23:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:61058 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261322AbUCZVWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:22:51 -0500
Subject: Re: System clock speed too high - 2.6.3 kernel
From: john stultz <johnstul@us.ibm.com>
To: Praedor Atrebates <praedor@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200403261430.18629.praedor@yahoo.com>
References: <200403261430.18629.praedor@yahoo.com>
Content-Type: text/plain
Message-Id: <1080336165.5408.307.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 26 Mar 2004 13:22:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-26 at 11:30, Praedor Atrebates wrote:
> In doing a web search on system clock speeds being too high, I found entries 
> describing exactly what I am experiencing in the linux-kernel list archives, 
> but have not yet found a resolution.
> 
> I have Mandrake 10.0, kernel-2.6.3-7mdk installed, on an IBM Thinkpad 1412 
> laptop, celeron 366, 512MB RAM.  I am finding that my system clock is ticking 
> away at a rate of about 3:1 vs reality, ie, I count ~3 seconds on the system 
> clock for every 1 real second.  I am running ntpd but this is unable to keep 
> up with the rate of system clock passage.  
> 
> I had to slow my keyboard repeat rate _way_ down in order to be able to type 
> at all as well.   The system is limited, in that I have no way to alter the 
> actual system clock (in bios at any rate).  The CPU is properly identified as 
> a celeron 366.  
> 
> Does anyone have any enlightenment, or a fix, to offer?  The exact same 
> software setup on a desktop system, Athlon XP2700+, has no such problems.

Could you please send me dmesg output for this system?

Does booting w/ "clock=pit" help?

thanks
-john


