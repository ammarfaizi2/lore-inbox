Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267778AbTBYHda>; Tue, 25 Feb 2003 02:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267791AbTBYHda>; Tue, 25 Feb 2003 02:33:30 -0500
Received: from spitfire.velocet.net ([216.138.223.227]:13573 "EHLO
	spitfire.velocet.net") by vger.kernel.org with ESMTP
	id <S267778AbTBYHd3>; Tue, 25 Feb 2003 02:33:29 -0500
Message-ID: <3E5B1EB8.2090601@alltec.com>
Date: Tue, 25 Feb 2003 02:43:52 -0500
From: Mike Sullivan <mike.sullivan@alltec.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Scheduling with Hyperthreading
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sorry, should have been more specific. I am referring to the scheduler. 
I have noticed
that if I run two compute intensive jobs on a Dual Xeon, the processes 
run on separate
physical cpus and can spend a significant amount of time with both on a 
single
cpu. I have seen some patches that try to improve on this and was 
wondering if
they have made it into the production kernel stream. I ran tests on a 
2.4.20 kernel and
it had the same problem as a 2.4.18 kernel.


                                                                        
                                    Thanks
                                                                        
                                     Mike

William Lee Irwin III wrote:

>On Mon, 24 Feb 2003, Mike Sullivan wrote:
>  
>
>>>What kernel versions will attempt to distribute jobs across physical CPUs on
>>>Xeon SMP configurations.
>>>      
>>>
>
>On Mon, Feb 24, 2003 at 10:45:18PM -0700, James Bourne wrote:
>  
>
>>From what I've heard, Arjans' user space daemon might be the way
>>things are going, it's at http://people.redhat.com/arjanv/irqbalance/ .
>>The other way that you might try is the irq load balance patch that Ingo
>>produced.  There is a patch that is from 2.4.20 at
>>http://www.hardrock.org/kernel/2.4.20/ and it is what I'm using at work on
>>our current Xeon systems (until I have the chance to test the user space
>>daemon at least).
>>    
>>
>
>I think he's referring to the cpu scheduler, not interrupt load
>balancing. mingo might have some insight into current patches for
>this and current results thereof. I don't really participate in
>the scheduler aside from very occasional bugfixing.
>
>
>-- wli
>  
>



-- 
----------------------------------------------------------------------
Mike Sullivan                           Director Performance Computing
@lliance Technologies,                  Voice: (416) 385-3255,
18 Wynford Dr, Suite 407                Fax:   (416) 385-1774
Toronto, ON, Canada, M3C-3S2            Toll Free:1-877-216-3199
http://www.alltec.com



