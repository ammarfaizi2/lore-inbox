Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbULFPIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbULFPIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbULFPI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:08:29 -0500
Received: from pop.gmx.net ([213.165.64.20]:23500 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261271AbULFPID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:08:03 -0500
X-Authenticated: #4512188
Message-ID: <41B475CD.9060409@gmx.de>
Date: Mon, 06 Dec 2004 16:07:57 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041203)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       helge.hafting@hist.no
Subject: Re: [PATCH] Time sliced CFQ #3
References: <20041204104921.GC10449@suse.de> <41B426D4.6080506@gmx.de> <20041206093517.GJ10498@suse.de> <41B45134.4040005@gmx.de> <20041206132749.GX10498@suse.de>
In-Reply-To: <20041206132749.GX10498@suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDB4C1AB6A8DB8430F3BFADF4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDB4C1AB6A8DB8430F3BFADF4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe schrieb:
> Depends on where it died, really. But the chances are probably slim.
> 
> If you feel like giving it another go, I've uploaded a new patch here:


So, I was brave ;-) and tried another go with this one. Seems to work 
this time. Still the issue with sustained write rate, but this time my 
mailer is still somewhat usable while writing. It gets to a crawl, but 
it still reacts....so I'd consider this a little progress (with the help 
of a regression).

Cheers,

Prakash

--------------enigDB4C1AB6A8DB8430F3BFADF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBtHXNxU2n/+9+t5gRAjsKAKDQW0hG0Ul04bY7e3rxPVGQp/LtggCdEhTP
mAFBV8+iBXYybCXZp5wAlQw=
=UjW1
-----END PGP SIGNATURE-----

--------------enigDB4C1AB6A8DB8430F3BFADF4--
