Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSEGLoI>; Tue, 7 May 2002 07:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSEGLoH>; Tue, 7 May 2002 07:44:07 -0400
Received: from [195.63.194.11] ([195.63.194.11]:63496 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315416AbSEGLnf>; Tue, 7 May 2002 07:43:35 -0400
Message-ID: <3CD7AF2D.7010104@evision-ventures.com>
Date: Tue, 07 May 2002 12:40:45 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <Pine.LNX.4.21.0205071333210.32715-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Roman Zippel napisa?:
> Hi,
> 
> On Tue, 7 May 2002, Martin Dalecki wrote:
> 
> 
>>>Another thing: where is the equivalilent part of this removed code?
>>
>>Look closer it's there in ide-probe.c.
> 
> 
> Does it still take the correct byte swapping into account?
> Did you consider using a table for the fixup? It's nothing perfomance
> critical and this might generate more compact code.


Well right now we have two different reimplementation of
get device id code, so this areas is subject to change anyway.
BTW.> It should indeed take both in to account as far as I can
see.(Despite the fact that I could affort an ATARI I hardly
can find one...)

