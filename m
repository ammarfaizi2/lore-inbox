Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264608AbRFPKr2>; Sat, 16 Jun 2001 06:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264609AbRFPKrS>; Sat, 16 Jun 2001 06:47:18 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:40650 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S264608AbRFPKrA>;
	Sat, 16 Jun 2001 06:47:00 -0400
Message-Id: <m15BDai-000OrcC@amadeus.home.nl>
Date: Sat, 16 Jun 2001 11:46:08 +0100 (BST)
From: arjan@fenrus.demon.nl
To: pavel@suse.cz (Pavel Machek)
Subject: Re: Changing CPU Speed while running Linux
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010614131220.A36@toy.ucw.cz>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010614131220.A36@toy.ucw.cz> you wrote:
>> and does the right thing wrt udelay / bogomips etc..
>> I can dig it out if you want.. sounds like this should be a more generic
>> thing.

> Can you dig that out? I'd like to take a look.

> [Of course, problem is *not* solved: you still have short time when
> kernel runs with wrong bogomips.]

But the kernel controls that time ..... It's not perfect, and it might be
aleviated by going in small steps at a time.
Disabling interrupts isn't fun as the bogomips code kind of needs that ;)

Greetings,
   Arjan van de Ven
