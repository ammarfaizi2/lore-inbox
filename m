Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWKHQU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWKHQU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbWKHQU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:20:29 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:28565 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S1161130AbWKHQU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:20:28 -0500
Date: Wed, 8 Nov 2006 17:20:22 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: How to interpret MCE messages?
Message-ID: <20061108162022.GA4258@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
X-OS: Debian GNU/Linux 4.0 kernel 2.6.17-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks to mcelog, I am now regularly seeing messages like this on an
amd64 machine:

  kernel: Machine check events logged
        bit46 =3D corrected ecc error
    Data cache ECC error (syndrome 5b)
    memory/cache error 'data read mem transaction, data transaction, level =
2'
  ADDR 38ed9200
  CPU 0 0 data cache TSC fe4f9128ade
  MCE 0
  STATUS 942dc00000000136 MCGSTATUS 0

The RAM modules are *not* ECC modules, nor does the Asus K8V Deluxe
motherboard support ECC to my knowledge. I've turned ECC support on
and off in the Bios without any effect.

I've already run memtest86+ for hours without finding any problems,
and I've removed each of the two memory modules for a while, but
I still saw these errors appearing.

Before I go out and buy a new motherboard (as I assume that it's
a L1/L2 cache problem), I'd like to know how I am to interpret these
MCE dumps and how I could use them to actually pinpoint the source
of the problem.

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"america may be unique in being a country which has leapt
 from barbarism to decadence without touching civilization."
                                                        -- john o'hara

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUgPGIgvIgzMMSnURAihKAJ0f7R1rWo8D6iOdNqZQh1LGoCzmdgCgmZyP
ZhV61xEMhLa1cdP3JCpPjdY=
=xiI9
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
