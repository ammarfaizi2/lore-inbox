Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265813AbUFJKEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265813AbUFJKEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 06:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265991AbUFJKEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 06:04:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265813AbUFJKEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 06:04:31 -0400
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, George Anzinger <george@mvista.com>
In-Reply-To: <40C7BE29.9010600@am.sony.com>
References: <40C7BE29.9010600@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WJGHoXXKiQXCivYfEvFL"
Organization: Red Hat UK
Message-Id: <1086861862.2733.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 10 Jun 2004 12:04:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WJGHoXXKiQXCivYfEvFL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-06-10 at 03:49, Geoff Levand wrote:
> Available at=20
> http://tree.celinuxforum.org/pubwiki/moin.cgi/CELinux_5fPatchArchive
>=20
> For those interested, the set of three patches provide POSIX high-res=20
> timer support for linux-2.6.6.  The core and i386 patches are updates of=20
> George Anzinger's hrtimers-2.6.5-1.0.patch available on SourceForge=20
> <http://sourceforge.net/projects/high-res-timers/>.  The ppc32 port is=20
> not available on SourceForge yet.

My first impression is that it has WAAAAAAAAAAAY too many ifdefs. I
would strongly suggest to not make this a config option and just
mandatory, it's a core feature that has no point in being optional. If
you accept that, the code also becomes a *LOT* cleaner.


--=-WJGHoXXKiQXCivYfEvFL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAyDImxULwo51rQBIRAlo9AJ49BFmX3jNCFbZfycjZriU8B/jPhgCbB7+e
8VDTZ8Q7S7GYslHRRNzWu1c=
=8pkf
-----END PGP SIGNATURE-----

--=-WJGHoXXKiQXCivYfEvFL--

