Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270766AbTHQT4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270816AbTHQT4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:56:22 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:46870 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270766AbTHQT4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:56:20 -0400
Subject: Re: RAM and DUAL CPU problem
From: Stephen Torri <storri@sbcglobal.net>
To: "G. Ravinder" <Ravinder.Gella@scada.cmcltd.com>
Cc: linux-kernel@vger.kernel.org, ravi@scada.cmcltd.com
In-Reply-To: <Pine.LNX.4.33.0308171532400.31855-100000@scada.cmcltd.com>
References: <Pine.LNX.4.33.0308171532400.31855-100000@scada.cmcltd.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2DJpbpv0IkhN4qYSk+DH"
Message-Id: <1061150184.4716.6.camel@base>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Aug 2003 14:56:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2DJpbpv0IkhN4qYSk+DH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-08-17 at 05:05, G. Ravinder wrote:
> Hi,
>=20
>  I am using "HP Prolient DL 380 Dual processor(2X2.4Ghz) with 6GB RAM wit=
h
> Readhat Linux 7.3 OS. But the problem is that the kernel is detecting onl=
y
> 4GB RAM and single CPU(Not two CPU's).The kernel version is
> 2.4.18-3 on an i686". Can you please suggest how to
> configure dual CPU and 6GB RAM on this server.
>=20
> Regards
> G. Ravinder
> ravi@scada.cmcltd.com
> INDIA.

First off you are best at rebuilding the kernel yourself. The options
you need are:

Processor type and features:

 --> High Memory Support --> 64 GB

 --> Symmetric multi-processing support.

If kernel building seems to be too risky for you then you need to
install:

rpm -ivh kernel-smp-2.4.18-3.i686.rpm=20

This should give you the SMP support but I cannot say whether the entire
memory is going to be recognized. I guess both will but try.

Stephen
--=20
Stephen Torri
GPG Key: http://www.cs.wustl.edu/~storri/storri.asc

--=-2DJpbpv0IkhN4qYSk+DH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/P93omXRzpT81NcgRAp9KAKC8HURfetFy+yfPAnXO76dAZBn4vgCgiD9W
xRiCCLSdT88pcRVIx9Qh3fc=
=u5AB
-----END PGP SIGNATURE-----

--=-2DJpbpv0IkhN4qYSk+DH--

