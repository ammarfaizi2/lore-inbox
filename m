Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbQLQAsW>; Sat, 16 Dec 2000 19:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131350AbQLQAsC>; Sat, 16 Dec 2000 19:48:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130211AbQLQArz>; Sat, 16 Dec 2000 19:47:55 -0500
Subject: Re: Unable to boot 2.4.0-test12 (0224 AX:0212 BX:BC00 CX:5101 DX:000.)
To: peter@cadcamlab.org (Peter Samuelson)
Date: Sun, 17 Dec 2000 00:19:22 +0000 (GMT)
Cc: infernix@infernix.nl (infernix),
        nkbj@image.dk (Niels Kristian Bech Jensen),
        linux-kernel@vger.kernel.org (Linux kernel developer's mailing list)
In-Reply-To: <20001216172518.M3199@cadcamlab.org> from "Peter Samuelson" at Dec 16, 2000 05:25:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147RXw-0003OG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As someone (Jeff Garzik?) was saying a week or two ago, can we please
> kill the x86 boot sector already?  With today's kernels, 'over 500k or
> so' is probably the common case.  Is there *anything* the builtin code
> can do better than syslinux?

Its just plain easier to use

	scp arch/i386/boot/bzImage somebox:/dev/fd0
	ssh root@somebox reboot

is how I do at least part of my testing


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
