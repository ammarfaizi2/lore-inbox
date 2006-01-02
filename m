Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWABOFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWABOFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 09:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWABOFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 09:05:20 -0500
Received: from proxy3.nextra.sk ([195.168.1.138]:30980 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S1750732AbWABOFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 09:05:19 -0500
Message-ID: <43B9331A.8000802@rainbow-software.org>
Date: Mon, 02 Jan 2006 15:05:14 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Calin Szonyi <caszonyi@rdslink.ro>
CC: linux-kernel@vger.kernel.org
Subject: Re: mtrr: 0xe4000000,0x4000000 overlaps existing 0xe4000000,0x800000
References: <1136173074.6553.2.camel@mindpipe> <43B929C5.6050602@rainbow-software.org> <Pine.LNX.4.62.0601021539550.1829@grinch.ro>
In-Reply-To: <Pine.LNX.4.62.0601021539550.1829@grinch.ro>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

caszonyi@rdslink.ro wrote:
> On Mon, 2 Jan 2006, Ondrej Zary wrote:
> 
>> Lee Revell wrote:
>>> I got this in dmesg with 2.6.14-rc7 when I restarted X with
>>> ctrl-alt-backspace due to a lockup.  Is it a kernel bug or an X problem?
>>>
>> I see that always when starting X:
>> mtrr: 0xe1000000,0x800000 overlaps existing 0xe1000000,0x400000
>>
> 
> Same here
> mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x2000000
> 
> It appeared around kernel 2.6.14

I've just tried 2.6.8.1 and it's there too. Nothing in 2.6.0.

-- 
Ondrej Zary
