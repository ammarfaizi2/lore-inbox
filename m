Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290784AbSART2g>; Fri, 18 Jan 2002 14:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290785AbSART2Z>; Fri, 18 Jan 2002 14:28:25 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:19942 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S290784AbSART2W>;
	Fri, 18 Jan 2002 14:28:22 -0500
Message-ID: <3C48774E.2020708@candelatech.com>
Date: Fri, 18 Jan 2002 12:28:14 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tulip driver bug in 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.40.0201181006410.27656-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:


> for me the same machine is rock solid with 2.4.5/8 (driver 0.9.14) but
> fails with 2.4.14/17 (driver 0.9.15-pre9)


Can you check if your 2.4.5/8 driver actually does 100bt-FD autonegotiation
correctly?  I believe it was broken during that time, and fixed in 2.4.9.
It's possible that that may have something to do with the problem, but
it's a stretch...

It might also be interesting to see if the working driver still works
if you forward port it into 2.4.17....

Ben


> 
> the failure is not at all traffic related, I have these boxes in
> production (only useing 3 of the 4 ports) with no problems at all, but on
> a box not connected to any network I can lock it up by just issuing an
> ifconfig.
> 
> it's possible that it's a PCI problem (if so can we back off the timing to
> what worked?), but I would expect the problem to be more variable if that
> was the case.
> 
> David Lang
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


