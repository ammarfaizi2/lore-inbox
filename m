Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTL2Jq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTL2Jq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:46:28 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:63872 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263299AbTL2JqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:46:10 -0500
Subject: Re: 2.4.23 can run with HZ==0!
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031228230522.GA1876@janus>
References: <20031228230522.GA1876@janus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-q8JA57tawI6HtaEbr6jy"
Organization: Red Hat, Inc.
Message-Id: <1072691126.5223.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Dec 2003 10:45:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q8JA57tawI6HtaEbr6jy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-29 at 00:05, Frank van Maarseveen wrote:

> halt, reboot (-f) etc didn't work because they all wanted to sleep. I
> had to power cycle. Now HZ is ok (1000) again.  HZ has been patched but
> that's an unlikely cause

not all motherboards can deal with HZ=3D1000.... seems yours is one of
thise.

>
> (patch attached in case you wonder).
>=20

your patch is *highly* inadequate to get HZ=3D1000 working well in 2.4....
it needs to be about 10x bigger with fixing more userspace api's...



--=-q8JA57tawI6HtaEbr6jy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7/e2xULwo51rQBIRAk9tAKCL6CQzlnQsmGcpqcPVLMqmX8WJOwCfXBw1
XVx/GIRCZfGFnXp2GzD5MhY=
=ddjJ
-----END PGP SIGNATURE-----

--=-q8JA57tawI6HtaEbr6jy--
