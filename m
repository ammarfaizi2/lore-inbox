Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265654AbSJXUcl>; Thu, 24 Oct 2002 16:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265653AbSJXUck>; Thu, 24 Oct 2002 16:32:40 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:51512 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S265652AbSJXUcj>;
	Thu, 24 Oct 2002 16:32:39 -0400
Date: Thu, 24 Oct 2002 22:38:47 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] CONFIG_TINY
Message-ID: <20021024223847.C18085@jaquet.dk>
References: <20021023215117.A29134@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021023215117.A29134@jaquet.dk>; from rasmus@jaquet.dk on Wed, Oct 23, 2002 at 09:51:17PM +0200
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2002 at 09:51:17PM +0200, Rasmus Andersen wrote:
> printk: So far I have defined {i,d,n,w}prink corresponding to
> KERN_ {INFO,DEBUG,NOTICE,WARNING} and have converted files to
> use this. Higher levels are left untouched.
>=20
[...]
>=20
>    text    data     bss     dec     hex filename
>  478109   50337  254560  783006   bf29e vmlinux   (woo! :)
>=20
> (Patch at www.jaquet.dk/kernel/config_tiny/2.5.43-printk)

Memo to me: Dont use the kernel compiled to check #define
correctness for enabling printk output to measure the kernel
size when prinkt is disabled. New, better kernel size:

   text    data     bss     dec     hex filename
 475629   50913  252512  779054   be32e vmlinux


Regards,=20
  Rasmus

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9uFpWlZJASZ6eJs4RAi+aAJ0VcnNKP6U1tcxsZ9jEbD8heun8wgCeMuj9
1s5NVFozvidCgpUYen1JCkE=
=V4x5
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
