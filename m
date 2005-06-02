Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVFBKef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVFBKef (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 06:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVFBKef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 06:34:35 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:5015 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261363AbVFBKe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 06:34:26 -0400
Message-ID: <429EE0A7.7090305@poczta.fm>
Date: Thu, 02 Jun 2005 12:34:15 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo> <d120d500050531122879868bae@mail.gmail.com> <429DDA07.nail7BFA4XEC5@burner> <d120d50005060109051f9ade82@mail.gmail.com> <429DEA5B.nail7BFNJVI78@burner>
In-Reply-To: <429DEA5B.nail7BFNJVI78@burner>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDDF63C4EB31F5A2DDE8A8A4C"
X-EMID: c2ddb138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDF63C4EB31F5A2DDE8A8A4C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Joerg Schilling napisa=C5=82(a):

> The natural way to access SCSI is the method I use, ASPI uses and FreeB=
SD
> uses..... If Linux likes to implement things differntly, they are free
> to do so but the Linux authors need to learn that I don't like to spend=
 my
> time on somethign that might be useless next week.

This will be my next 2 cents.

The *natural* way to access any device is its device file in the /dev/
directory.

I've "straced" cdrecrod few times when it coundn't do scnabus properly.
What I have discovered is that cdrecord *just* tries to open several
devices that *might* be recorders. There is no need to use USB for this
to fail. For example if I had /dev/hda HDD and /dev/hdc CDR (no one
attaches both on one channel) cdrecord stopped as it faild to open hdb
while ther was no such file. Do I have to create device file if I ve got
no device?

The only thing we all ask is to make it possible to choose manually the
device node cdrecord is trying to detect. That is a 'mechanism not
polisy' thing. Let the other software insure the stabilit of naming.

Best regards.
--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enigDDF63C4EB31F5A2DDE8A8A4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCnuCsNdzY8sm9K9wRApm4AKCAPnsdRqRnYyvmFM2ENZzNW3rmcACfZ3Bt
G+/tE62WNd8kda5dRHPEHcw=
=k1ka
-----END PGP SIGNATURE-----

--------------enigDDF63C4EB31F5A2DDE8A8A4C--
