Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133012AbREBMtg>; Wed, 2 May 2001 08:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133083AbREBMtR>; Wed, 2 May 2001 08:49:17 -0400
Received: from server1.safepages.com ([216.127.146.3]:43278 "HELO
	server1.safepages.com") by vger.kernel.org with SMTP
	id <S133012AbREBMtM>; Wed, 2 May 2001 08:49:12 -0400
Message-ID: <3AEFB8BE.5050007@surfbest.net>
Date: Wed, 02 May 2001 02:35:26 -0500
From: Moses McKnight <m_mcknight@surfbest.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac13 i686; en-US; rv:0.8.1+) Gecko/20010427
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
In-Reply-To: <Pine.LNX.4.10.10105012333400.18414-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

>>  Actually, I think there are 2 problems that have been discussed -- the
>>disk corruption and a general instability resulting in oops'es at
>>various points shortly after boot up.
>>
> 
> I don't see this.  specifically, there were scattered reports
> of a via-ide problem a few months ago; this is the issue that's 
> gotten some press, and for which Alan has a fix.  and there are reports 
> of via-smp problems at boot (which go away with noapic).  I see no reports 
> of the kind of general instability you're talking about.  and all the 
> via-users I've heard of have no such stability problems - 
> me included (kt133/duron).
> 
> the only general issue is that kx133 systems seem to be difficult
> to configure for stability.  ugly things like tweaking Vio.
> there's no implication that has anything to do with Linux, though.


When I reported my problem a couple weeks back another fellow
said he and several others on the list had the same problem,
and as far as I can tell it is *only* with the IWILL boards.
When I compiled with k7 optimizations I'd get all kinds of oopses
and panics and never fully boot.  They were different every time.
When any of the lesser optimizations are used I have no problems.
My memory is one 256MB Corsair PC150 dimm, CPU is a Thunderbird 850,
and mobo is an IWILL KK266 (KT133A).  The CPU runs between 35°C
and 40°C.


>>  My memory system jas been set up very conservitavely and has been
>>rock solid in my other board (ka7), so I doubt it's that, but I
>>sure am happy to try a few more cominations of bios settings.  Anything
>>I should look for in particular?
>>
> 
> how many dimms do you have?  interleave settings?  Vio jumper?
> already checked on cooling issues?  and that you're not overclocking...


