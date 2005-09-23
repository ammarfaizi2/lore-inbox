Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVIWRmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVIWRmy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVIWRmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:42:54 -0400
Received: from mail.tmr.com ([64.65.253.246]:21139 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750848AbVIWRmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:42:54 -0400
Message-ID: <43343EBE.2070101@tmr.com>
Date: Fri, 23 Sep 2005 13:43:26 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: sean.bruno@dsl-only.net, ak@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: The system works (2.6.14-rc2): functional k8n-dl
References: <20050922155254.GE5910@us.ibm.com> <433303A9.6050909@tmr.com> <20050923171514.GF5910@us.ibm.com>
In-Reply-To: <20050923171514.GF5910@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:

>On 22.09.2005 [15:19:05 -0400], Bill Davidsen wrote:
>  
>
>>Nishanth Aravamudan wrote:
>>    
>>
>>>Hello all,
>>>      
>>>
>
><snip my long mail>
>
>  
>
>>>code in such a solid state. I have had only one complaint so far: it
>>>seems that the the "Broadcom Corporation NetXtreme BCM5751 Gigabit
>>>Ethernet PCI Express" adapter, with the tg3 driver, downs and ups the
>>>iface on MTU changes. Unfortunately, with some VPN software I use, it is
>>>sometimes necessary to drop the MTU to 1300 or so to get consistent
>>>connections. When I do this, though, ssh through the tunnel tends to not
>>>function. I have a workaround, where I bounce over a different laptop,
>>>but that's a bit of a pain (and that network adapter seems to be able to
>>>transiently change the MTU). Not a big deal, in any case.
>>>      
>>>
>>You can (or could in 2.4) sometimes play with the size for an individual 
>>IP by using the "mss" option of the old "route" command. That shouldn't 
>>glitch anything, it just should use little packets.
>>    
>>
>
>Yes, I see that still being an option. Let me go learn how to use route
>and see if that works better.
>  
>

route <destination_IP> gw <default_router_IP> mss 1200

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

