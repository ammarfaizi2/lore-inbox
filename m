Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130984AbQLPX43>; Sat, 16 Dec 2000 18:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbQLPX4T>; Sat, 16 Dec 2000 18:56:19 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:14862 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130984AbQLPX4D>; Sat, 16 Dec 2000 18:56:03 -0500
Date: Sat, 16 Dec 2000 17:25:18 -0600
To: infernix <infernix@infernix.nl>
Cc: Niels Kristian Bech Jensen <nkbj@image.dk>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Unable to boot 2.4.0-test12 (0224 AX:0212 BX:BC00 CX:5101 DX:000.)
Message-ID: <20001216172518.M3199@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.30.0012160521580.2805-100000@hafnium.nkbj.dk> <Pine.LNX.4.21.0012161651390.5677-100000@server.ggmc.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012161651390.5677-100000@server.ggmc.nl>; from infernix@infernix.nl on Sat, Dec 16, 2000 at 04:56:07PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[infernix]
> I found the cause. I read somewhere in a debian bugreport that
> bootsect.S can't handle really big (b)vmlinuz images (over 500kb
> orso). However, I am wondering why 'make bzdisk' doesn't give me an
> error or a warning.

As someone (Jeff Garzik?) was saying a week or two ago, can we please
kill the x86 boot sector already?  With today's kernels, 'over 500k or
so' is probably the common case.  Is there *anything* the builtin code
can do better than syslinux?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
