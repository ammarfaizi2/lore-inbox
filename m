Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268321AbTBYUvO>; Tue, 25 Feb 2003 15:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268359AbTBYUvN>; Tue, 25 Feb 2003 15:51:13 -0500
Received: from home.alltec.com ([66.46.63.194]:45041 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268321AbTBYUvM>; Tue, 25 Feb 2003 15:51:12 -0500
Message-ID: <3E5BD9A2.6090705@alltec.com>
Date: Tue, 25 Feb 2003 16:01:22 -0500
From: Mike Sullivan <mike.sullivan@alltec.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduling with Hyperthreading
References: <Pine.LNX.4.44.0302250852190.26386-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Mark

I would to a quick snap with top, and when I saw 99.9% I assumed the the 
process had
been there during the time top was starting up.

Looking at /proc/(pid)/cpu, shows that with two jobs running they are 
sticking to cpu 0 and 1
which are siblings


                                                                        
                                                                        
Regards
                                                                        
                                                                        Mike

Mark Hahn wrote:

>>that if I run two compute intensive jobs on a Dual Xeon, the processes 
>>run on separate
>>physical cpus and can spend a significant amount of time with both on a 
>>single
>>cpu.
>>    
>>
>
>how did you determine this?  running another program, such as top,
>will naturally disturb the scheduler and corrupt any observations.
>the only means I can think of is to look in /proc/<pid>/cpu near
>very infrequently (ideally, just before the processes exit.)
>or is this what you've done?
>  
>

-- 
----------------------------------------------------------------------
Mike Sullivan                           Director Performance Computing
@lliance Technologies,                  Voice: (416) 385-3255, 
18 Wynford Dr, Suite 407                Fax:   (416) 385-1774
Toronto, ON, Canada, M3C-3S2            Toll Free:1-877-216-3199
http://www.alltec.com



