Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVKSVUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVKSVUJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVKSVUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:20:08 -0500
Received: from 8.ctyme.com ([69.50.231.8]:33741 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1750827AbVKSVUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:20:07 -0500
Message-ID: <437F9705.80503@perkel.com>
Date: Sat, 19 Nov 2005 13:20:05 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
References: <437F63C1.6010507@perkel.com>	 <1132426887.19692.11.camel@localhost.localdomain>	 <200511191900.12165.s0348365@sms.ed.ac.uk> <1132431907.19692.15.camel@localhost.localdomain>
In-Reply-To: <1132431907.19692.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>On Sad, 2005-11-19 at 19:00 +0000, Alistair John Strachan wrote:
>  
>
>>>SATA not yet, USB you could however.
>>>      
>>>
>>Or PATA, of course. I switch off two of my HDs 4 minutes after last use with 
>>the commands:
>>
>>hdparm -S 48 /dev/hde
>>hdparm -S 48 /dev/hdg
>>
>>Isn't there a passthru patch in the works to let commands, such as the one 
>>required for suspend, through to a SATA device?
>>    
>>
>
>The latest kernels support command passthrough for SMART and the like
>but hdparm -S does not "switch off" anything. It may spin a drive down
>but the power consumption of 23 hours a day of "spun down" is
>significant, probably more than the hour it is powered up.
>
>Same as the problem with many household devices in standby that actually
>end up using as lot of power in their many "turned off" hours
>  
>

I didn't actually mean totally power off. Spin down would be fine with 
me. Just seems like a waste to run a drive for 24 hours that is used 
only for 10 minutes. That drive is there so if the main drive blows I 
can run down to the datacenter and move one cable and be back up again.

You know what's interesting is that I read somewhere that computers use 
as much power as 4 hoover dams can generate. And since a lit of these 
computer are running Linux just a few lines of code can create enough 
energy savings to perhaps power a small city. Kind of amazing when you 
think about it.

SATA isn't really "new" any more. I personally consider IDE to be 
obsolete. Seems to me that Linux should fully support SATA to the same 
level as IDE drives. And I'm saying that as someone who doesn't have to 
actually code it. But I will leave messages of praise and thanks in this 
mailing list if you all catch up.
