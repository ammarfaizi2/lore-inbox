Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312380AbSDXQSf>; Wed, 24 Apr 2002 12:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSDXQSe>; Wed, 24 Apr 2002 12:18:34 -0400
Received: from ip68-3-16-134.ph.ph.cox.net ([68.3.16.134]:59527 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S312380AbSDXQSe>;
	Wed, 24 Apr 2002 12:18:34 -0400
Message-ID: <3CC6DAD8.2010502@candelatech.com>
Date: Wed, 24 Apr 2002 09:18:32 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: jd@epcnet.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VLAN and Network Drivers 2.4.x
In-Reply-To: <718111768.avixxmail@nexxnet.epcnet.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers work, more are being fixed.  Others have to be
patched.  All work if you set the MTU of the link to 1496.

We can use testing of patched drivers, so if you do patch any
and have good results, then let us know and the driver changes might
get pushed into the kernel sooner.

Ben

jd@epcnet.de wrote:

> Hi,
> 
> why is a there a experimental VLAN option in the stable 2.4.x-kernel, when it's useless without patching Network Drivers?
> 
> Why isn't there a solution for all network drivers to accept frames 4 bytes longer on request of e.g. vconfig (like ifconfig setting promiscious mode on/off) ? Or to deny vconfig to add a vlan, if the network driver/hardware doesn't support this?
> 
> Today the situation is as follows: The experimental VLAN-option is useless, if i dont patch my network drivers, otherwise there is no working VLAN function.
> 
> Any future plans?
> 
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


