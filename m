Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWBITcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWBITcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWBITcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:32:15 -0500
Received: from mout1.freenet.de ([194.97.50.132]:16360 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1750731AbWBITcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:32:14 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: omkar lagu <omkarlagu@yahoo.com>
Subject: Re: Fwd: How to call a function in a module from the kernel code !!! (Linux kernel)
Date: Thu, 9 Feb 2006 20:32:11 +0100
User-Agent: KMail/1.8.3
References: <20060209192510.32377.qmail@web50307.mail.yahoo.com>
In-Reply-To: <20060209192510.32377.qmail@web50307.mail.yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1770331.H220ak0R8s";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602092032.12091.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1770331.H220ak0R8s
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 09 February 2006 20:25, you wrote:
>=20
>  hello sir,
> =20
>  PROBLEM::How to call a function in a module from the
>  kernel code ??
> =20
>  what we did ? ::=20
>  we wanted to call a function in our module ll from
>  shm.c file (which is in the kernel)
> =20
>  so we declared function pointer in shm.c
>  :: unsigned long long (*ptr1)(int)
> =20
>  we declared it as extern in shm.h
>  :: extern unsigned long long (*ptr1)(int)
> =20
>  then we declared also in our module  (ll)
>  :: extern unsigned long long (*ptr1)(int)
> =20
>  we initialized it to ptr1 =3D commun; in init module
>  of ll.c
>  where commun is we wanted to call from the kernel
>   =20
>  but it gave an error as undefined refernce to ptr1
>  when we inserted our module..
> =20
>  can you help on this thing or can you give us a
>  example=20
>  regarding how it is done ??

EXPORT_SYMBOL(ptr1);

=2D-=20
Greetings Michael.

--nextPart1770331.H220ak0R8s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD65i8lb09HEdWDKgRAkWVAJ4xIPrN9jXeEhFlAc+jmLKNpwjGxQCgisoK
jOpqiMJNRku7cRftyUEPFqw=
=N9Lc
-----END PGP SIGNATURE-----

--nextPart1770331.H220ak0R8s--
