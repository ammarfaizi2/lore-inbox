Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVGUMcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVGUMcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 08:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVGUMcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 08:32:35 -0400
Received: from alerce3.iplannetworks.net ([200.69.193.91]:18883 "EHLO
	alerce3.iplannetworks.net") by vger.kernel.org with ESMTP
	id S261770AbVGUMcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 08:32:32 -0400
Message-ID: <42DF9646.5070806@latinsourcetech.com>
Date: Thu, 21 Jul 2005 09:34:14 -0300
From: =?UTF-8?B?TcOhcmNpbyBPbGl2ZWlyYQ==?= 
	<moliveira@latinsourcetech.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Management
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-iplan-Al-Info: iplan networks - Proteccion contra spam y virus en e-mail
X-iplan-Al-MRId: 9bd3db6c5ab88a4ed75aa285017de11b
X-iplan-Al-From: moliveira@latinsourcetech.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Wed, 2005-07-20 at 11:23 -0300, Márcio Oliveira wrote:
>  
>
>>Arjan van de Ven wrote:
>>
>>    
>>
>>>I'm sure RH support will be able to help you with that; I doubt many
>>>other people care about an ancient kernel like that, and a vendor one to
>>>boot.
>>>
>>>(Also I assume you are using the -hugemem kernel as the documentation
>>>recommends you to do)
>>>
>>> 
>>>
>>>      
>>>
>>Arjan,
>>
>>   I'd like to know/understand more about memory management  on  Linux 
>>Kernel and I belive this concept is applyable to the Red Hat Linux Kernel.
>>    
>>
>
>Only on the highest of levels. The RHEL3 kernel has a VM that resembles
>almost no other linux kernel in many many ways. 
>
>
>  
>
>>  I have some doubts about the ZONE divison (DMA, NORMAL, HIGHMEM), 
>>Shared Memory utilization, HugeTLB feature and OOM with large memory and 
>>the kernel management of memory on SMP machines. I believe these 
>>features are common to the Linux kernel in general(Red Hat, Debian, 
>>SuSe, kernel.org), right?
>>    
>>
>
>nope. These things are very much different between the kernels you
>mention.
>
>What do you want to use the knowledge for? Fixing the VM? Tuning your
>server? The goal of your question determines what kind of answer you
>want to your questions....
>  
>
It's about tunning the VM parameters...

That's my first question on list:

"Is HugeTBL proc memory parameters only to hugetlbfs "filesystem" or are 
these parameters affect ramfs, shm and tmpfs too?

What is the basic difference between ramfs, hugetlbfs, shm and tmpfs to 
the memory management / process VLM utilization?

thanks,

Márcio."
