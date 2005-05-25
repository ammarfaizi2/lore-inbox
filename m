Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVEYPDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVEYPDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVEYPDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:03:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:14293 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262354AbVEYPDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:03:42 -0400
Message-ID: <42949431.7000006@punnoor.de>
Date: Wed, 25 May 2005 17:05:21 +0200
From: Prakash Punnoor <lists@punnoor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050511)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp and kernel 2.6.12-rc4 does not work
References: <429353F8.5070404@punnoor.de> <20050525130123.GA1881@elf.ucw.cz>
In-Reply-To: <20050525130123.GA1881@elf.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD00E9A2AD5C993A525324312"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD00E9A2AD5C993A525324312
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Pavel Machek schrieb:
> On =DAt 24-05-05 18:19:04, Prakash Punnoor wrote:
>=20
>>Hi,
>>
>>I haven't treid with an earlier kernel. I am using an Sony Vaio PCG-F8=DF=
07K
>>notebook and tried to suspend.
>>
>>What goes wrong is, that the hd gets shut down before anything is writt=
en to it.
>>
>>I see (leaving some details out):
>>
>>Stopping task:=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D|
>>Freeing memory..done (40502 pages freed)
>>swsusp: Need to copy 6953 pages
>>swsusp: critical section/: done (6981 pages copied)
>>ACPI: PCI Interrupt yadda yadda.. -> IRQ 9
>>
>>and there it sits. Is it really just the problem, that the hd gets shut=
 down
>>too early? Is there an easy way to fix this?
>=20
>=20
> Disk shutdown is normal, you have other problem. Try again with
> minimal drivers.

But shouldn't this happen, *after* memory image is written into swap?
Otherwiese disk shuts down, spins up, writes image, shuts down, which is =
not
too healthy for the hd.

I'll try with minimal drivers anyway.

Prakash


--------------enigD00E9A2AD5C993A525324312
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFClJQxxU2n/+9+t5gRAn9dAJ0VReHtO7SXefnEtqxl31vVjyH/NQCgiJy0
+udw+j0EQkvI9Ic6aCyhDz8=
=5R6n
-----END PGP SIGNATURE-----

--------------enigD00E9A2AD5C993A525324312--
