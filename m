Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUCZVql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUCZVql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:46:41 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:33013 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261263AbUCZVqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:46:36 -0500
Message-ID: <4064A4B7.5030103@mvista.com>
Date: Fri, 26 Mar 2004 13:46:31 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Praedor Atrebates <praedor@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: System clock speed too high - 2.6.3 kernel
References: <200403261430.18629.praedor@yahoo.com>
In-Reply-To: <200403261430.18629.praedor@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Praedor Atrebates wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
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

Try this in the boot command line "clock=pmtmr".  If that fails, then try 
"clock=pit".

-g
> 
> praedor
> - -- 
> "George W. Bush is a deserter, an election thief, a drunk driver, a WMD 
> liar and a functional illiterate. And he poops his pants." 
> - --Barbara Bush, his mother
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFAZITKSTapoRk9vv8RAkxyAJ45KBKN7ngdNX6qTOwSBIxEs7rfcACgl8e0
> 0lKo+bfaSHPcNpA+36WGCrE=
> =ZdjK
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

