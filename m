Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266804AbSKOVqT>; Fri, 15 Nov 2002 16:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbSKOVqT>; Fri, 15 Nov 2002 16:46:19 -0500
Received: from [68.96.149.130] ([68.96.149.130]:27093 "EHLO resonant.org")
	by vger.kernel.org with ESMTP id <S266804AbSKOVqS>;
	Fri, 15 Nov 2002 16:46:18 -0500
Date: Fri, 15 Nov 2002 15:52:56 -0600
From: Zed Pobre <zed@resonant.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI patches updated (20021111)
Message-ID: <20021115215256.GB21928@resonant.org>
Mail-Followup-To: Zed Pobre <zed@resonant.org>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9@orsmsx119.jf.intel.com> <1037223183.16635.59.camel@dell_ss3.pdx.osdl.net> <20021115150113.GA18126@resonant.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <20021115150113.GA18126@resonant.org>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
X-GPG-Fingerprint: FF 75 8D 70 57 8D A4 7D  3A DE 6D 2F 25 C3 E6 E7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2002 at 09:01:13AM -0600, Zed Pobre wrote:
> On Wed, Nov 13, 2002 at 01:33:03PM -0800, Stephen Hemminger wrote:
> > Will this fix problems with IRQ routing.
> > On our SMP test machines, ACPI has to be disabled otherwise the SCSI
> > disk controllers don't work.
>=20
>     As a further data point, if ACPI is enabled on my non-SMP test
> machine, USB stops working.
[... and if ACPI is disabled, the net stops working...]

    I take this back.  After seeing the thread about buggy IO-APIC on
uniprocessor machines, I tested disabling IO-APIC, and all of my
problems magically went away.

--=20
Zed Pobre <zed@debian.org> a.k.a. Zed Pobre <zed@resonant.org>
PGP key and fingerprint available on finger; encrypted mail welcomed.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQEVAwUBPdVsuB0207zoJUw5AQFq4QgAg2lbY8ZJrbtFEkr8byF+J2ISszr+pfRx
D5acjYV8fPUVvad5sMBa+VBNfdDySYzOzLk2q4xR1enIRZw/1ZlT/nnmtGZGdUUb
FyjPkFtW7+VKkoRKiLocb80EkLA7cYpjtP/B1+WVdYORUOVsQkFuR34d26mvzy7E
jOiR97gcxW4jiGS2TuMUwACiFQMjudixFeb9cKdJUnZQPkzXngqgwmRnd38Gjp5/
x/XFeKuGQI+gPUtnyVDZM6fqpZwRNehmS5is9noqRM9igGjzraM6sbv5CjXtObSL
ZzXuqq8DmekcsLl9BoOofRJDzEU6CGVZ+BIsVRkQAhSNHYMLGcBWxg==
=mb1Q
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
