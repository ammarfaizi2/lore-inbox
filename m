Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVHJUAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVHJUAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVHJUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:00:10 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:8979 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030229AbVHJUAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:00:09 -0400
Message-ID: <42FA5DD7.4030901@tmr.com>
Date: Wed, 10 Aug 2005 16:04:39 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim MacBaine <jmacbaine@gmail.com>
CC: ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
References: <200508031559.24704.kernel@kolivas.org>	<200508040716.24346.kernel@kolivas.org>	<3afbacad050803152226016790@mail.gmail.com>	<200508040852.10224.kernel@kolivas.org>	<3afbacad0508032234f9af1f3@mail.gmail.com> <3afbacad05080323596b39e9eb@mail.gmail.com>
In-Reply-To: <3afbacad05080323596b39e9eb@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim MacBaine wrote:
> I just borrowed a power meter to see (or not to see) real effects of
> dyntick. The difference between static 1000 HZ and dynamic HZ is much
> less than I expected, only a very little about noise.  With dyntick
> disabled at 1000 HZ my laptop needs 31,3 W.  With dyntick enabled I
> get 29.8 W, the pmstats-0.2 script shows me that the system is at
> 35-45 HZ when it is idle.
> 
> The power consumption difference between 250 HZ static and dyntick is
> below the noise, so maybe hardly worth all the struggle.

I think it's the other way round, we have the lower power without the 
higher latency. At least as I can measure...

Bravo to all concerned to get this to the testing stage!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
