Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVJTQ10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVJTQ10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 12:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVJTQ10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 12:27:26 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:53678 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932392AbVJTQ10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 12:27:26 -0400
Message-ID: <4357C56B.30600@bootc.net>
Date: Thu, 20 Oct 2005 17:27:23 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 lockups (no oops)
References: <43567D80.3050304@bootc.net> <20051020131815.GI2811@suse.de> <20051020163425.z7wygjyir8lcw0gk@horde.fusednetworks.co.uk> <20051020162112.GT2811@suse.de>
In-Reply-To: <20051020162112.GT2811@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Thu, Oct 20 2005, Chris Boot wrote:
>  
>
>>Quoting Jens Axboe <axboe@suse.de>:
>>
>>    
>>
>>>On Wed, Oct 19 2005, Chris Boot wrote:
>>>      
>>>
>>>>I don't get any OOPSes or BUGs or anything, not on my screen nor on my
>>>>serial console (although I'm not sure I have this working right--I only
>>>>seem to get kernel boot messages). Machine replies to pings but I can't
>>>>        
>>>>
>>>Easy fix for that is probably to kill klogd on the machine. Test with eg
>>>loading/unloading of loop, that prints a message when it loads.
>>>      
>>>
>>I'd love to, but the machine is locked solid and won't turn on the
>>display or switch TTYs or anything. Anyway, I've applied
>>reiser4-fix-livelock.patch from ftp.namesys.org and so far so good
>>(over night).
>>    
>>
>
>I mean _before_ the crash, to make sure the messages get out :-)
>  
>
Oh! Hehe, now I get you. However, I'm using metalog for logging, and 
modprobe loop doesn't give any output. What's interesting is that serial 
console logging dies long before metalog is started, just after my swap 
is added in fact. I'm using Gentoo.

Any ideas?

Cheers,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

