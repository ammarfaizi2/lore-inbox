Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbQLFL7F>; Wed, 6 Dec 2000 06:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130816AbQLFL6z>; Wed, 6 Dec 2000 06:58:55 -0500
Received: from ns1.netravi.net ([209.55.107.181]:36618 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131389AbQLFL6q>; Wed, 6 Dec 2000 06:58:46 -0500
Date: Wed, 6 Dec 2000 03:23:40 -0800 (PST)
From: "kernel@netravi.net" <kernel@netravi.net>
To: Gerard Sharp <gsharp@ihug.co.nz>
cc: linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
In-Reply-To: <3A2E160E.ECD6DEE9@ihug.co.nz>
Message-ID: <Pine.LNX.4.10.10012060315450.31693-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.2.17 I had good luck with BP6.

EX:

[root@animal /root]# uptime
  3:17am  up 51 days, 20:17,  2 users,  load average: 0.00, 0.04, 0.02

from /proc/pci:

Unknown mass storage controller: Triones Technologies, Inc. HPT366 IDE
Ultra
DMA/66 (rev 1).
      Medium devsel.  IRQ 5.  Master Capable.  Latency=120.  Min Gnt=8.Max
Lat=8
.
      I/O at 0xd400 [0xd401].
      I/O at 0xd800 [0xd801].
      I/O at 0xdc00 [0xdc01].
  Bus  0, device  19, function  1:

Can you post/e-mail any additional details about the lockups. I am very
curious about this. We have a huge mosix cluster in production with BP6
mobo's and have plans to upgrade to 2.4 as soon as an official stable
kernel is released.

kernel@netravi.net 
On Wed, 6 Dec 2000, Gerard Sharp wrote:

> Dan Hollis wrote:
> 
> > > No improvement in condition, alas.
> > HPT366 on BP6 is just broken. Corruption and lockups happen under
> > microsoft-windoze as well.
> 
> I think I'll run with leaving the HDD on the ATA-33 controller. 
> After all; the "100% speedup" isn't really that 
> A) noticable, or 
> B) worth this.
> 
> > -Dan
> 
> Thanks to all the little people that helped - Appreciated :)
> 
> 
> Gerard Sharp
> Two Penguins at 1024x768
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
