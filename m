Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTLIHCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 02:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTLIHCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 02:02:40 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:33540 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263267AbTLIHCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 02:02:37 -0500
Message-ID: <3FD577E7.9040809@nishanet.com>
Date: Tue, 09 Dec 2003 02:21:11 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
References: <200312081536.26022.andrew@walrond.org>	<20031208154256.GV19856@holomorphy.com>	<3FD4CC7B.8050107@nishanet.com>	<20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
In-Reply-To: <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witukind wrote:

>On Mon, 8 Dec 2003 15:37:55 -0800
>Greg KH <greg@kroah.com> wrote:
>
>  
>
>>On Mon, Dec 08, 2003 at 02:09:47PM -0500, Bob wrote:
>>    
>>
>>>William Lee Irwin III wrote:
>>>
>>>      
>>>
>>>>On Mon, Dec 08, 2003 at 03:36:26PM +0000, Andrew Walrond wrote:
>>>>
>>>>
>>>>        
>>>>
>>>>>Whats the general feeling about devfs now? I remember Christoph
>>>>>          
>>>>>
>>>>and >others making some nasty remarks about it 6months ago or so,
>>>>but later >noted christoph doing some slashing and burning thereof.
>>>>        
>>>>
>>>>>Is it 'nice' yet? 
>>>>>Andrew Walrond
>>>>>  
>>>>>
>>>>>          
>>>>>
>>>>I would say it's deprecated at the very least. sysfs and udev are
>>>>supposed to provide equivalent functionality, albeit by a somewhat
>>>>different mechanism.
>>>>        
>>>>
>
>>From the udev FAQ:
>
>Q: But udev will not automatically load a driver if a /dev node is opened
>   when it is not present like devfs will do.
>A: If you really require this functionality, then use devfs.  It is still
>   present in the kernel.
>
>Will it have this 'equivalent functionality' some day?
>
>
>  
>
Shouldn't hotplug handle it?

hotplug and udev and sysfsutils are together at
http://www.kernel.org/pub/linux/utils/kernel/hotplug
so hotplug is part of the sysfs and udev program.

-Bob D

