Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVFHTgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVFHTgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVFHTgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:36:44 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:59172 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261567AbVFHTgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:36:16 -0400
Message-ID: <42A7489F.10604@poczta.fm>
Date: Wed, 08 Jun 2005 21:35:59 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Advices for a lcd driver design. (suite)
References: <20050608084224.53355.qmail@web25805.mail.ukl.yahoo.com>
In-Reply-To: <20050608084224.53355.qmail@web25805.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5ABF5EF5B519566BB8D6E3C9"
X-EMID: 9a4e138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5ABF5EF5B519566BB8D6E3C9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

moreau francis napisa=C5=82(a):

>>I think the "buffer" could be shadowed in kernel and updated
>> periodically.
> Ok I can try using frame buffer, but I'm afraid to use such code for su=
ch
> small graphic device.
[...]
> Do you know if I can find an example in kernel code for such implementa=
tion ?

I am afraid I don't know much about fb internals. I haven't used it much
  as a user nor written any fb code.

>>Yes and no. No because framebuffer is about drawing graphics not text
>>and yest for there is fbcon console driver on top of the framebuffer. A=
t
>>least AFAIK.
>=20
> does that mean once there is fbcon console driver set up on top of fram=
ebuffer
> I can't use anymore /dev/fb for drawing graphics ?

Of course not! :) As I stated I haven't used fb much but I have ran
mplayer right on top of the content of the output of "ls -l /dev".

Try to find something in:
/usr/src/linux/drivers/video/console/fbcon.c

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig5ABF5EF5B519566BB8D6E3C9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCp0imNdzY8sm9K9wRAofeAKCAqwMlu/3/nuVKuDNPP52xs0oDcgCdGVKv
T49wy28TXo/qxoTP4+RtfsI=
=j1J8
-----END PGP SIGNATURE-----

--------------enig5ABF5EF5B519566BB8D6E3C9--
