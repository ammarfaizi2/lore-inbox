Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130159AbQLJI6s>; Sun, 10 Dec 2000 03:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQLJI6k>; Sun, 10 Dec 2000 03:58:40 -0500
Received: from 213-123-73-95.btconnect.com ([213.123.73.95]:2308 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129884AbQLJI6S>;
	Sun, 10 Dec 2000 03:58:18 -0500
Date: Sun, 10 Dec 2000 08:29:48 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18 almost...
In-Reply-To: <3A32C128.1ED29FA2@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.21.0012100828490.798-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my fault, my fault! Sorry, dontdiff updated on 

http://www.moses.uklinux.net/patches/dontdiff

the old one contained vmlinux.lds which would is good for kdb kernels
where vmlinux.lds is automatically generated at runtime.

Regards,
Tigran


On Sat, 9 Dec 2000, Michael Rothwell wrote:

> Alan Cox wrote:
> > 
> > The patch I intend to be 2.2.18 is out as 2.2.18pre26 in the usual place.
> > I'll move it over tomorrow if nobody reports any horrors, missing files etc
> 
> 
> Fresh 2.2.17, "patch -p1 < /pre-patch-2.2.18-26"
> 
> can't find file to patch at input line 38909
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |diff -u --new-file --recursive --exclude-from /usr/src/exclude
> v2.2.17/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
> |--- v2.2.17/arch/i386/vmlinux.lds	Wed May  3 21:22:13 2000
> |+++ linux/arch/i386/vmlinux.lds	Sat Dec  9 21:23:21 2000
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
