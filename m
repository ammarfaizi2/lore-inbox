Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310530AbSCEIiB>; Tue, 5 Mar 2002 03:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310526AbSCEIhv>; Tue, 5 Mar 2002 03:37:51 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:4513 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S310522AbSCEIhm>;
	Tue, 5 Mar 2002 03:37:42 -0500
Date: Tue, 5 Mar 2002 08:35:51 GMT
Message-Id: <200203050835.g258ZpW25134@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020305005215.U20606@dualathlon.random>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-21 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020305005215.U20606@dualathlon.random> you wrote:

> I don't see how per-zone lru lists are related to the kswapd deadlock.
> as soon as the ZONE_DMA will be filled with filedescriptors or with
> pagetables (or whatever non pageable/shrinkable kernel datastructure you
> prefer) kswapd will go mad without classzone, period.

So does it with class zone on a scsi system....
