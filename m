Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137032AbREKC1Y>; Thu, 10 May 2001 22:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137035AbREKC1O>; Thu, 10 May 2001 22:27:14 -0400
Received: from mail18.bigmailbox.com ([209.132.220.49]:48902 "EHLO
	mail18.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S137032AbREKC1J>; Thu, 10 May 2001 22:27:09 -0400
Date: Thu, 10 May 2001 19:26:26 -0700
Message-Id: <200105110226.TAA24955@mail18.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [202.67.238.248]
From: "Jacky Liu" <jq419@my-deja.com>
To: hahn@coffee.psychology.mcmaster.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel freeze for unknown reason
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

I think you pin-pointed one of the possible reason of the unknown freeze.. which is FB mode. Yes, I am using FB mode.. hm.. I will go back to recompile my kernel without FB mode and see whether this method can fix my problem or not.

You are right for the other assumption, I am running the harddisk in UDMA w/32bits mode. Are you suggesting me to turn off both functions? But if I turn them off, the performance will decrease alot.

Is there any way I can get any crash information? e.g. any function I can turn on for logging or something?

Thanks for your reply..

Best Regards,
Jacky Liu

"Genius or Wacko? Majority or Minority?"


>Date: Thu, 10 May 2001 10:24:30 -0400 (EDT)
>From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
>To: Jacky Liu <jq419@my-deja.com>
>SUBJECT
>> I would like to post a question regarding to a problem of unknown freeze of my linux firewall/gateway.
>
>since it's a gateway/firewall, is it safe to assume you're not running
>the video in graphics or framebuffer mode?  there were plenty of problems
>on machines like this the chipset never releasing the PCI bus from
>ownership by the video card.  the result was a hang, of course.
>
>is it also safe to assume that you have the disk running in dma/udma mode?
>(not just that it's a udma33-capable!)
>
>
>>  
>> Here is the hardware configuration of my machine:
>>  
>> AMD K-6 233 MHz
>> 2theMax P-55 VP3 mobo
>> 64Mb RAM in a single module (PC-100)
>> Maxtor 6G UDMA-33 harddisk
>> Matrox MG-II display card w/8Mb RAM
>> 3Com 3C905B-TX NIC
>> RealTek 8129 10/100 NIC
>>  
>> It's running 2.4.4 kernel (RedHat 7.1) and acting as a firewall using Netfilter (gShield and Snort), DNS (Cache-Only DNS) and NAT gateway (ip-masq.) for my home network. I used 3C905B-TX NIC as my internal NIC and RealTek 8129 as my external NIC. Here is the problem:
>>  
>> The machine has been randomly lockup (totally freeze) for number of times without any traceable clue or error message. Usually the time frame between each lockup is between 24 to 72 hours. The screen just freeze when it's lockup (either in Console or X) and no "kernel panic" type or any error message prompt up. All services (SSH, DNS, etc..) are dead when it's lockup and I cannot find any useful information in /var/log/messages. I cannot reproduce the lockup since it's totally randomly. The lockup happened either when I was playing online game (A LOT, like getting thousands of server status in counter-strike in a very short time frame, of NAT traffic), surfing the web (normal traffic) or the machine was totally in idle (lockup when I was sleeping). It was lockup this morning when I was playing online game (when my game machine was trying to establish connection to a game server).
>>  
>> If there is any information you would like to obtain, please let me know. I would like to receive a copy of your reply, thank you very much for your kindly attention.
>>  
>> Best Regards,
>> Jacky Liu
>>  
>> "Genius or Wacko? Majority or Minority?"
>> 
>> ------------------------------------------------------------
>> --== Sent via Deja.com ==--
>> http://www.deja.com/
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> 
>
>-- 
>operator may differ from spokesperson.                 hahn@coffee.mcmaster.ca
>                                              http://java.mcmaster.ca/~hahn


------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/
