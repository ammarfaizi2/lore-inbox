Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314052AbSEVN7o>; Wed, 22 May 2002 09:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314056AbSEVN7n>; Wed, 22 May 2002 09:59:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41727 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314052AbSEVN7m>;
	Wed, 22 May 2002 09:59:42 -0400
Date: Wed, 22 May 2002 09:59:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <3CEB9465.6040409@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0205220957320.2737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Martin Dalecki wrote:

> So at least we know now:
> 
> 1. Kernel is bogous.
> 2. util-linux is bogous.
> 
> IOCTL is ineed the way to go to implement such functionality...

For kbdrate???  sysctl I might see - after all, we are talking about
setting two numbers.  ioctl() to pass a couple of integers to the kernel?
No, thanks.

