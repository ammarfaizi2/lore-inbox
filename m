Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315814AbSEJFtG>; Fri, 10 May 2002 01:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315815AbSEJFtF>; Fri, 10 May 2002 01:49:05 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60423 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315814AbSEJFtE>; Fri, 10 May 2002 01:49:04 -0400
Message-ID: <3CDB5084.5000803@evision-ventures.com>
Date: Fri, 10 May 2002 06:45:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH & call for help: Marking ISA only drivers
In-Reply-To: <E175y7e-0004rI-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>Ok, I'm assuming that there are no boxes with no ISA slots but VLB slots.
>>I guess that's safe. If someone really has a weird box were that is not true
>>I guess they'll have to live with defining CONFIG_ISA. 
>>In theory one could introduce an CONFIG_VLB, but I don't think it is 
>>worth it.
> 
> 
> Agreed

In esp. in face of the fact that VLB was in reality merely the
486 CPU to memmory bus hanging out of the system... so it didn't
have it's own protocol different from inb outb - which logically corresponds
to ISA.

