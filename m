Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbSJPGxO>; Wed, 16 Oct 2002 02:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSJPGxO>; Wed, 16 Oct 2002 02:53:14 -0400
Received: from [203.117.131.12] ([203.117.131.12]:3760 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S264942AbSJPGxN>; Wed, 16 Oct 2002 02:53:13 -0400
Message-ID: <3DAD0E36.9040809@metaparadigm.com>
Date: Wed, 16 Oct 2002 14:59:02 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>
Cc: J Sloan <joe@tmsusa.com>, Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <200210152120.13666.simon.roscic@chello.at>	 <1034710299.1654.4.camel@localhost.localdomain>	 <200210152153.08603.simon.roscic@chello.at>	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost>	 <3DACEB6E.6050700@metaparadigm.com>  <3DACEC85.3020208@tmsusa.com>	 <1034743416.29307.11.camel@localhost>  <3DAD0118.80807@metaparadigm.com>	 <1034749907.2045.15.camel@localhost>  <3DAD09E3.2050602@metaparadigm.com> <1034750930.2045.35.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/02 14:48, GrandMasterLee wrote:
> On Wed, 2002-10-16 at 01:40, Michael Clark wrote:
> ...
> 
>>>Should I remove LVM all together, or just not use it? In your opinion.
>>
>>I just didn't load the module after migrating my volumes. If the problem
>>is a stack problem, then its probably not necessarily a bug in LVM
>>- just the combination of it, ext3 and the qlogic driver don't mix well
>>- so if its not being used, then it won't be increasing the stack footprint.
> 
> Not to be dense, but it's compiled into my kernel, that's why I ask. We
> try not to use modules where we can help it. So I'm thinking, if no VG
> are actively used, then LVM won't affect the stack much. I just don't
> know if that's true or not. 

Correct. Won't effect the stack at all.

~mc

