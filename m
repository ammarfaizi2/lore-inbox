Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbUFRUit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUFRUit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUFRUif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:38:35 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:41186 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263750AbUFRUhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:37:12 -0400
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com>
References: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6WaM2kVgmmjwcFp0T44w"
Message-Id: <1087591028.1019.77.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 22:37:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6WaM2kVgmmjwcFp0T44w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-18 at 22:03, Brent Casavant wrote:

Hi Brent

just something that cought my eye.

> +static rwlock_t namecache_lock;

should be

static rwlock_t namecache_lock =3D RW_LOCK_UNLOCKED;

--=20
/Martin

--=-6WaM2kVgmmjwcFp0T44w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA01JzWm2vlfa207ERAhy2AJ9Gq1pU0RVF60HcXrorPUQwXJfbewCeM8zm
lKvUcWUDUmUWhVZm8hz5j1A=
=08Ld
-----END PGP SIGNATURE-----

--=-6WaM2kVgmmjwcFp0T44w--
