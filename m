Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUESUvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUESUvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 16:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUESUvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 16:51:13 -0400
Received: from facmail.gettysburg.edu ([138.234.4.150]:29343 "EHLO
	facmail.cc.gettysburg.edu") by vger.kernel.org with ESMTP
	id S264569AbUESUvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 16:51:10 -0400
Date: Wed, 19 May 2004 15:19:00 -0400
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: JustinPryzby@andromeda, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5, 2.6.6-rc2 sluggish interrupts
Message-ID: <20040519191900.GA1052@andromeda>
References: <E1BJOXM-0007zu-6H@andromeda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <E1BJOXM-0007zu-6H@andromeda>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The problem persists with 2.6.6 final, but get this: I was recompiling
with preempt disabled (which didn't do anything to solve the problem),
but during the compile, there were very few music skips / mouse skips.
Not sure what that could mean though..
Justin

On Fri, Apr 30, 2004 at 03:18:04AM +0000, Peter Chubb wrote:
> >>>>> 'Justin' =3D=3D Justin Pryzby <justinpryzby@users.sourceforge.net> =
writes:
>=20
> Justin> --Q68bSM7Ycu6FN28Q Content-Type: text/plain; charset=3Dus-ascii
> Justin> Content-Disposition: inline Content-Transfer-Encoding:
> Justin> quoted-printable
>=20
> Justin> It feels to me like it always happens when the disk is
> Justin> accessed (possibly just because I can _hear_ that), and it
> Justin> seems like it happens when the disk hasn't been used in a
> Justin> while.
>=20
> Try
>    1. booting with elevator=3Ddeadline
>    2. hdparm -u /dev/hda

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAq7Mjh7yD3l4ITTYRAvfCAKCbP/nNiMzF9AzQ3oXC8kyplu9NmACeK9Kp
ILGBSSquZro486ogeRfZjxk=
=Y5ue
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
