Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315407AbSEGLN4>; Tue, 7 May 2002 07:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315408AbSEGLNz>; Tue, 7 May 2002 07:13:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26632 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315407AbSEGLNz>; Tue, 7 May 2002 07:13:55 -0400
Message-ID: <3CD7A832.2070502@evision-ventures.com>
Date: Tue, 07 May 2002 12:10:58 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <Pine.LNX.4.21.0205070036150.32715-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Roman Zippel napisa?:
> Hi,
> 
> On Mon, 6 May 2002, Martin Dalecki wrote:
> 
> 
>>- Eliminate CONFIG_BLK_DEV_IDEPCI - it's duplicating the functionality of the
>>   already present and fine CONFIG_PCI flag and if we are a PCI host, we are
>>   indeed very likely to need host chip support anyway.
> 
> 
> Please don't do this! There are configurations possible with pci enabled 
> but without a pci ide adapter.

So please just don't configure any PCI host chip support there.

