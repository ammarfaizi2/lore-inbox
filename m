Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264650AbSJ3KSm>; Wed, 30 Oct 2002 05:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264651AbSJ3KSm>; Wed, 30 Oct 2002 05:18:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17158 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264650AbSJ3KSk>;
	Wed, 30 Oct 2002 05:18:40 -0500
Message-ID: <3DBFB362.2070506@pobox.com>
Date: Wed, 30 Oct 2002 05:24:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dcinege@psychosis.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
 candidate list.
References: <200210272017.56147.landley@trommello.org> <200210300455.20883.dcinege@psychosis.com> <3DBFAEEE.6090209@pobox.com> <200210300514.57193.dcinege@psychosis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Cinege wrote:

>On Wednesday 30 October 2002 5:05, Jeff Garzik wrote:
>  
>
>>Dave Cinege wrote:
>>    
>>
>>>#2 My main bitch at jeff was he said if initramfs goes in
>>>initrd comes out. initrd shodul not come out.
>>>      
>>>
>>What part of "kernel's behavior is 100% unchanged" did you not understand?
>>    
>>
>
>You said this where?
>  
>
Message-ID: <3DBF9B4D.8020205@pobox.com>
Exact quote: "The kernel's behavior to the end user is 100% unchanged."

"To:" header:  dcinege@psychosis.com


>You DID Say:
>
>On Wednesday 30 October 2002 2:40, Jeff Garzik wrote:
>  
>
>>untar - cpio is better.
>>initrd - 99% moved out of the kernel
>>do_mounts - moved out of the kernel completely
>>initramfs - should be ready for Linus in the next day or so.
>>
>>None of that junk -- and a whole lot more -- needs to be in the kernel
>>at all.
>>    
>>
>
>Excuse me if I take this to mean something different then:
>"kernel's behavior is 100% unchanged"
>  
>
You appear to be unaware of early userspace. Moving code out of the 
kernel does _not_ mean eliminating that code completely.  I was hoping 
it was obvious that it is impossible to eliminate the tasks that 
do_mounts.c performs -- otherwise a Linux system would never have a root 
filesystem mounted.

Being unaware of early userspace implies that you are not familiar with 
initramfs.
Which implies you wish you merge your own code in place of something you 
do not understand.

    Jeff




