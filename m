Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTENDL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 23:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTENDL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 23:11:56 -0400
Received: from dsl081-085-006.lax1.dsl.speakeasy.net ([64.81.85.6]:16567 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id S263245AbTENDLy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 23:11:54 -0400
Message-ID: <3EC1B6F9.7030008@tmsusa.com>
Date: Tue, 13 May 2003 20:24:41 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn <core@enodev.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd db4 error with 2.5.69-mm4 [was Re: Huraaa for 2.5]
References: <1052866461.23191.4.camel@www.enodev.com>	 <20030514012731.GF8978@holomorphy.com>	 <1052877161.3569.17.camel@www.enodev.com>  <3EC1AAC4.1010104@tmsusa.com> <1052880432.3569.34.camel@www.enodev.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not available from rhn yet afaik - I got
them from a redhat employee page IIRC -

I put a copy at:

ftp://ftp.mainphrame.com/fixes/redhat-rpm/RH9/

Joe

Shawn wrote:

>I sure wish I knew what triggers this bug. it worked fine under 2.5.6x
>on rh 80 for me.
>
>Ah crap. I'm running rpm-4.2-0.69 because rhn has been busy. FRICK.
>
>On Tue, 2003-05-13 at 21:32, J Sloan wrote:
>  
>
>>Shawn wrote:
>>
>>    
>>
>>>Not to get away from the praise too much, but I have a rpm/db4 problem
>>>that seems to be related to the kernel. before I started backing out
>>>parts of 69-mm4, I just wanted to figure out /which/ parts to try
>>>backing out.
>>>
>>>As root, I basically can't use rpm at all. I think it's select() related
>>>as strace shows it timing out. The odd thing is that it works great as a
>>>non-privileged user.
>>>
>>>2.5.69-mm4, otherwise mostly stock rh90 setup.
>>>
>>>      
>>>
>>Just out of curiosity, have you tried:
>>
>>LD_KERNEL_ASSUME=2.4.1 rpm -qi iptables
>>
>>OTOH, rpm-4.2-1 seems to "just work" here -
>>
>>where "here" is of the form:
>>
>>2.5.6x on RH9
>>
>>Joe
>>
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>
>  
>


