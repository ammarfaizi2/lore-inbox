Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSGHBat>; Sun, 7 Jul 2002 21:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSGHBas>; Sun, 7 Jul 2002 21:30:48 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:7596 "EHLO grok.yi.org")
	by vger.kernel.org with ESMTP id <S316715AbSGHBar>;
	Sun, 7 Jul 2002 21:30:47 -0400
Message-ID: <3D28EBA6.8040400@candelatech.com>
Date: Sun, 07 Jul 2002 18:32:22 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
CC: Jason Lunz <lunz@gtf.org>, linux-kernel@vger.kernel.org
Subject: Re: NAPI patch against 2.4.18
References: <3D287DA4.5090904@candelatech.com> 	<20020707191517.GA14331@orr.falooley.org> <1026088234.1283.246.camel@tux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson wrote:
> On Sun, 2002-07-07 at 21:15, Jason Lunz wrote:
> 
>>greearb@candelatech.com said:
>>
>>>Does anyone have a working NAPI kernel and tulip driver patch against
>>>2.4.18 or so?  I will be happy to test this if so.
>>
>>Yes, I backported the core last week to 2.4.19-rc1 from 2.5.24, but the
>>patch ought to apply to 2.4.18 with only offset mismatches. I kept a lot
>>of style cleanups in the patch, but they should be easy to remove if
>>they cause problems. I'll be backporting the various napified drivers to
>>2.4 this week.
>>
>>http://orr.falooley.org/pub/linux/net/
> 
> 
> Why not use the original patch?
> 
> ftp://robur.slu.se/pub/Linux/net-development/NAPI/

The only patches I found there were about 6 months old, and the tulip
patch seems to be based on the tulip driver in 2.4.2.  The tulip driver
did not reach stability in the 2.4 series untill about 2.4.9, when it
finally started auto-negotiating correctly.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


