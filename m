Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbVLOJKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbVLOJKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbVLOJKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:10:52 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:47329 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161106AbVLOJKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:10:51 -0500
Message-ID: <43A13313.4030405@fr.ibm.com>
Date: Thu, 15 Dec 2005 10:10:43 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vserver@list.linux-vserver.org
CC: Bill Davidsen <davidsen@tmr.com>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Vserver] Re: [ANNOUNCE] second stable release of Linux-VServer
References: <20051213185650.GA6466@MAIL.13thfloor.at>	<Pine.LNX.4.63.0512140832200.2723@cuia.boston.redhat.com>	<43A0AD68.50107@tmr.com> <20051215033324.GA15047@MAIL.13thfloor.at>
In-Reply-To: <20051215033324.GA15047@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> On Wed, Dec 14, 2005 at 06:40:24PM -0500, Bill Davidsen wrote:
> 
>>Rik van Riel wrote:
>>
>>>On Tue, 13 Dec 2005, Herbert Poetzl wrote:
>>>
>>>
>>>>Well, as the OpenVZ folks announced their release on LKML
>>>>I just decided to do similar for the Linux-VServer release,
>>>>so please let me know if that is not considered appropriate.
>>>
>>>Since there is a legitimate (and very popular) use case for
>>>virtuozzo / vserver functionality, I think it is a good
>>>thing to get all the code out in the open.
>>>
>>>I really hope we will get something like BSD jail functionality
>>>in the Linux kernel.  It makes perfect sense for hosting
>>>environments.
>>>
>>
>>Like many needs there are lots of solutions, none of which are perfect, 
>>or at least without problems the competition says are important ;-) This 
>>is one more thing to study, but it seems as though there is not an 
>>overview of the various solutions for easy comparison.
>>
>>This list is probably incomplete:
>> linuxjail - BSD jail is the goal
>> VMware - I use this for BSD machines
>> xen - the last I looked ran Linux, not Windows or BSD unpatched
>> UML - run Linux nicely
>> VServer - news to me
> 
> 
> free:				commercial:
> 
> Virtual Machine (Emulators/Simulators):
> (allows for unmodified guest systems)
> 
>  - Bochs			 - VMware
>  - QEMU				 - SoftPC
>  - Hercules			 - VirtualPC
>  - GXemul
>  - UAE
> 
> Para Virtualization (Hypervisor)
> (requires modified guest kernels, without HW support)
> 
>  - IBM Hypervisor		 - VMware ESX
>  - Xen				 - TRANGO
>  - UML
> 
> Kernel Isolation (Partitioning)
> (does not support guest kernels at all)
> 
>  - Linux-VServer		 - Virtuozzo
>  - FreeVPS			 
>  - OpenVZ
>  - linuxjails
> 
> best,
> Herbert
> 
> PS: please add stuff where appropriate ...
> (not considered to be a complete list)

wikipedia has some interesting articles on this topic :

http://en.wikipedia.org/wiki/Virtualization

and more _stuff_ available here to complete Herbert list:

http://en.wikipedia.org/wiki/Comparison_of_virtual_machines

C.
