Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264972AbTIDMw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTIDMvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:51:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25292 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264983AbTIDMv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:51:29 -0400
Message-ID: <3F573542.5010509@pobox.com>
Date: Thu, 04 Sep 2003 08:51:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Scott Ashcroft <ashcroft@qzxyz.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tg3/Broadcom gigabit driver just got worse in 2.4.23-pre3
References: <3F569AF8.9040507@myrealbox.com> <3F56E8F5.6020702@qzxyz.com>
In-Reply-To: <3F56E8F5.6020702@qzxyz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Ashcroft wrote:
> walt wrote:
> 
>> Hi Jeff et all,
>>
>> I just tried 2.4.23-pre3 with results that are disastrous, for me at 
>> least.
>>
>> As you will remember, I'm the one who has to do an ifconfig down/up cycle
>> on my asus A7V8X mobo with built-in Broadcom chip.  But after the updates
>> in -pre3 the chip no longer will work at all.
>>
>> In fact, if I try 'ifconfig eth0 down' the command hangs forever and 
>> chews
>> up 99.9% of the CPU.  No packets are ever transmitted in spite of a 
>> normal
>> 'ifconfig' output after bootup.  The chip is correctly identified in 
>> dmesg:
>>
>> eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit)
>> 10/100/1000BaseT Ethernet 00:e0:18:d2:a6:c1
> 
> 
> Same here but it's a 5705M in a laptop. Tried backing out just the 
> changes to the tg3 driver but couldn't get it to build correctly.

Does 2.4.23-pre2 work for you?

	Jeff




