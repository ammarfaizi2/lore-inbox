Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293096AbSBWEpQ>; Fri, 22 Feb 2002 23:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293095AbSBWEpG>; Fri, 22 Feb 2002 23:45:06 -0500
Received: from bitmover.com ([192.132.92.2]:7831 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293094AbSBWEo5>;
	Fri, 22 Feb 2002 23:44:57 -0500
Date: Fri, 22 Feb 2002 20:44:56 -0800
From: Larry McVoy <lm@bitmover.com>
To: Justin Piszcz <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
Message-ID: <20020222204456.O11156@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Justin Piszcz <war@starband.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3C771D29.942A07C2@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C771D29.942A07C2@starband.net>; from war@starband.net on Fri, Feb 22, 2002 at 11:40:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try 2.72, it's almost twice as fast as 2.95 for builds.  For BK, at least,
we don't see any benefit from the slower compiler, the code runs the same
either way.

On Fri, Feb 22, 2002 at 11:40:09PM -0500, Justin Piszcz wrote:
> Wow, not sure if anyone here has done any benchmarks, but look at these
> build times:
> Kernel 2.4.17 did compile with 3.0.4, just much much slower than 2.95.3
> however.
> 
> GCC 2.95.3
> Boot sector 512 bytes.
> Setup is 2628 bytes.
> System is 899 kB
> make[1]: Leaving directory `/usr/src/linux-2.4.17/arch/i386/boot'
> 287.28user 23.99system 5:15.81elapsed 98%CPU (0avgtext+0avgdata
> 0maxresident)k
> 0inputs+0outputs (514864major+684661minor)pagefaults 0swaps
> 
> GCC 3.0.4
> Boot sector 512 bytes.
> Setup is 2628 bytes.
> System is 962 kB
> warning: kernel is too big for standalone boot from floppy
> make[1]: Leaving directory `/usr/src/linux-2.4.17/arch/i386/boot'
> 406.87user 28.38system 7:23.68elapsed 98%CPU (0avgtext+0avgdata
> 0maxresident)k
> 0inputs+0outputs (546562major+989237minor)pagefaults 0swaps
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
