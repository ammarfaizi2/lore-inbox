Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261772AbSI2TxT>; Sun, 29 Sep 2002 15:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261769AbSI2TxA>; Sun, 29 Sep 2002 15:53:00 -0400
Received: from mail-7.tiscali.it ([195.130.225.153]:56234 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S261766AbSI2TwP> convert rfc822-to-8bit;
	Sun, 29 Sep 2002 15:52:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Organization: -ENOENT
To: bert hubert <ahu@ds9a.nl>
Subject: Re: qsbench, interesting results
Date: Sun, 29 Sep 2002 21:56:35 +0200
User-Agent: KMail/1.4.3
References: <200209291615.24158.l.allegrucci@tiscalinet.it> <20020929162627.GA1270@outpost.ds9a.nl>
In-Reply-To: <20020929162627.GA1270@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-Id: <200209292156.35518.l.allegrucci@tiscalinet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 September 2002 18:26, you wrote:
> On Sun, Sep 29, 2002 at 04:15:24PM +0200, Lorenzo Allegrucci wrote:
> > qsbench is a VM benchmark based on sorting a large array
> > by quick sort.
> > http://web.tiscali.it/allegrucci/qsbench-1.0.0.tar.gz
> >
> > Below are some results of qsbench sorting a 350Mb array
> > on a 256+400Mb RAM+swap machine.
> > Tested kernels: 2.4.19, 2.5.38 and 2.5.39
> > All runs made with the same default seed, to compare
> > apples with apples :)
>
> Check if the seed is really identical.

It's set in the code, you can change it only using the "-s" option.

>Furthermore, can you check how much
> lowmem is actually available according to the dmesg output? It may be that
> your graphics adaptor is using ram in one kernel but not in another.

The memory available is about the same in all tests, and all
tests have been run in single user mode.

