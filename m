Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316305AbSEODER>; Tue, 14 May 2002 23:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316306AbSEODEQ>; Tue, 14 May 2002 23:04:16 -0400
Received: from [66.89.142.11] ([66.89.142.11]:38360 "EHLO exalane.intransa.com")
	by vger.kernel.org with ESMTP id <S316305AbSEODEP>;
	Tue, 14 May 2002 23:04:15 -0400
Message-ID: <3CE1D007.6060309@candelatech.com>
Date: Tue, 14 May 2002 20:03:35 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020314 Netscape6/6.2.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jennifer Huang <carrothh@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question about network card.
In-Reply-To: <20020514215151.54784.qmail@web20102.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2002 03:04:10.0113 (UTC) FILETIME=[2F206F10:01C1FBBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can look at /proc/net/dev to see the various network driver counters...that should
tell you something...

Ben

Jennifer Huang wrote:

> Hi,
> 
> I am not sure if this is the correct place to ask this
> question.
> 
> I wrote a traffic generator and tried to send traffic
> to a linux box. I found that when I generated more
> than 100Mbps traffic from multi-senders to the
> receiver, tcpdump can see nothing at the receiver
> side. The network card is 100Mbps. 
> 
> My questions are:
> 
> 1. What will happen if there are more than 100Mbps
> traffic dumped to a 100Mbps network card? Is it
> possible that the card drop most of the packets?
> 
> 2. Does it look like my traffic generator problem? Do
> I need to set particular socket options?
> 
> Thanks,
> -Jenny
> 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> LAUNCH - Your Yahoo! Music Experience
> http://launch.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

