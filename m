Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbTF2Nzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 09:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbTF2Nzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 09:55:40 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:34799 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265665AbTF2Nzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 09:55:39 -0400
Subject: Re: [RFC][PATCH-2.4] Prevent mounting on ".."
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Willy TARREAU <willy@w.ods.org>
Cc: marcelo@conectiva.com.br, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030629130952.GA246@pcw.home.local>
References: <20030629130952.GA246@pcw.home.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LBzucd6A7O2GI3oQwARf"
Organization: Red Hat, Inc.
Message-Id: <1056895780.1720.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 29 Jun 2003 16:09:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LBzucd6A7O2GI3oQwARf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-06-29 at 15:09, Willy TARREAU wrote:
> Hi Al and Marcelo,
>=20
> while I was trying to get maximum restrictions on a chroot on 2.4.21-pre,
> I found that it's always possible to mount a ramfs or a tmpfs on "..",
> and then upload whatever I wanted in it. It's a shame because I was
> trying to isolate network daemons inside empty, read-only file-systems,
> and I discovered that this effort was worthless. To resume, imagine a
> network daemon which does :

well...
you need to be root to mount. If you're root you can break out of a
chroot anyway....

--=-LBzucd6A7O2GI3oQwARf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+/vMkxULwo51rQBIRAnwrAJ4xSSP17Z4ciDbQaXA5ROUTrk+YUwCfSYPj
jU/1rCdKEj6WKCKlNLVTHBM=
=iAJD
-----END PGP SIGNATURE-----

--=-LBzucd6A7O2GI3oQwARf--
