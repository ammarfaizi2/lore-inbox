Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSKHSOX>; Fri, 8 Nov 2002 13:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbSKHSOX>; Fri, 8 Nov 2002 13:14:23 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54954 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261339AbSKHSOW>; Fri, 8 Nov 2002 13:14:22 -0500
Subject: Re: 2.5.46-mm1: CONFIG_SHAREPTE do not work with KDE 3
From: Paul Larson <plars@linuxtestproject.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DC9F1C0.70712ED4@digeo.com>
References: <200211070547.00387.Dieter.Nuetzel@hamburg.de> 
	<3DC9F1C0.70712ED4@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-oTwFtoBfHDCFfKYwKB4H"
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Nov 2002 12:18:33 -0600
Message-Id: <1036779514.17557.7.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oTwFtoBfHDCFfKYwKB4H
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-11-06 at 22:53, Andrew Morton wrote:
> Dieter N=FCtzel wrote:
> >=20
> > When I enable shared 3rd-level pagetables between processes KDE 3.0.x a=
nd KDE
> > 3.1 beta2 at least do not work.
> >=20
>=20
> Yup.  That's a bug which happens to everyone in the world
> except Dave :(
I've tried to reproduce this also on a RH 7.3 box.  ksmserver is
running, but strace says it's stuck on a select() call.  There are no
kernel messages, but I got this from startx:

DCOPServer up and running.
Warning: connect() failed: : Connection refused

It looks like maybe this problem shows up in different ways.  Anyone
have ideas about how to debug this?

-Paul Larson

--=-oTwFtoBfHDCFfKYwKB4H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3L//kACgkQbkpggQiFDqdDUgCfeTKb4GnjAESwRti133KFb32D
1hcAn0SCyYQPF9g5Hea1A4wDMesB/6YW
=Yo2V
-----END PGP SIGNATURE-----

--=-oTwFtoBfHDCFfKYwKB4H--

