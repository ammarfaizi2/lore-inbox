Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293097AbSBWFOk>; Sat, 23 Feb 2002 00:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293099AbSBWFOV>; Sat, 23 Feb 2002 00:14:21 -0500
Received: from c9mailgw.prontomail.com ([216.163.188.209]:33551 "EHLO
	C9Mailgw08.amadis.com") by vger.kernel.org with ESMTP
	id <S293097AbSBWFOL>; Sat, 23 Feb 2002 00:14:11 -0500
Message-ID: <3C7724FE.62001ABE@starband.net>
Date: Sat, 23 Feb 2002 00:13:34 -0500
From: Justin Piszcz <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
In-Reply-To: <3C771D29.942A07C2@starband.net> <20020222204456.O11156@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh! Thanks for the information.

Larry McVoy wrote:

> Try 2.72, it's almost twice as fast as 2.95 for builds.  For BK, at least,
> we don't see any benefit from the slower compiler, the code runs the same
> either way.
>
> On Fri, Feb 22, 2002 at 11:40:09PM -0500, Justin Piszcz wrote:
> > Wow, not sure if anyone here has done any benchmarks, but look at these
> > build times:
> > Kernel 2.4.17 did compile with 3.0.4, just much much slower than 2.95.3
> > however.
> >
> > GCC 2.95.3
> > Boot sector 512 bytes.
> > Setup is 2628 bytes.
> > System is 899 kB
> > make[1]: Leaving directory `/usr/src/linux-2.4.17/arch/i386/boot'
> > 287.28user 23.99system 5:15.81elapsed 98%CPU (0avgtext+0avgdata
> > 0maxresident)k
> > 0inputs+0outputs (514864major+684661minor)pagefaults 0swaps
> >
> > GCC 3.0.4
> > Boot sector 512 bytes.
> > Setup is 2628 bytes.
> > System is 962 kB
> > warning: kernel is too big for standalone boot from floppy
> > make[1]: Leaving directory `/usr/src/linux-2.4.17/arch/i386/boot'
> > 406.87user 28.38system 7:23.68elapsed 98%CPU (0avgtext+0avgdata
> > 0maxresident)k
> > 0inputs+0outputs (546562major+989237minor)pagefaults 0swaps
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> --
> ---
> Larry McVoy              lm at bitmover.com           http://www.bitmover.com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

