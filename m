Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRDMNBI>; Fri, 13 Apr 2001 09:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRDMNA6>; Fri, 13 Apr 2001 09:00:58 -0400
Received: from iris.mc.com ([192.233.16.119]:43692 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S130532AbRDMNAk>;
	Fri, 13 Apr 2001 09:00:40 -0400
From: Mark Salisbury <mbs@mc.com>
To: yodaiken@fsmlabs.com, george anzinger <george@mvista.com>
Subject: Re: POSIX 52 53? 54
Date: Fri, 13 Apr 2001 08:46:14 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3AD66F56.A827E22@mvista.com> <20010412215323.A17007@hq.fsmlabs.com>
In-Reply-To: <20010412215323.A17007@hq.fsmlabs.com>
MIME-Version: 1.0
Message-Id: <0104130853521R.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

these are covered in IEEE P100.13, D9 September 1997 AD212.  it is available
from IEEE for a "nominal" fee.

they are 4 defined subsets of POSIX that are deemed appropriate for real-time
systems.

unfortunately, the sub in subset is a small delta from the full set.

the subsets are:
	PSE51: Minimal Realtime System Profile
	PSE52: Realtime Controller System Profile
	PSE53: Dedicated Realtime System Profile
	PSE54: Multi-purpose Realtime System Profile.

now, PSE51 is already about 90% of POSIX, so I don't really see what is so
minimal about it.  the others require even more.

On Thu, 12 Apr 2001, yodaiken@fsmlabs.com wrote:
> POSIX 1003.13 defines profiles 51-4 where 51 is a single POSIX
> process with multiple threads (RTLinux) and 54 is a full POSIX OS
> with the RT extensions (Linux).
> 
> On Thu, Apr 12, 2001 at 08:15:34PM -0700, george anzinger wrote:
> > Any one know any thing about a POSIX draft 52 or 53 or 54.  I think they
> > are suppose to have something to do with real time.
> > 
> > Where can they be found?  What do they imply for the kernel?
> > 
> > George
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> ---------------------------------------------------------
> Victor Yodaiken 
> Finite State Machine Labs: The RTLinux Company.
>  www.fsmlabs.com  www.rtlinux.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

