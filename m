Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270787AbRHWXvb>; Thu, 23 Aug 2001 19:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270784AbRHWXvV>; Thu, 23 Aug 2001 19:51:21 -0400
Received: from [209.202.108.240] ([209.202.108.240]:65287 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S270797AbRHWXvL>; Thu, 23 Aug 2001 19:51:11 -0400
Date: Thu, 23 Aug 2001 19:50:59 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Fred <fred@arkansaswebs.com>
cc: Tony Hoyle <tmh@nothing-on.tv>, <linux-kernel@vger.kernel.org>
Subject: Re: File System Limitations
In-Reply-To: <01082318405901.12319@bits.linuxball>
Message-ID: <Pine.LNX.4.33.0108231950020.14247-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Fred wrote:

> glibc-2.2.2-10
>
> dd if=/dev/zero of=./tgb count=4000 bs=1M
>
> created file of 2147483647 bytes
>
> [root@bits /a5]# dd if=/dev/zero of=./tgb count=4000 bs=1M
> File size limit exceeded (core dumped)
> [root@bits /a5]#
>
> is glibc part of gcc? where do i find glibc?
> (I've recently compiled gcc-3.00, but won't install cause it breaks kernel
> compilations).
>
>
> TIA
>
> Fred

It looks as though dd has not been built with long file support. Most software
on a stock Red Hat install hasn't.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

