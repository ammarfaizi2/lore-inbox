Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279064AbRK1Rv5>; Wed, 28 Nov 2001 12:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278911AbRK1Rvr>; Wed, 28 Nov 2001 12:51:47 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:408 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S278928AbRK1Rvi>; Wed, 28 Nov 2001 12:51:38 -0500
Message-ID: <3C05238C.5080903@antefacto.com>
Date: Wed, 28 Nov 2001 17:49:00 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Documentation/filesystems/tmpfs
In-Reply-To: <m3y9kqon6w.fsf@linux.local> <3C051F2D.2030804@antefacto.com> <m3u1veokyd.fsf@linux.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:

> Hi Padraig,
> 
> On Wed, 28 Nov 2001, Padraig Brady wrote:
> 
>>>In contrast to RAM disks, which get allocated a fixed amount of
>>>physical RAM, tmpfs grows and shrinks to accommodate the files it
>>>contains and is able to swap unneeded pages out to swap space.
>>>
>>
>>
>>That isn't the case now since ramdisks were integrated with the
>>buffer cache:
>>
> 
> What isn't the case any more?


Because the RAM is now (de)allocated as required.


> 
>>$ dd if=/dev/zero of=/tmp/use_mem bs=1024 count=20000
>>
> 
> On what filesystem is /tmp/use_mem located? What do you want to show?

Filesystem? ext2 on /dev/ram1(rd.o)
meminfo shows the memory being reclaimed as the file is deleted.

Padraig.

