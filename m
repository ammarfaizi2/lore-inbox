Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317547AbSFEFEi>; Wed, 5 Jun 2002 01:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317548AbSFEFEh>; Wed, 5 Jun 2002 01:04:37 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:55211 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317547AbSFEFEh>;
	Wed, 5 Jun 2002 01:04:37 -0400
Message-ID: <3CFD9B9C.1050906@candelatech.com>
Date: Tue, 04 Jun 2002 22:03:24 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020314 Netscape6/6.2.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: packets being dropped in IP stack but no error counts incrementing?
In-Reply-To: <3CFD01F8.B69152E4@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure the UDP drop counters are available.  If you do
find them, I'm interested in them too!

Chris Friesen wrote:

> I've been doing some testing on 2.4.18 and I'm seeing an interesting problem.
> 
> I have a test tool that simulates bursty UDP traffic by sending a bunch of
> messages and then delaying a while.   If I leave the receiving udp socket at its
> normal size, then I can get a significant number of messages just vanishing
> between the ethernet driver and the userspace socket.  The driver rx count shows
> that all packets were received, but the userspace program doesn't get all of
> them.  netstat/ifconfig/iproute2 rx dropped counts do not increase.
> 
> Is this design intent, are we messing a counter increment when dropping packets,
> or am I not looking at the right counter for these numbers?
> 
> Thanks,
> 
> Chris
> 
> 


-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

