Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315739AbSEGO2J>; Tue, 7 May 2002 10:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315742AbSEGO2I>; Tue, 7 May 2002 10:28:08 -0400
Received: from [195.63.194.11] ([195.63.194.11]:64268 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315739AbSEGO2H>; Tue, 7 May 2002 10:28:07 -0400
Message-ID: <3CD7D5AA.3000708@evision-ventures.com>
Date: Tue, 07 May 2002 15:24:58 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.13 IDE 54
In-Reply-To: <E1755ca-0007Xt-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>The comment above udma_enable seems to indicate that you think it
>>should be ifdef'd per-architecture.  That won't work for us (besides
>>being ugly), because we can have two ATA host adaptors in the one
>>machine that need to be programmed quite differently.  Consider for
>>instance a powermac with the built-in IDE interface (which would use
>>the ide-pmac.c code) and a plug-in PCI IDE card, for which the
>>udma_enable code is presumably correct.
> 
> 
> The same will be true for the PC very soon. In fact in a few cases
> it already is


I have already virtualized this method in my tree :-).

