Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSDOJOH>; Mon, 15 Apr 2002 05:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313123AbSDOJOG>; Mon, 15 Apr 2002 05:14:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:4362 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313122AbSDOJOF>;
	Mon, 15 Apr 2002 05:14:05 -0400
Message-ID: <3CBA8B48.1030005@evision-ventures.com>
Date: Mon, 15 Apr 2002 10:11:52 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 34
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com> <3CBA8476.9070208@evision-ventures.com> <20020415085145.GF12608@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Apr 15 2002, Martin Dalecki wrote:
> 
> Two comments --
> 
> Could you please _not_ just rearrange comments or change style in ide-cd
> just for the sake cleaning, it's very annoying when one has patches that
> need to be adapted every time. And it serves zero purpose. Thanks.

Please do me a small favour and use an editor which highlights trailing white
spaces please? The bandwidth waste caused by this is an waste of energy
and causes a significant amount of environmental pollution...

> I changed the CONFIG_BLK_DEV_IDEPCI stuff to always include the pci_dev
> in the hwgroup, and just leave it at NULL if not defined. This cleans up
> some ifdefs, I think this is the better approach.

Agreed.

> I'll sync the latest tcq stuff with you later today, it gets the
> enabling right etc.

Fine. I would like to go on with the request handling changes in ide-cd.c
thereafter.

> And a last comment not directly related to this particular patch -- when
> you include something and change minor stuff along the way, please do it
> in two steps. One that includes a patch, and a second version that
> changes what you want to change. That makes merging _so_ much easier.
> Thanks.

OK - sorry. I try already to make the granularity of the
patches smaller. Since I always apply patches line by line I wasn't aware of
your "modus operandi".

