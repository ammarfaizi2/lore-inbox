Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269440AbTCDNrh>; Tue, 4 Mar 2003 08:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269442AbTCDNrg>; Tue, 4 Mar 2003 08:47:36 -0500
Received: from rzserv1.gsi.de ([140.181.96.11]:59522 "EHLO rzserv1.gsi.de")
	by vger.kernel.org with ESMTP id <S269440AbTCDNre>;
	Tue, 4 Mar 2003 08:47:34 -0500
Message-ID: <3E64B0EA.4080109@GSI.de>
Date: Tue, 04 Mar 2003 14:58:02 +0100
From: ChristopherHuhn <c.huhn@gsi.de>
Organization: GSI
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: de-de, en-us, fr-fr
MIME-Version: 1.0
To: linux-smp <linux-smp@vger.kernel.org>, linux-kernel@vger.kernel.org
CC: Walter Schoen <w.schoen@GSI.de>, support-gsi@credativ.de
Subject: Re: Kernel Bug at spinlock.h ?!
References: <Pine.LNX.3.95.1030303103332.22802A-100000@chaos> <3E637CDC.3030409@GSI.de> <Pine.LNX.4.50.0303031248220.29455-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0303031248220.29455-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Mon, 3 Mar 2003, ChristopherHuhn wrote:
>
>  
>
>>Feb 27 20:51:37 lxb039 kernel: Unable to handle kernel NULL pointer 
>>dereference at virtual address 00000000
>>Feb 27 20:51:37 lxb039 kernel:  printing eip:
>>Feb 27 20:51:37 lxb039 kernel: 00000000
>>Feb 27 20:51:38 lxb039 kernel: Code:  Bad EIP value.
>>
>>
>>Looks like a NFS problem, huh?
>>    
>>
>
>Is that absolutely the first oops? 
>
It's the only one in the log file of that machine. I think it didn't die 
rigth after that.

>Looks valid, could you, if possible, 
>try running a newer 2.4 and we can debug from there.
>
>Cheers,
>	Zwane
>  
>
Newer means 2.4.21pre, since we are running 2.4.20?
I assume that we will not upgrade the kernel before a new stable 
release, since it is - should be - a production environment.

We have some indications, that our whole problem might be related to 
kernel NFS and mixing between 2.2.21 and 2.4.20 in both directions.

I'll compile some more oopses and give you a report tomorrow.

Have a nice day,

Christopher

