Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSEVNzL>; Wed, 22 May 2002 09:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313789AbSEVNzK>; Wed, 22 May 2002 09:55:10 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36879 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313773AbSEVNzJ>; Wed, 22 May 2002 09:55:09 -0400
Message-ID: <3CEB9465.6040409@evision-ventures.com>
Date: Wed, 22 May 2002 14:51:49 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <3CEB9A1B.9040905@antefacto.com> <E17AWXL-0001md-00@the-village.bc.nu> <20020522154902.A361@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Vojtech Pavlik napisa?:
> On Wed, May 22, 2002 at 02:52:19PM +0100, Alan Cox wrote:
> 
> 
>>>/sbin/kbdrate: util-linux
>>
>>I'd hope kbrate is using the ioctls nowdays, otherwise it will break on USB
> 
> 
> Actually, the ioctls won't work on USB, because they try to output data
> to the traditional i/o ports anyway.


So at least we know now:

1. Kernel is bogous.
2. util-linux is bogous.

IOCTL is ineed the way to go to implement such functionality...



