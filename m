Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271989AbRIVT7T>; Sat, 22 Sep 2001 15:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271995AbRIVT7J>; Sat, 22 Sep 2001 15:59:09 -0400
Received: from as1-5-2.tbg.s.bonet.se ([217.215.34.209]:41638 "EHLO
	flashdance.cx") by vger.kernel.org with ESMTP id <S271989AbRIVT64>;
	Sat, 22 Sep 2001 15:58:56 -0400
Date: Sat, 22 Sep 2001 21:59:59 +0200 (CEST)
From: Peter Magnusson <iocc@linux-kernel.flashdance.cx>
X-X-Sender: <iocc@flashdance>
To: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <Pine.LNX.4.33L2.0109222159240.26518-100000@flashdance>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:

> What do you consider as good VM?

When programs that isnt used are swapped out, or parts of them like
it worked in < 2.4.7.

> Because pages aren't 'aged' until there is swap allocated for them, your
> kernel should actually work better if it has a lot of pages backed by
> swap. The only thing is, we don't really make the right decision about

It doesnt. It just gets slower.
If it really become faster i would not have written my orginal posting.

> which pages to swap out, but that's just a detail.
>
> IMHO. A large number of cached/active pages == good.

IMHO:

Use the swap as little as possible == good.
Do you think i have 512 Mbyte of RAM just because i want
the kernel to swap out lotsa stuff? No, because it shouldnt
have the need for swapping out stuff.

