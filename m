Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290819AbSARUyI>; Fri, 18 Jan 2002 15:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSARUx7>; Fri, 18 Jan 2002 15:53:59 -0500
Received: from [208.29.163.248] ([208.29.163.248]:12025 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S290819AbSARUxp>; Fri, 18 Jan 2002 15:53:45 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 18 Jan 2002 12:52:42 -0800 (PST)
Subject: Re: Tulip driver bug in 2.4.17 (fwd)
In-Reply-To: <3C48774E.2020708@candelatech.com>
Message-ID: <Pine.LNX.4.40.0201181251310.27656-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Ben Greear wrote:

> It might also be interesting to see if the working driver still works
> if you forward port it into 2.4.17....
>

I copied the drivers/net directory from 2.4.4 (tulip driver 0.4.14e) and
it results in the same lockup on 2.4.17 as the new driver.

what can I do to turn on more logging here?

David Lang

> Ben
>
>
> >
> > the failure is not at all traffic related, I have these boxes in
> > production (only useing 3 of the 4 ports) with no problems at all, but on
> > a box not connected to any network I can lock it up by just issuing an
> > ifconfig.
> >
> > it's possible that it's a PCI problem (if so can we back off the timing to
> > what worked?), but I would expect the problem to be more variable if that
> > was the case.
> >
> > David Lang
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
>
>
> --
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>
>
