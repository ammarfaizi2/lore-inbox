Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268913AbRHHTzq>; Wed, 8 Aug 2001 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269018AbRHHTzh>; Wed, 8 Aug 2001 15:55:37 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:18450 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S268913AbRHHTz0>;
	Wed, 8 Aug 2001 15:55:26 -0400
Date: Wed, 8 Aug 2001 13:51:43 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Scalable Scheduling
Message-ID: <20010808135143.A8426@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF320F8ECC.3EB12A09-ON85256AA2.006BF096@pok.ibm.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 03:40:00PM -0400, Hubertus Franke wrote:
> 
> We did not modify the UP code at all. There will be NO effects (positive
> nor negative) what so ever.

Cool. So the obvious next question is 
	How does it compare on a dual to the current Linux scheduler?

Obviously:
	Performance sucks on two processors but scales well

would not be a good thing.


> 
> Hubertus Franke
> Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
> , OS-PIC (Chair)
> email: frankeh@us.ibm.com
> (w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003
> 
> 
> 
> Victor Yodaiken <yodaiken@fsmlabs.com> on 08/08/2001 03:27:55 PM
> 
> To:   Mike Kravetz <mkravetz@sequent.com>
> cc:   Linus Torvalds <torvalds@transmeta.com>, Hubertus
>       Franke/Watson/IBM@IBMUS, linux-kernel@vger.kernel.org
> Subject:  Re: [RFC][PATCH] Scalable Scheduling
> 
> 
> 
> On Wed, Aug 08, 2001 at 11:28:00AM -0700, Mike Kravetz wrote:
> > One challenge will be maintaining the same level of performance
> > for UP as in the current code.  The current code has #ifdefs to
> 
> How does the "current code" compare to the current Linux UP code?
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
