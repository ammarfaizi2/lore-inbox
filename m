Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270819AbRHSWRA>; Sun, 19 Aug 2001 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270818AbRHSWQu>; Sun, 19 Aug 2001 18:16:50 -0400
Received: from Expansa.sns.it ([192.167.206.189]:38156 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S270817AbRHSWQh>;
	Sun, 19 Aug 2001 18:16:37 -0400
Date: Mon, 20 Aug 2001 00:16:46 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Steven Cole <elenstev@mesatop.com>
cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, <gars@lanm-pc.com>
Subject: Re: Swap size for a machine with 2GB of memory
In-Reply-To: <200108191753.f7JHr8e27206@thor.mesatop.com>
Message-ID: <Pine.LNX.4.33.0108200009310.7105-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, i changed this value.
But i also changed a lot of other #define with bigger values, because
of the eavy use of all HW resources my users were needing. (maximum number
of processes and so on...)

It has been funny.
First i installed via NFS the slackware-current for sparc (now obsoleted,
and developed at sourceforge as splackware),
then i upgraded the kernel, then i installed a new disk
to make the swap and so on...

The latest kernel i used before the 3500 was sended to other uses
was 2.4.7.

The worser kernel on that server was 2.4.5, absolutelly it had the worst
VM i ever saw on ultrasparc.

Luigi


On Sun, 19 Aug 2001, Steven Cole wrote:

> On Sunday 19 August 2001 01:29 pm, Luigi Genoni wrote:
> [snipped]
> > On my ultrasparc linux with 4 GByte of RAM running 2.4.X kernels,
> > I needed to add a 8 GB disk just for
> > swap (16 partitions of 512 MB each one).
> --------^^
> Just curious, in linux-2.4.9/include/linux/swap.h line 11, we have:
>
> #define MAX_SWAPFILES 8
>
> Did you change this to 16, or does this not matter anymore?
> This value is the same in 2.4.8-ac7.
>
> Steven
>

