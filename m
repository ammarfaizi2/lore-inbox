Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRALP7x>; Fri, 12 Jan 2001 10:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131684AbRALP7n>; Fri, 12 Jan 2001 10:59:43 -0500
Received: from ega010000096.lancs.ac.uk ([148.88.153.219]:32260 "EHLO
	egb070000014.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131669AbRALP7g>; Fri, 12 Jan 2001 10:59:36 -0500
Date: Fri, 12 Jan 2001 15:57:30 +0000 (GMT)
From: Stephen Torri <s.torri@lancaster.ac.uk>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux booting from HD on Promise Ultra ATA 100
In-Reply-To: <Pine.LNX.4.21.0101121653220.6280-100000@tux.rsn.hk-r.se>
Message-ID: <Pine.LNX.4.21.0101121555240.4828-100000@egb070000014.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 12 Jan 2001, Martin Josefsson wrote:

> My setup looks like this, I boot from hde
> I configured my BIOS to boot from SCSI (I have no scsi-adapter but the
> promise card reports itself as one at boottime)
> 
> boot = /dev/hde3
> delay = 50
> message = /boot/message
> vga = extended
> read-only
> lba32
> disk=/dev/hde
>   bios=0x80


The line "lba32" is for what? I have to ask this because I have never seen
it in an example of a lilo.conf file before.

Also you put "disk=/dev/hde and bios=0x80" to inform lilo that there was a
disk there and its bios address is 0x80. Is this right?

If I would follow your example then I would put:

lba32
disk=/dev/hdf
   bios=0x82

Stephen

- -- 
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org
Filter: gpg4pine 4.0 (http://azzie.robotics.net)

iD8DBQE6XyltI7ZT+dSlizsRAiM/AJ9SdDSNbYk1Pep2+guGakfYcYUYjQCgzLWR
BcrGeMP0DKwgZWo3m0KdEho=
=gGWn
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
