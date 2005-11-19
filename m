Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVKSNjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVKSNjm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 08:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVKSNjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 08:39:42 -0500
Received: from smtp3.nextra.sk ([195.168.1.142]:16396 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751111AbVKSNjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 08:39:41 -0500
Message-ID: <437F2B20.7030909@rainbow-software.org>
Date: Sat, 19 Nov 2005 14:39:44 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compaq Presario "reboot" problems
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com> <437D118A.3000306@rainbow-software.org> <200511181348.59957.vda@ilport.com.ua>
In-Reply-To: <200511181348.59957.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Friday 18 November 2005 01:26, Ondrej Zary wrote:
> 
>>linux-os (Dick Johnson) wrote:
>>
>>>It appears as though Linux is still restarting as a "warm boot",
>>>rather than a cold boot (in other words, putting magic in the
>>>shutdown byte of CMOS) so the hardware doesn't get properly
>>>initialized. Would somebody please check this out. When changing
>>>operating systems, you need a cold-boot.
>>
>>No, it does not. I know that my desktop PC reboots with a beep (and 
>>shows CPU information) from Linux - and it does not beep when rebooting 
>>from Windows 98.
>>Some BIOSes don't like when some devices are in some state. One example 
>>is my DTK FortisPro TOP-5A notebook - when rebooted from Linux, it hangs 
>>during POST - the fix was to add setpci <someting> to shutdown scripts 
>>to zero-out some cardbus controller registers.
> 
> 
> Did you report it to lkml and/or dirver maintainer?

Not yet. I haven't tried any kernel newer than 2.6.8.1 (because of the 
monitor mode patch for orinoco wifi card) so I don't know if the problem 
is still there.
Also Linux does not like APM on this notebook. But I don't have free 
time to play with thing like these...

-- 
Ondrej Zary
