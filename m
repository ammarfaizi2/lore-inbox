Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSHFQol>; Tue, 6 Aug 2002 12:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSHFQol>; Tue, 6 Aug 2002 12:44:41 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:61670 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313537AbSHFQok>;
	Tue, 6 Aug 2002 12:44:40 -0400
Message-ID: <3D4FFDBD.8070100@candelatech.com>
Date: Tue, 06 Aug 2002 09:47:57 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Robert Latham <robl@mcs.anl.gov>, linux-kernel@vger.kernel.org
Subject: Re: tigon3: 2466 and bad performance at 32bits/33mhz ?
References: <20020806053508.GJ25554@mcs.anl.gov> <20020806084840.GB32229@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Tue, Aug 06, 2002 at 12:35:08AM -0500, Robert Latham wrote:
> 
>>The fast curve is with the 3c996B-T in the 64/66 slot.  It peaks out
>>around 850 Mbps.  The slow curve is the same card in the 32/33 slot.
>>It peaks around 180 Mbps.
> 
> [snip]
> 
>>So, am i looking at a hardware limitation?  driver quirk?  I'm open to
>>any suggestions.  
> 
> 
> on a 32/33 slot, with a quad fast ethernet card, I can reach 400 Mbps
> on good hardware. The *theorical* bandwidth limit is 1.06 Gbps for
> 32 bits/33 Mhz. Of course, there's some overhead, but you would need 80%
> overhead to get you numbers, not very likely...
> 
> Perhaps this slot is on another bus, perhaps the latency timer is too
> low and the card receives small chunks at once, or perhaps this bus
> is shared with another hungry device ?
> 
> Regards,
> willy

I'm pushing 650Mbps on a 32/33 PCI bus using a Netgear GA620 GigE
card (the card supports 64bit PCI).  So, its not exactly a PCI bus
limitation you are hitting unless your PCI chipset somehow really
sucks.

Ben

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


