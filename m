Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVG3Dsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVG3Dsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 23:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVG3Dsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 23:48:30 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:59721 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262768AbVG3Ds2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 23:48:28 -0400
Message-ID: <42EAF885.40008@m1k.net>
Date: Fri, 29 Jul 2005 23:48:21 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: frank.peters@comcast.net, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
References: <20050624113404.198d254c.frank.peters@comcast.net>	<42BC306A.1030904@m1k.net>	<20050624125957.238204a4.frank.peters@comcast.net>	<42BC3EFE.5090302@m1k.net>	<20050728222838.64517cc9.akpm@osdl.org>	<42E9C245.6050205@m1k.net> <20050728225433.6dbfecbe.akpm@osdl.org>
In-Reply-To: <20050728225433.6dbfecbe.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michael Krufky <mkrufky@m1k.net> wrote:
>  
>
>> Sadly, I must report that yes, the problem still intermittently occurs 
>> in 2.6.13-rc4 :-(  I'm the one that tested on the Shuttle FT61 
>> Motherboard.  Never has a problem in windows and never in 2.6.11 and 
>> earlier.
>>
>> I first noticed this problem sometime during 2.6.12-rc series.
>>    
>>
>
>Sigh.  I think it would help if you could generate a new report, please.
>
>We need a super-easy way for people to do bisection searching.
>  
>
I dug up the original email that I sent to LKML...

Michael Krufky wrote (5/26/2005 10:16 PM):

> In 2.6.12-rc5-mm1, I can't use my psaux mouse, but it worked perfectly 
> fine in both 2.6.12-rc5 and in 2.6.12-rc4-mm2.
>
> In 2.6.12-rc5-mm1 , dmesg says:
>
> PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> Failed to disable AUX port, but continuing anyway... Is this a SiS?
> If AUX port is really absent please use the 'i8042.noaux' option.
> serio: i8042 KBD port at 0x60,0x64 irq 1
>
> This is what dmesg says in both 2.6.12-rc4-mm2 and 2.6.12-rc5 :
>
> PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
>
> I am using a Shuttle FT61 motherboard.  Is there any more information 
> necessary to debug this?
>

-- 
Michael Krufky

