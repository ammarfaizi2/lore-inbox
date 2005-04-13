Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVDMJoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVDMJoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDMJn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:43:59 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:30481 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261273AbVDMJni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:43:38 -0400
Message-ID: <425CEAC2.1050306@aitel.hist.no>
Date: Wed, 13 Apr 2005 11:47:46 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John M Collins <jmc@xisl.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Exploit in 2.6 kernels
References: <1113298455.16274.72.camel@caveman.xisl.com>	 <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com>	 <20050412210857.GT11199@shell0.pdx.osdl.net> <1113341579.3105.63.camel@caveman.xisl.com>
In-Reply-To: <1113341579.3105.63.camel@caveman.xisl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John M Collins wrote:

>On Tue, 2005-04-12 at 14:08 -0700, Chris Wright wrote:
>  
>
>>* John M Collins (jmc@xisl.com) wrote:
>>    
>>
>>>Thanks to everyone for the pointers on this one I've rebuilt the kernels
>>>and we'll see what happens.
>>>      
>>>
>>BTW, I'd recommend updating to 2.6.11.7 so that you're protected from
>>another local root exploit.
>>    
>>
>
>I'll do that - trouble is round where I am they dish out Nvidia cards
>like confetti, I've got them in the machine I use most and another 2 and
>you have to do all that gyrating with running the script to FTP down and
>build the secret module before you can run X. This is a big disincentive
>when it comes to installing new kernels.
>
>I wish some kind soul would speak nicely to Nvidia and get them to see
>reason on the point but I suspect I'm not the first person to wish that.
>  
>
You're not.  Complain to nvidia - using both email and snailmail.
If everybody with such problems did that, chances are they see
the light someday. Oh, and complain to the guy handing out
nvidia cards like confetti, state your preference for some other
card.  Perhaps that is easier to achieve.

>(Or is there a sneaky way of patching the modules so they'll work in
>another kernel without tainting it?).
>  
>
Whats wrong with tainting?  It is just a message, telling you that
the kernel is unsupported.  In this case because you're running a
closed-source module.  The tainting message itself does not do
anything bad.  There is a way - which is to write an open nvidia
driver.  To do that, you'll need to get the specs out of nvidia or
figure it out by reverse-engineering some other nvidia driver. Either
approach is hard, so people generally find it cheaper to just buy
a supported card.

Helge Hafting
