Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSKRPl0>; Mon, 18 Nov 2002 10:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSKRPl0>; Mon, 18 Nov 2002 10:41:26 -0500
Received: from [68.96.149.130] ([68.96.149.130]:26341 "EHLO resonant.org")
	by vger.kernel.org with ESMTP id <S262792AbSKRPlZ>;
	Mon, 18 Nov 2002 10:41:25 -0500
Date: Mon, 18 Nov 2002 09:48:21 -0600
From: Zed Pobre <zed@resonant.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI patches updated (20021111)
Message-ID: <20021118154821.GA9976@resonant.org>
Mail-Followup-To: Zed Pobre <zed@resonant.org>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9@orsmsx119.jf.intel.com> <1037223183.16635.59.camel@dell_ss3.pdx.osdl.net> <20021115150113.GA18126@resonant.org> <1037399340.984.0.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <1037399340.984.0.camel@chevrolet.hybel>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
X-GPG-Fingerprint: FF 75 8D 70 57 8D A4 7D  3A DE 6D 2F 25 C3 E6 E7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2002 at 11:29:00PM +0100, Stian Jordet wrote:
> fre, 2002-11-15 kl. 16:01 skrev Zed Pobre:
> >=20
> >     As a further data point, if ACPI is enabled on my non-SMP test
> > machine, USB stops working.
>
> Very good to hear I'm not the only one with that problem, though, I have
> a smp-machine, but it utterly refuses to work with acpi.

    Interesting.  As I pointed out in my other reply, my problem was
being caused by IO-APIC being enabled, but the thread that lead me to
discovering this implied that it was only buggy for the uniprocessor
case.  This implies that it might also be buggy for SMP.

--=20
Zed Pobre <zed@debian.org> a.k.a. Zed Pobre <zed@resonant.org>
PGP key and fingerprint available on finger; encrypted mail welcomed.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQEVAwUBPdkLxR0207zoJUw5AQHQfQf/anU8+bWSk7nBWA2W9ZO9+/EItbcl1Xbh
vhbR/+zsNnECze48V/2pczA/0/XPfhoy2dXO58VZwKe6CQyDos+7C8+83aot73M5
5foYoB8JtHJSIQiU6QM2tQX8IksXdIXzeqenoni03LVfHYOoZE12bYijuqdLQOxX
uNCVRhzY47Z5UM0JJvVCjqnJU8NZFO5inrr/oAWWLk6w/aE3ZAYln4oYkP+4jOWV
xCB0Cn3PL9jh7yfJhjVWYVfpR4mjh5pGOR9yMz4y5bwV+vTTDjjCmDjLgSs3rlHK
3trM/xmNyKrONy/K4byiskKh9oRay1aM/QHiVFInWxhGMA2kgyXG1A==
=59Mz
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
