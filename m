Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSKRRIZ>; Mon, 18 Nov 2002 12:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSKRRIZ>; Mon, 18 Nov 2002 12:08:25 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:40580 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263291AbSKRRIY>;
	Mon, 18 Nov 2002 12:08:24 -0500
Message-ID: <3DD92026.3020506@colorfullife.com>
Date: Mon, 18 Nov 2002 18:15:18 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vergoz Michael <mvergoz@sysdoor.com>
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 8139too.c patch for kernel 2.4.19
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vergoz Michael wrote:

> Hi Jeff,
>
> What i see is the current driver _doesn't_ work on my realtek 8139C.
> With this one it work fine.


What you have send to the list is a huge change:

ShuChen Shao took the 0.9.15 driver and added 8139 C+ support to it. This will not go into the kernel, instead the kernel contains a new driver for the 8139C+ nic.
You took his driver and added additional changes to it.
Meanwile development continued in the kernel driver [version 0.9.25].

Now we must try to merge everything again. Unfortunately this means manually figuring out which of your changes are required and which back out bugfixes.

Could you try to shrink your patch down to the necessary changes?
- did the 8139c+ driver from ShuChen work?
- create a diff with just your changes.

And add some description about your problem.

--
	Manfred


