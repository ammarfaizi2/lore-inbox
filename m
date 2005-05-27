Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVE0Elv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVE0Elv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 00:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVE0Elv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 00:41:51 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:47553 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S261667AbVE0Elq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 00:41:46 -0400
Date: Thu, 26 May 2005 21:41:39 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Christopher Warner <cwarner@kernelcode.com>
cc: "Peter J. Stieber" <developer@toyon.com>, chris@servertogo.com,
       linux-kernel@vger.kernel.org, Bill Davidsen <davidsen@tmr.com>
Subject: Re: Tyan Opteron boards and problems with parallel ports (badpmd)
In-Reply-To: <1117156446.8874.41.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0505262112540.32548@twin.uoregon.edu>
References: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB> 
 <037801c5616a$b1be6600$1600a8c0@toyon.corp> <4295E9F1.6080304@tmr.com> 
 <022e01c56233$241e5930$1600a8c0@toyon.corp> <1117156446.8874.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005, Christopher Warner wrote:

> Just read the other existing thread linked. Is everyone running the same
> model opteron on these Tyan boards (246)? To update even further.
> Besides the parallel port problem I've sent back about 5 of these tyan
> motherboards. A couple of then simply didn't have the gigabit network
> adapters available via bios. In some cases linux loaded the drivers for
> the adapters regardless of their setting in BIOS. In other cases they
> simply were not available.

I have 4 tyan s2882's. 2 with 244's and 2GB of ram and 2 with 246 and 4GB 
of ram. I don't appear to have bad parallel ports or bad ethernet 
interfaces. They're running fedora core 3's 2.6.11 x86_64 kernel
(2.6.11-1.14_FC3smp)... I cna't tell you what bios version off the top of 
my head but i can reboot one tomorrow if that helps.

> Also, are the processes you run swapping out/in memory repeatedly? Or
> using a large amount of threading? Thread pools? I'm trying to get rid
> of this problem myself. I've seen it extensively in 2.6.11.5 and not as
> much in 2.6.11.8 but I haven't tested lately past .8
>
> -Christopher Warner
>
>
> On Thu, 2005-05-26 at 13:40 -0700, Peter J. Stieber wrote:
>> YhLu>>> Don't always blame BIOS, if you like you could
>> YhLu>>> use LinuxBIOS instead...
>>
>> PJS>> Just curious, but why isn't this project (LinuxBIOS)
>> PJS>> mentioned on the Tyan web site, or is it and I
>> PJS>> just missed it?
>> PJS>>
>> PJS>> You do work for Tyan, right?
>>
>> BD = Bill Davidsen
>> BD> What has that to do with anything? I doubt that suggestions
>> BD> about boot options are on the website or come from the
>> BD> Tyan website, either.
>> BD>
>> BD> Note: I'm not endorsing LinuxBIOS for Opteron, I haven't
>> BD> personally tried it. But the value of the suggestion depends
>> BD> on how it works, not who makes it. There appear to be a
>> BD> lot of reports of problems with Opteron lately, if the BIOS
>> BD> isn't buggy then the documentation may have lost in
>> BD> translation.
>>
>> I have been having the "memory.c bad pmds" with a Tyan S2885
>> motherboard.
>>
>> https://www.redhat.com/archives/fedora-list/2005-May/msg01690.html
>> http://www.lib.uaa.alaska.edu/linux-kernel/archive/2005-Week-19/1397.html
>>
>> When Yhlu brought up the topic of LinuxBIOS, I thought he might be
>> suggesting that this would prove there are no problems with the BIOS
>> (i.e. the same problems would occur with LinuxBIOS as with the
>> motherboards built-in BIOS). Looking at the LinuxBIOS web site, I got
>> the impression (I may be wrong) that this was a Tyan supported effort.
>> If that was the case I was wondering why Tyan didn't mention LinuxBIOS
>> on their web site. It would make me more comfortable if this were a Tyan
>> supported effort. That's why I asked the question.
>>
>> I'm just trying anything I can to get rid of the bad pmd messages.
>>
>> Pete
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

