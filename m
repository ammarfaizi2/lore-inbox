Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310174AbSB1WcD>; Thu, 28 Feb 2002 17:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310204AbSB1WaG>; Thu, 28 Feb 2002 17:30:06 -0500
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:47075 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S310180AbSB1WYP>; Thu, 28 Feb 2002 17:24:15 -0500
Message-ID: <01bc01c1c0a6$a3c315e0$bb3147ab@amer.cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: <root@chaos.analogic.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020228170705.2670A-100000@chaos.analogic.com>
Subject: Re: question about running program from a RAM disk
Date: Thu, 28 Feb 2002 14:24:07 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the final system we are going to turn off swap. I had dreamed that Linux
could directly use the page frame on the RAM disk instead of doing another
copy :-)

Thanks for the reply

Hua

----- Original Message -----
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: "Hua Zhong" <hzhong@cisco.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Thursday, February 28, 2002 2:12 PM
Subject: Re: question about running program from a RAM disk


> On Thu, 28 Feb 2002, Hua Zhong wrote:
>
> > Hi all:
> >
> > If I run a program from a RAM disk, will Linux be able to run it
directly
> > from
> > the disk itself (as the image is already in memory), or do it the same
way
> > as running from a disk?
> >
> > Thanks.
> >
> > Hua
>
> It does it the same was as from a mechanical disk. If it uses
> dynamic linking, the default, the runtime libraries are
> memory-mapped and shared. In a perfect system, a very large
> program is not read into user's virtual address space all at
> once. Page-faults bring in, or discard, pages as required.
>
> Cheers,
> Dick Johnson
>
> Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
>
>         111,111,111 * 111,111,111 = 12,345,678,987,654,321
>

