Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSENMGn>; Tue, 14 May 2002 08:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSENMGm>; Tue, 14 May 2002 08:06:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12812 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315630AbSENMGl>; Tue, 14 May 2002 08:06:41 -0400
Message-ID: <3CE0EF02.9070802@evision-ventures.com>
Date: Tue, 14 May 2002 13:03:30 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <20020514123830.A18118@flint.arm.linux.org.uk> <E177b8s-0007lm-00@the-village.bc.nu> <20020514130018.C18118@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Russell King napisa?:
> On Tue, May 14, 2002 at 01:10:58PM +0100, Alan Cox wrote:
> 
>>I don't even Martin here, the ide locking is currently utterly vile
> 
> 
> Agreed.
> 
> I'm adding BUG_ON()s to the IDE drivers I maintain where we must ensure
> only one channel is DMAing to catch possible data corruption before it
> happens.

That is indeed a good idea!

