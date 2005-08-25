Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVHYGPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVHYGPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVHYGPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:15:47 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:40346 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S1751207AbVHYGPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:15:46 -0400
Message-ID: <430D620A.6050204@candelatech.com>
Date: Wed, 24 Aug 2005 23:15:38 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
References: <20050825060843.15874.qmail@web33311.mail.mud.yahoo.com>
In-Reply-To: <20050825060843.15874.qmail@web33311.mail.mud.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:
> 
> --- Ben Greear <greearb@candelatech.com> wrote:
> 
> 
>>Danial Thom wrote:
>>
>>
>>>I think the concensus is that 2.6 has made
>>
>>trade
>>
>>>offs that lower raw throughput, which is what
>>
>>a
>>
>>>networking device needs. So as a router or
>>>network appliance, 2.6 seems less suitable. A
>>
>>raw
>>
>>>bridging test on a 2.0Ghz operton system:
>>>
>>>FreeBSD 4.9: Drops no packets at 900K pps
>>>Linux 2.4.24: Starts dropping packets at 350K
>>
>>pps
>>
>>>Linux 2.6.12: Starts dropping packets at 100K
>>
>>pps
>>
>>I ran some quick tests using kernel 2.6.11, 1ms
>>tick (HZ=1000), SMP kernel.
>>Hardware is P-IV 3.0Ghz + HT on a new
>>SuperMicro motherboard with 64/133Mhz
>>PCI-X bus.  NIC is dual Intel pro/1000.  Kernel
>>is close to stock 2.6.11.

> What GigE adapters did you use? Clearly every
> driver is going to be different. My experience is
> that a 3.4Ghz P4 is about the performance of a
> 2.0Ghz Opteron. I have to try your tuning script
> tomorrow.

Intel pro/1000, as I mentioned.  I haven't tried any other
NIC that comes close in performance to the e1000.

> If your test is still set up, try compiling
> something large while doing the test. The drops
> go through the roof in my tests.

Installing RH9 on the box now to try some tests...

Disk access always robs networking, in my experience, so
I am not supprised you see bad ntwk performance while
compiling.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

