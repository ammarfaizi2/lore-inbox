Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263076AbTCSORR>; Wed, 19 Mar 2003 09:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263077AbTCSORR>; Wed, 19 Mar 2003 09:17:17 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:29936 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S263076AbTCSORQ>; Wed, 19 Mar 2003 09:17:16 -0500
Subject: Re: Kernels 2.2 and 2.4 exploit (ALL VERSION WHAT I HAVE TESTED
	UNTILL NOW!)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
Cc: Andrus <andrus@members.ee>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303191012320.3319-100000@alumno.inacap.cl>
References: <Pine.LNX.4.44.0303191012320.3319-100000@alumno.inacap.cl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8mS1+lWh0RFL0X/f5oFI"
Organization: Red Hat, Inc.
Message-Id: <1048084079.1493.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 Mar 2003 15:28:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8mS1+lWh0RFL0X/f5oFI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-03-19 at 15:13, Robinson Maureira Castillo wrote:
> On Wed, 19 Mar 2003, Andrus wrote:
> > You can download working exploit on
> > http://www.members.ee/ptrace-exploit.c
> >=20
> > Its hell long exploit as I know, and still not patched!
> >=20
>=20
> I have it, it's no longer on that URL, but I test it against the last=20
> errata kernel from RedHat and it's not vulnerable.
>=20
> [rmaureira@linux rmaureira]$ ./ptrace-xploit=20
> [-] Unable to attach: Operation not permitted
> Killed

there is some misunderstanding about at least one of the exploits out
there; one of them will, when successful, make itself setuid-root....

result:

admin tries exploit, succeeds
admin updates kernel to fixed one
admin tries exploit, gets root again due to setuid-root and thinks the
kernel is not fixed
admin yells at $vendor for providing a broken fix



--=-8mS1+lWh0RFL0X/f5oFI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+eH5vxULwo51rQBIRAoqeAJ49zPFlyBsif4hnUTfzuNzqUOKnGwCfU1Bd
YW6h32LzCisnEGEmc7dTpdg=
=lP3u
-----END PGP SIGNATURE-----

--=-8mS1+lWh0RFL0X/f5oFI--
