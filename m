Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132215AbRAQTCj>; Wed, 17 Jan 2001 14:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132129AbRAQTC3>; Wed, 17 Jan 2001 14:02:29 -0500
Received: from kea.grace.cri.nz ([131.203.4.51]:65292 "EHLO kea.grace.cri.nz")
	by vger.kernel.org with ESMTP id <S131742AbRAQTCO>;
	Wed, 17 Jan 2001 14:02:14 -0500
Date: Wed, 17 Jan 2001 14:00:57 -0500 (EST)
Message-Id: <200101171900.OAA11477@whio.grace.cri.nz>
From: roger@kea.grace.cri.nz
To: mdresser@windsormachine.com
CC: roger@kea.grace.cri.nz, linux-kernel@vger.kernel.org
In-Reply-To: <3A65BBDA.229D9A2F@windsormachine.com> (message from Mike Dresser on Wed, 17 Jan 2001 10:35:54 -0500)
Subject: Re: Linux v.2.4.0 and Netscape 4.76?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Dresser wrote:

>echo 0  > /proc/sys/net/ipv4/tcp_ecn
>or remove ecn from your kernel compile.

Several people have made this suggestion.
However ECN has never been part of my kernel
(hence /proc/sys/net/ipv4/tcp-ecn does not exist.

Thanks, anyway, for your suggestion.

Roger Young.


.......................................................................
> It concerns the behaviour of Netscape after upgrading from kernel
> 2.2.16 to 2.4.0. With the new kernel Netscape locates and connects to
> a URL, and sometimes begins to download, but then it just sits there
> indefinitely (without downloading any data). This happens quite
> consistently since I upgraded to 2.4.0 (about 2 weeks ago).  ppp,
> telnet, ftp all function satisfactorily as far as I can determine
> (however that's not to say that the problem doesn't originate with
> ppp in the kernel). There are a few packet errors (about 1 per 1000).
> Netscape continues to function well with Linux kernel 2.2.16 -- but
> not with 2.4.0.

echo 0  > /proc/sys/net/ipv4/tcp_ecn

or remove ecn from your kernel compile.

It's a known problem with Cisco PIX firewalls

Hope this helps,

Mike Dresser
sysadmin,
Windsor Machine & Stamping


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
