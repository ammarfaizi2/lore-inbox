Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272334AbSISTKV>; Thu, 19 Sep 2002 15:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272400AbSISTKV>; Thu, 19 Sep 2002 15:10:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15746 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272334AbSISTKU>; Thu, 19 Sep 2002 15:10:20 -0400
Date: Thu, 19 Sep 2002 15:18:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brian Gerst <bgerst@didntduck.org>
cc: Richard Henderson <rth@twiddle.net>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
In-Reply-To: <3D8A1CC0.8070407@didntduck.org>
Message-ID: <Pine.LNX.3.95.1020919151622.15882A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Brian Gerst wrote:

> Richard Henderson wrote:
> > On Thu, Sep 19, 2002 at 02:04:43PM -0400, Brian Gerst wrote:
> > 
> >>Now that I've thought about it more, I think the best solution is to go 
> >>through all the syscalls (a big job, I know), and declare the parameters 
> >>as const, so that gcc knows it can't modify them, and will throw a 
> >>warning if we try.
> > 
> > 
> > The parameter area belongs to the callee, and it may *always* be modified.
> > 
> > 
> > r~
> > 
> 
> The parameters can not be modified if they are declared const though, 
> that's my point.

Yes. A temporary declaration change to compile the kernel and
see where it complains.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

