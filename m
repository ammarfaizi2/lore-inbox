Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317952AbSFNQrt>; Fri, 14 Jun 2002 12:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317954AbSFNQrs>; Fri, 14 Jun 2002 12:47:48 -0400
Received: from [195.63.194.11] ([195.63.194.11]:7439 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317952AbSFNQrs> convert rfc822-to-8bit;
	Fri, 14 Jun 2002 12:47:48 -0400
Message-ID: <3D0A1E31.3030600@evision-ventures.com>
Date: Fri, 14 Jun 2002 18:47:45 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jens Axboe <axboe@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <Pine.LNX.4.44.0206140940240.2576-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:
> 
> On Fri, 14 Jun 2002, Jens Axboe wrote:
> 
>>- current 2.5 bk deadlocks reading partition info off disk. Again a
>>  locking problem I suppose, to be honest I just got very tired when
>>  seeing it happen and didn't want to spend tim looking into it.
> 
> 
> Hmm. There's a bug in "balance_irq()" if you are trying to run a SMP
> kernel on an UP machine right now, and it _might_ be that the lockup has
> nothing to do with the IDE layer, but simple with the first PCI interrupt
> (as opposed to local timer interrupt) coming in.

...

> I don't know. Might be the IDE code too, of course.

Just to complete the picture: I'm running SMP kernels on
UP for the sake of spinlock debugging and compilatoin coverage too.
But as I have already stated - I run my own patches on
top of the last offical release instead of BK contents.


