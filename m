Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292659AbSBUR24>; Thu, 21 Feb 2002 12:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292660AbSBUR2q>; Thu, 21 Feb 2002 12:28:46 -0500
Received: from [195.63.194.11] ([195.63.194.11]:37128 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292659AbSBUR2b>; Thu, 21 Feb 2002 12:28:31 -0500
Message-ID: <3C752E1D.20606@evision-ventures.com>
Date: Thu, 21 Feb 2002 18:27:57 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C737F29.7070105@evision-ventures.com> <3C74C03C.4060403@evision-ventures.com> <3C74D18D.FCCFEA83@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hum, I'm not sure that removing ->driver_init is a good idea.
> 
> Seems like a loss of flexibility to me, not a cleanup, and I wonder if
> you have thought through all the paths that wind up calling
> ->driver_init.

Yes I have tought it all through!
Please trust me - I eat at least myself my dog-food.

And the driver_init function is something which where currently
just the bloody module initialization function get's called
a seond time - and this is just plain wrong.

If I hadn't tought about it I wouldn't be that advantegrous.
And my testing of it did consist of the following:

1. 2 x IDE drives of one IDE port.

2. 1 x CD-RW on a second port - modularized.

3. 1 x CarBus to CF adapter.

It all worked well after the removal!



