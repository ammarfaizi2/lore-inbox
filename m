Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbTDOSHk (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTDOSHk 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:07:40 -0400
Received: from f25.law8.hotmail.com ([216.33.241.25]:20491 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262835AbTDOSHj 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 14:07:39 -0400
X-Originating-IP: [67.86.246.131]
X-Originating-Email: [seandarcy@hotmail.com]
From: "sean darcy" <seandarcy@hotmail.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-bk4 & 5 - boot oops at USB Mass Storage
Date: Tue, 15 Apr 2003 14:19:25 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F25oXM7e0C9guA8M6XQ0000020c@hotmail.com>
X-OriginalArrivalTime: 15 Apr 2003 18:19:25.0930 (UTC) FILETIME=[8BE35CA0:01C3037B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It now works again in bk6.

But without the call trace the rest of the oops was:
EFLAGS: 00010282
eax 00000040  ebx fffffff8 ecx fffffff0 edx ffff0001
esi 00000040  edi 00000000 ebp c0404858 esp c151df50
ds  007b es 007b  ss 0068
Process swapper ( pid: 1 threadinfo c151c00 task dff8e040 )
........
<0> Kernel panic: Attempted to kill init!

that was as far as I got before my "energy-star" monitor went to power save 
:).

>From: Greg KH <greg@kroah.com>
>To: sean darcy <seandarcy@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: 2.5.67-bk4 & 5  - boot oops at  USB Mass Storage
>Date: Tue, 15 Apr 2003 09:33:14 -0700
>
>On Tue, Apr 15, 2003 at 08:42:53AM -0400, sean darcy wrote:
> > 2.5.67 boots fine. With bk4 or bk5 I get an oops right after:
> >
> > USB Mass Storage support registered
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 
>00000040
> > printing EIP:
> > c026af44
> > *pde=00000000
> > oops: 0002 [#1]
> > cpu: 0
> > EIP: 0060:[c026af44] Not tainted
>
>Ah, so close, can you please report back everything that the oops
>message said?
>
>thanks,
>
>greg k-h


_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE*  
http://join.msn.com/?page=features/virus

