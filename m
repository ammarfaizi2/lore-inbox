Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSLTSVd>; Fri, 20 Dec 2002 13:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSLTSVd>; Fri, 20 Dec 2002 13:21:33 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:41375 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264745AbSLTSVb>;
	Fri, 20 Dec 2002 13:21:31 -0500
Message-ID: <3E036186.3020200@candelatech.com>
Date: Fri, 20 Dec 2002 10:29:26 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: Which Gigabit ethernet card?
References: <1040391936.973.14.camel@paragon.slim>
In-Reply-To: <1040391936.973.14.camel@paragon.slim>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer wrote:
> Hi,
> 
> I know this is a bit OT but because here are the kernel driver hackers
> this might be the right place to ask.
> 
> I am looking for a couple of PCI Gigabit ethernet adapters to play
> around with SAN/NAS stuff like iSCSI and HyperSCSI and the like. There
> are variuos adapters around which work with Linux. My choice would be
> based on the following:
> 
> - Relatively cheap, around $100/EUR100
> - 32 bit/33MHz PCI compatible

Try the Netgear 302t, with the tg3 driver.

Works pretty good if you are not also running a bunch of other interfaces.
If you are running lots of interfaces, it will still work, but may spew
warning messages to the console (maybe it's been fixed...I saw this 1-2 months ago)

Ben


> - Low cpu usage
> - Busmaster DMA
> - Opensource Linux driver
> - zero-copy capable
> - etc.
> 
> What card is best? 3Com, Intel or National Semi based?
> 
> Thanks,
> 
> Jurgen
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


