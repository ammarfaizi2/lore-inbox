Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSFLGtb>; Wed, 12 Jun 2002 02:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317649AbSFLGta>; Wed, 12 Jun 2002 02:49:30 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:46227 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317648AbSFLGt3>;
	Wed, 12 Jun 2002 02:49:29 -0400
Message-ID: <3D06EEF3.3090103@candelatech.com>
Date: Tue, 11 Jun 2002 23:49:23 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pekka Savola <pekkas@netcore.fi>
CC: Mark Mielke <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <Pine.LNX.4.44.0206120930160.29780-100000@netcore.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pekka Savola wrote:

> On Tue, 11 Jun 2002, Ben Greear wrote:
> 
>>If they are useful to some people, and have zero performance affect on others
>>(due to being a configurable kernel feature), then what is your
>>complaint?
>>
> 
> 3) Added features and complexity makes it more difficult to maintain the 
> kernel (you could say this is a variant of 1)


Adding counters to structures generally is not going to increase
complexity (especially when you comment the code).  It would increase
the code size slightly.

The code to bump the counters should also be extremely simple
(surely we don't drop packets in more than just a few places).

So, in this case, the increase in complexity seems pretty minimal.


> 4) Patches that have only a little debugging/etc. value are probably 
> useful, but mainly for a specific set of people, and this would seem to be 
> best handled by external patches.


External-only patches almost always rot, and are extremely hard to really
share across organizations.  Still, point taken.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


