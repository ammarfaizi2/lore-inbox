Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQKTRWm>; Mon, 20 Nov 2000 12:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129368AbQKTRWc>; Mon, 20 Nov 2000 12:22:32 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:56082 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S129345AbQKTRWQ>;
	Mon, 20 Nov 2000 12:22:16 -0500
Date: Mon, 20 Nov 2000 17:52:09 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: Andrei Smirnov <andrei@ds5500.cemr.wvu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.16 does not compile
In-Reply-To: <Pine.ULT.3.96.1001120110905.28412A-100000@ds5500>
Message-ID: <Pine.LNX.4.30.0011201751020.1451-100000@toor.thn.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrei Smirnov wrote:

>
> I have a newly installed RH-7.0 distribution on a Celeron Pentium 400.
> When I tried to compile the kernel I got the following:
>
> 1. I ran make xconfig (or make menuconfig) and saved without changing any
>    options - completed OK
>
> 2. make dep: OK.
>
> 3. make zImage: produced the following output:
>
*** LOTS SNIPPED ***
>
>



Did you edit the Makefile in /usr/src/linux and changed the line that
reads:
HOSTCC          = gcc
to
HOSTCC          = kgcc


?

/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6GVa9USLExYo23RsRAtvCAKCYU2cpI+uKLfcksk44pIZWVlrYcgCgm5Fp
9XiqohikNCcCVwb3IL8X6G8=
=Nv18
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
