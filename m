Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291141AbSAaQdr>; Thu, 31 Jan 2002 11:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291142AbSAaQdh>; Thu, 31 Jan 2002 11:33:37 -0500
Received: from ip68-3-104-241.ph.ph.cox.net ([68.3.104.241]:26532 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S291141AbSAaQdd>;
	Thu, 31 Jan 2002 11:33:33 -0500
Message-ID: <3C597199.6050301@candelatech.com>
Date: Thu, 31 Jan 2002 09:32:25 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Robbert Kouprie <robbert@jvb.tudelft.nl>, linux-kernel@vger.kernel.org
Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
In-Reply-To: <20020130220659.29bd66f5.skraw@ithnet.com>	<002a01c1a9ee$1b6ddd20$020da8c0@nitemare> <20020131133516.68c78352.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What does the rest of the hardware-config look like?  Is
the NIC attached to a 10bt hub?  Are you using PCI-Riser
cards?

Stephan von Krawczynski wrote:

> On Thu, 31 Jan 2002 01:27:47 +0100
> "Robbert Kouprie" <robbert@jvb.tudelft.nl> wrote:
> 
> 
>>Thanks for your reaction Stephan, but I seriously doubt the change below
>>would fix the problem... Also, as the problem appears randomly, and
>>usually after some uptime, I obviously can not know about it being fixed
>>if I constantly upgrade the kernel. I'd rather wait and see if it
>>appears again in time after I did a kernel upgrade, and not trying every
>>-pre while there's no mention on the mailing list of such bug being
>>fixed.
>>
>>Anyway, I just rebooted with 2.4.18-pre7-ac1, we'll see if it helps.
>>
> 
> Hello Robert,
> 
> Well, I know the changes to the driver are rather ... small :-)
> But on the other hand, I would not be all that sure that the bug is a
> hundred percent related to the driver itself.
> I run a working config with eepro100-driver, btw.
> 
> Regards,
> Stephan
> 
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


