Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316981AbSF0Ues>; Thu, 27 Jun 2002 16:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316982AbSF0Uer>; Thu, 27 Jun 2002 16:34:47 -0400
Received: from flrtn-5-m1-95.vnnyca.adelphia.net ([24.55.70.95]:9641 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S316981AbSF0Ueq>;
	Thu, 27 Jun 2002 16:34:46 -0400
Message-ID: <3D1B7771.6000903@tmsusa.com>
Date: Thu, 27 Jun 2002 13:37:05 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 + O(1) scheduler
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org>	<20020626204721.GK22961@holomorphy.com>	<1025125214.1911.40.camel@localhost.localdomain>	<1025128477.1144.3.camel@icbm> <20020627005431.GM22961@holomorphy.com>	<1025192465.1084.3.camel@icbm> <20020627154712.GO22961@holomorphy.com> 	<3D1B5982.60008@PolesApart.dhs.org> <1025202738.1084.12.camel@icbm> <3D1B5F1D.2000706@PolesApart.wox.org> <3D1B7005.2090200@tmsusa.com> <3D1B7440.3040605@PolesApart.wox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre P. Nunes wrote:

>> That would be nice... but no -
>>
>> both -aa and -ac have it though, and it seems
>> solid, so maybe there's hope for 2.4 mainline
>> getting it eventually.
>>
>> Joe
>>
>>
>
> I said "not perfect" because a rather non-important benchmarking 
> called quake 3 seens a lot worse in pre10-ac2 with preemptive patches 
> when compared against -pre10 with preemptive patches: sound and screen 
> popped sometimes, like if there was a background task borrowing some 
> cpu, which was not the case, I mean, no other background tasks 
> compared with testing against -pre10. That was the only exception to 
> the above paragraph that I can remember of.

I am running -pre10-ac2 on one box - but also
the preemptive patch - are you running that?

On another box, I'm running -pre10aa4, which
also includes the low latency mini patch.

I also follow the q3a benchmark closely, and
RtCW as well. (The enemy is weakened!)

-ac + preempt and -aa both seem OK here, but
I prefer -aa since I use tux.

Joe



