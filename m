Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266307AbSKOOyT>; Fri, 15 Nov 2002 09:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbSKOOyT>; Fri, 15 Nov 2002 09:54:19 -0500
Received: from [68.96.149.130] ([68.96.149.130]:19667 "EHLO resonant.org")
	by vger.kernel.org with ESMTP id <S266307AbSKOOyS>;
	Fri, 15 Nov 2002 09:54:18 -0500
Date: Fri, 15 Nov 2002 09:01:13 -0600
From: Zed Pobre <zed@resonant.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI patches updated (20021111)
Message-ID: <20021115150113.GA18126@resonant.org>
Mail-Followup-To: Zed Pobre <zed@resonant.org>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9@orsmsx119.jf.intel.com> <1037223183.16635.59.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <1037223183.16635.59.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
X-GPG-Fingerprint: FF 75 8D 70 57 8D A4 7D  3A DE 6D 2F 25 C3 E6 E7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2002 at 01:33:03PM -0800, Stephen Hemminger wrote:
> Will this fix problems with IRQ routing.
> On our SMP test machines, ACPI has to be disabled otherwise the SCSI
> disk controllers don't work.

    As a further data point, if ACPI is enabled on my non-SMP test
machine, USB stops working.


> This is a major pain, and ACPI should be default off until it gets
> fixed.

    Well, this kind of goes both ways, unfortunately.  If ACPI is
disabled on that same test machine, the network stops working,
complaining about possible IRQ conflicts (I sent mail earlier about
this but got not response).

--=20
Zed Pobre <zed@debian.org> a.k.a. Zed Pobre <zed@resonant.org>
PGP key and fingerprint available on finger; encrypted mail welcomed.

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQEVAwUBPdUMOR0207zoJUw5AQFl9AgArgNxzJArUPpftCFnMpN8w+4QVFXfH9CV
T9pSeNVJZ1ZVl24Dz+Zn8EKRW1SRgKIGqrQ9YzO/z/qKzTNP40JS5yisZfb0T7ug
7Gxrz0hJzUcm3De1+vrWM536WAPl5Iz6KVrU6dnOuWLAqa5XC89cCIFsCdPMeRfL
1bujwJVyqWJ3RZQ+gEt8UNoRfF25m7sYUItb84FiBcLaDRRJs/sOBgGQKxmIKD+8
wGz1ymXErQ9Dk+5pcvmZ4BkvTRT7vq7JpSaLXvn5x8ByL0jAAihZkYay6NoRIKzA
VDi+MbXOF7KuVzLVOVPdt4GqSLupf/QNbPoE7klQFm9iUDGXyb4t6w==
=4k3B
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
