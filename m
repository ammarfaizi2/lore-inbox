Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318501AbSHLARX>; Sun, 11 Aug 2002 20:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318510AbSHLARW>; Sun, 11 Aug 2002 20:17:22 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:34788 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S318501AbSHLARW>; Sun, 11 Aug 2002 20:17:22 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Adrian Bunk <bunk@fs.tum.de>, Julien BLACHE <jb@technologeek.org>,
       <greg@kroah.com>
Subject: Re: [2.5 patch] tiglusb.c must include version.h
Date: Mon, 12 Aug 2002 10:12:47 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.NEB.4.44.0208111416110.3636-100000@mimas.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.NEB.4.44.0208111416110.3636-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208121012.59099.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 11 Aug 2002 22:20, Adrian Bunk wrote:
> Compile error in 2.5.31:
<snip>
> line 44 is:
>   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
>
>
> The fix is simple:
<snip>
> +#include <linux/version.h>

Wouldn't it be cleaner to just remove this case? It is in 2.5, after all.

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Vv2KW6pHgIdAuOMRAkDxAJ0fGa94qr39MYXul6npXVcyBYkhzACfU84t
rG1pdMxk4LnlsF0w5PzQCzU=
=cwOV
-----END PGP SIGNATURE-----

