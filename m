Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTHYQmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbTHYQmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:42:51 -0400
Received: from [62.241.33.80] ([62.241.33.80]:27397 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262005AbTHYQml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:42:41 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: adefacc@tin.it, linux-kernel@vger.kernel.org
Subject: Re: linux-2.2 future?
Date: Mon, 25 Aug 2003 18:42:15 +0200
User-Agent: KMail/1.5.3
References: <3F468ABD.1EBAD831@tin.it>
In-Reply-To: <3F468ABD.1EBAD831@tin.it>
Cc: Ruben =?iso-8859-1?q?P=FCttmann?= <ruben@puettmann.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ville Herva <vherva@niksula.hut.fi>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308251815.20131.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 August 2003 23:27, A.D.F. wrote:

Hi A. De Faccio

> > I think 2.2 is not dead. I often see 2.2 kernels running on systems like
> > wlan access points or dsl routers from different vendors. 2.2 is often
> > used where stability is a must-have. At least security fixes have to go
> > in.
> I agree.
> > What do you think?
> Well, I think that 2.2.24 and 2.2.25 kernels are really stable (at least on
> UP), but that the most weak side is on IDE disk drivers.

My -secure tree is also rock solid on SMP :p

> They seem to have DMA problems when using recent hard disks (i.e. Maxtor,
> etc.) that lead to serious file system corruption problems.
> Maybe there are also geometry problems because all troubles have been
> observed on disks with more than 32 GB of capacity (i.e. 40 GB).
> This is a pity because, up to now, 2.2.x kernels have been
> a valid choice for small / semi-embedded systems 80x86
> (yes, I know that 2.4 should be better, but I'm still waiting for
> a stable rock kernel).

I agree on this. Therefore my 2.2-secure tree has a 2.4 IDE backport from the 
PLD Project by Krzysiek Taraszka & Krzysiek Oledzki. It's not that up2date 
like .21 and .22 IDE code is, but it works very very smooth and nice and rock 
solid. We use the 2.2-secure tree for almost all customers in my company. 
Biggest harddisk is a 160GB Maxtor IDE disk.

> In conclusion, I hope that next maintainer will think about
> these matters:
> 	IDE drivers;

ack!

> 	security fixes;

ack! Current 2.2 is missing, for example, hashing exploits in network stack, 
like 2.4 had some time ago.

> 	micro-optimizations;

also done in 2.2-secure

> 	compatibility with newer compilers.

This might be the hardest job. This is not done in 2.2-secure. I think the 
effort in doing this is not worth the time it takes.

> After all if 2.0 seems to be still alive also 2.2 should be.

I agree 100%. Anyway, no comment from Alan, so I think he don't want to give 
2.2 away to me.

P.S.: I've cc'ed Ruben, Alan and Ville.

ciao, Marc

