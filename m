Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSEYI4o>; Sat, 25 May 2002 04:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSEYI4n>; Sat, 25 May 2002 04:56:43 -0400
Received: from squeaker.ratbox.org ([63.216.218.7]:19468 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S314277AbSEYI4m>; Sat, 25 May 2002 04:56:42 -0400
Date: Sat, 25 May 2002 04:56:41 -0400 (EDT)
From: Aaron Sethman <androsyn@ratbox.org>
To: linux-kernel@vger.kernel.org
Subject: Re: RT Sigio broken on 2.4.19-pre8
In-Reply-To: <Pine.LNX.4.44.0205250433050.9132-100000@simon.ratbox.org>
Message-ID: <Pine.LNX.4.44.0205250446200.9132-100000@simon.ratbox.org>
X-GPG-FINGRPRINT: 1024D/D4DE2553 0E60 59B5 60DA 2FD3 F6F5  27A3 6CD2 21AD D4DE 2553
X-GPG-PUBLIC_KEY: http://squeaker.ratbox.org/androsyn.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Actually looking at it closer... It seems rtsig-nr keeping rising slowly
as the system runs.

Regards,

Aaron

On Sat, 25 May 2002, Aaron Sethman wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> Using the Dan Kegel's Poller_bench utility I noticed that RT SIGIO is not
> working on 2.4.19-pre8.  Basically sigtimedwait() is always returning
> SIGIO.  Note that 2.4.18 works fine.
>
> Regards,
>
> Aaron
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.6 (GNU/Linux)
> Comment: For info see http://www.gnupg.org
>
> iD8DBQE8703wbNIhrdTeJVMRAlcgAJ9Bga4Y9Dj+YP1jGq6iQAtWHsTo7gCfYtC0
> MrGouDbev2gSs2nymlXNVuw=
> =R0yb
> -----END PGP SIGNATURE-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE871HLbNIhrdTeJVMRAubwAJ0a+Skpxx/88pdYKaqDkBjhR70ZRQCgqhz8
DBRtW8/9eCfzN/RkGOul+uU=
=L1qT
-----END PGP SIGNATURE-----

