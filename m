Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133074AbRDWNc0>; Mon, 23 Apr 2001 09:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133073AbRDWNcQ>; Mon, 23 Apr 2001 09:32:16 -0400
Received: from iris.mc.com ([192.233.16.119]:10464 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S133074AbRDWNcE>;
	Mon, 23 Apr 2001 09:32:04 -0400
From: Mark Salisbury <mbs@mc.com>
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>,
        george anzinger <george@mvista.com>
Subject: Re: No 100 HZ timer!
Date: Mon, 23 Apr 2001 09:22:09 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AE3FE79.9982.6C4B69@localhost>
In-Reply-To: <3AE3FE79.9982.6C4B69@localhost>
MIME-Version: 1.0
Message-Id: <01042309311509.00685@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001, Ulrich Windl wrote:
> IMHO the POSIX is doable to comply with POSIX. Probably not what many 
> of the RT freaks expect, but doable. I'm tuning the nanoseconds for a 
> while now...
> 
> Ulrich

thanks for calling me a freak :)

yes, linux could have posix timers cobbled on today and comply with the POSIX
spec.

but, we would like to make it better, not just feature complete.

10ms timer resolutions, while completely in compliance w/ the posix spec, are
completely useless for "RT freaks" 

remember that 95% of all computers in the world are embedded and of those most
nead at least "soft" RT behavior.  seems like a good growth market for linux to
me.

when a PPC G4 is capable of 30 nanosecond resolution, why would you want to
settle for 10 millisecond  (30 billionths of a second vs 10 thousandths for
those of you who haven't had to familiarize yourselves with sub-second time
units)

> 
> On 17 Apr 2001, at 11:53, george anzinger wrote:
> 
> > I was thinking that it might be good to remove the POSIX API for the
> > kernel and allow a somewhat simplified interface.  For example, the user
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

