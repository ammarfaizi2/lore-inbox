Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbULOERx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbULOERx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbULOERx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:17:53 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:33789 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261856AbULOERp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 23:17:45 -0500
Date: Tue, 14 Dec 2004 23:17:27 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Understanding schedular and slab allocation
In-reply-to: <41BFB3F3.5010909@globaledgesoft.com>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <41BFBAD7.2000201@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <41BFB3F3.5010909@globaledgesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

krishna wrote:
> Hi all,
> 
> Can any one refer me any documentation to understand the schedular and
> slab allocation in the kernel.
> 
> Regards,
> Krishna Chaitanya
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

The slab allocator was published by Jeff Bonwick for USENIX in 94:

http://citeseer.ist.psu.edu/compress/0/papers/cs/8756/http:zSzzSzluthien.nuclecu.unam.mxzSz~miguelzSzbonwick.ps.gz/bonwick94slab.ps

(original link appears to be down)

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBv7rXdQs4kOxk3/MRAgWLAJ4rX++mRGBMAWtX2Aic9fDm7APUYgCfeFsG
3hRr2+2E6RA6mJhTlc+4FAE=
=J1k4
-----END PGP SIGNATURE-----
