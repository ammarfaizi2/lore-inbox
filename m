Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbULWJv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbULWJv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 04:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbULWJv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 04:51:27 -0500
Received: from pop.gmx.net ([213.165.64.20]:38296 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261194AbULWJvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 04:51:23 -0500
X-Authenticated: #4512188
Message-ID: <41CA9515.4010106@gmx.de>
Date: Thu, 23 Dec 2004 10:51:17 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Kristian Eide <kreide@online.no>, linux-kernel@vger.kernel.org
Subject: Re: raid5 crash
References: <200412222304.36585.kreide@online.no> <16841.65119.240314.917998@cse.unsw.edu.au>
In-Reply-To: <16841.65119.240314.917998@cse.unsw.edu.au>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig51CF4494C56325E4984ED2D4"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51CF4494C56325E4984ED2D4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Neil Brown schrieb:
> On Wednesday December 22, kreide@online.no wrote:
> 
>>I am running kernel 2.6.9-gentoo-r10 on an Athlon XP 2400+ computer with a SiI 
>>3114 SATA controller hosting 4 WD2500JD-00G drives. I have combined these 
>>drives into a raid5 array using software raid, but unfortunately the array is 
>>not stable. I have tried several filesystems (ext3, reiserfs, xfs), but after 
>>copying several gigabytes of data into the array (using scp) and then trying 
>>to read them back (using rsync to compare over the network) always results in 
>>data corruption. Here is the output from 'dmesg':
>>
>>kernel BUG at drivers/md/raid5.c:813!

Have you a bios option called ext-p2p discard time? Try setting it 
higher. I posted another thread about sii3112 at lkml about this issue...

Prakash

--------------enig51CF4494C56325E4984ED2D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBypUZxU2n/+9+t5gRAo0bAJwKbKPFteqkmoKA4naW8bUNtrxJXgCg6I92
9+JkJ/e2zCHl67+EkN8aQhs=
=t9Zr
-----END PGP SIGNATURE-----

--------------enig51CF4494C56325E4984ED2D4--
