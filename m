Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSEVKsb>; Wed, 22 May 2002 06:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSEVKsa>; Wed, 22 May 2002 06:48:30 -0400
Received: from [195.63.194.11] ([195.63.194.11]:7186 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293337AbSEVKs2>;
	Wed, 22 May 2002 06:48:28 -0400
Message-ID: <3CEB68A3.8060308@evision-ventures.com>
Date: Wed, 22 May 2002 11:45:07 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Juan Quintela <quintela@mandrakesoft.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.16 IDE 68
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>	<3CEB475B.1040601@evision-ventures.com> <m2it5gfogg.fsf@demo.mitica>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Juan Quintela napisa?:
>>>>>>"martin" == Martin Dalecki <dalecki@evision-ventures.com> writes:
>>>>>
> 
> martin> Wed May 22 02:56:45 CEST 2002 ide-clean-68
> martin> - Make the different ATAPI device type drivers use a unified packet command
> martin> structure. We have to start to push them together.
> 
> martin> This patch is rather trivial in itself, but the plentora of code duplication it
> martin> is trying to fight against is making it unfortunately rather big...
> 
> Hi
> 
> atapi.c is not a module, then it don't make sense to have a
> MODULE_LICENSE :(
> 
> Notice that I don't like that kind of trap:
> 
> disable IDECD
> compile kernel
> enable IDECD as module
> compile module
> 
> your module don't work :(
> 
> And we have had already that problem with NFS, please, make that file
> _always_ compiled in, or make it a real module.

Yes I'm aware of this, but some time soon it is going to become
a real module :-). It just has to came over the "triviality" age.


