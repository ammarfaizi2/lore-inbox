Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268560AbRHBSxc>; Thu, 2 Aug 2001 14:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268556AbRHBSxW>; Thu, 2 Aug 2001 14:53:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8064 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268511AbRHBSxH>; Thu, 2 Aug 2001 14:53:07 -0400
Date: Thu, 2 Aug 2001 14:52:24 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Jeffrey W. Baker" <jwbaker@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33.0108021122400.21298-100000@heat.gghcwest.com>
Message-ID: <Pine.LNX.3.95.1010802144823.4472A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:

> This just in: Linux 2.4 VM still useless.
> 
> I have 2 GB main memory and 4GB swap on a 2-way intel machine running a
> variety of 2.4 kernels (we upgrade every time we have to reboot), and we
> have to power cycle the machine weekly because too much memory usage + too
> much disk I/O == thrash for hours.
> 
> Gosh, I guess it is silly to use all of the available RAM and I/O
> bandwidth on my machines.  My company will just go out of their way to
> do less work on smaller sets of data.
> 

Are you sure it's not just come user-code with memory leaks? I use
2.4.1 on an embeded system with no disks, therefore no swap. It does
large FFT arrays to make spectrum-analyzer pictures and it has never
seen any problems with VM, in fact never any problems that can be
blamed on the Operating System.

Try 2.4.1 and see if your problems go away. If not, you probably
have user-mode leakage.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


