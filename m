Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUKDUTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUKDUTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbUKDUQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:16:26 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:33156 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262382AbUKDUPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:15:36 -0500
Message-ID: <418A8E93.4030404@tmr.com>
Date: Thu, 04 Nov 2004 15:18:27 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       Tom Felker <tfelker2@uiuc.edu>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411041412.42493.jk-lkml@sci.fi><200411041412.42493.jk-lkml@sci.fi> <200411040739.01699.gene.heskett@verizon.net>
In-Reply-To: <200411040739.01699.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Thursday 04 November 2004 07:12, Jan Knutar wrote:
> 
>>On Thursday 04 November 2004 13:57, Gene Heskett wrote:
>>
>>>I'e had that turned on since forever Jan, but usually, when its
>>>hung someplace, its well and truely hung, and hardware reset
>>>button time.
>>
>>Are you saying that these zombies (or tasks stuck in state D) also
>>make sysrq-T hang, and not list all tasks?
> 
> 
> I thought I'd test it right now while the system is runnng normally, 
> but I got only a beep from the console, so I went to 
> Documentation/sysrq.txt to make sure I was doing it right, and it is 
> _not_ working right now.  But it is compiled in according to a make 
> xconfig, or a grep of the .config.
> 
> [root@coyote linux-2.6.10-rc1-bk13]# grep SYSRQ .config
> CONFIG_MAGIC_SYSRQ=y
> 
> I get a couple of beeps from the console, but thats the limit of the 
> response, and a tail -f on the log shows nothing.  I also logged into  
> VC2, and tried it there, but that attempt didn't even get me a beep, 
> several times.
> 
> The keyboard is a cheap ($24) M$ with a few extra buttons that don't 
> do anything along the top.  And getting a bit creaky in its old age, 
> a lot like me, but I'm about 68 years older than the keyboard :)
> 
Don't need to log in, do need two hands to hit all the keys at once;-) 
It works for me on a VC and unhung system, but I agree, when the system 
is well and truly hung reset is the only thing left.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
