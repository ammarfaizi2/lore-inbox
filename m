Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268366AbTBYVOk>; Tue, 25 Feb 2003 16:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268379AbTBYVOk>; Tue, 25 Feb 2003 16:14:40 -0500
Received: from home.alltec.com ([66.46.63.194]:62961 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268366AbTBYVNP>; Tue, 25 Feb 2003 16:13:15 -0500
Message-ID: <3E5BDECD.40502@alltec.com>
Date: Tue, 25 Feb 2003 16:23:25 -0500
From: Mike Sullivan <mike.sullivan@alltec.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduling with Hyperthreading
References: <Pine.LNX.4.44.0302251616300.31810-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried RH 2.4.18 stock redhat kernels and and 2.4.20 kernels. Both 
seem to
do badly.

Is there somewhere to look to see a history of the schedular work, or do 
I need
to puruse all of the changelogs to get an idea of what kernel I should 
be trying.



                                                                        
                                            Regards
                                                                        
                                            Mike

Mark Hahn wrote:

>>I would to a quick snap with top, and when I saw 99.9% I assumed the the 
>>process had
>>been there during the time top was starting up.
>>
>>Looking at /proc/(pid)/cpu, shows that with two jobs running they are 
>>sticking to cpu 0 and 1
>>which are siblings
>>    
>>
>
>ah, sorry if you said this, but which kernel are you running?
>you need a HT-aware scheduler, for sure.  does your problem go away
>if you boot with noht?
>  
>

-- 
----------------------------------------------------------------------
Mike Sullivan                           Director Performance Computing
@lliance Technologies,                  Voice: (416) 385-3255, 
18 Wynford Dr, Suite 407                Fax:   (416) 385-1774
Toronto, ON, Canada, M3C-3S2            Toll Free:1-877-216-3199
http://www.alltec.com



