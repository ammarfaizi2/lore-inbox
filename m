Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbTGVTYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbTGVTYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:24:48 -0400
Received: from linux8.bluehill.com ([128.121.244.233]:6564 "EHLO
	mach8.bluehill.com") by vger.kernel.org with ESMTP id S268702AbTGVTYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:24:45 -0400
Message-ID: <3F1D92FB.5040504@inmotiontechnology.com>
Date: Tue, 22 Jul 2003 12:39:39 -0700
From: Larry LeBlanc <leblanc@inmotiontechnology.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry LeBlanc <leblanc@inmotiontechnology.com>
CC: Russell King <rmk@arm.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Power Management/PCMCIA conflict causes system freeze
References: <3F1D8159.4060209@inmotiontechnology.com> <20030722193440.A16051@flint.arm.linux.org.uk> <3F1D91AB.3030707@inmotiontechnology.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Larry LeBlanc wrote:

> Hi Russell,
>
> No luck...I enabled sysrq and verified it was working by issuing 
> sysrq-t and sysrq-p while the system was healthy. But when I cause the 
> hang sysrq-t and sysrq-p no longer do anything. One source I looked up 
> indicated that "Since it [Magic SysRq] is implemented as a part of the 
> keyboard driver, it is guaranteed to work most of the time, unless the 
> kernel itself is dead." So my conclusion is that my kernel is dead.
>
> Note: I tried sysrq-b on my system when it is healthy and it causes 
> the same hang.
>
> Larry
>
> Russell King wrote:
>
>>On Tue, Jul 22, 2003 at 11:24:25AM -0700, Larry LeBlanc wrote:
>>  
>>
>>>Any ideas? I've tried turning on debug in apm but all that happens is 
>>>the debug messages freeze with the rest of the system. Is there any 
>>>other location I should turn on debug messages to try to get an idea of 
>>>where the system is hanging?
>>>    
>>>
>>
>>You need to enable sysrq, cause a hang, and then issue a sysrq-t and
>>sysrq-p to find out where you're hanging.
>>
>>Note that if you're using a serial console, you need to hold the serial
>>port open for sysrq requests to be processed.
>>
>>  
>>
>



