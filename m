Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263550AbTDGRAg (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbTDGRAg (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:00:36 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:21745 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263550AbTDGRAe (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 13:00:34 -0400
Subject: Re: [PATCH] new syscall: flink
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Clayton Weaver <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030407165009.13596.qmail@email.com>
References: <20030407165009.13596.qmail@email.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+aD/1COj7MpFxMz+sqet"
Organization: 
Message-Id: <1049735496.14054.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 07 Apr 2003 19:11:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+aD/1COj7MpFxMz+sqet
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-04-07 at 18:50, Clayton Weaver wrote:

> The cases with potential security implications are all in the context of =
flink()ing to an open fd for an inode that still corresponds to at least on=
e directory entry.

almost.
there is of course always the case of a setuid app doing a userspace ACL
like thing and only sending fd's to non-privileged apps based on some
security scheme..... flink() would sort of break this thing entirely

--=-+aD/1COj7MpFxMz+sqet
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+kbFIxULwo51rQBIRAmvaAJ0UH7sAWqIkgHR0MvXx9E1Xhf7LRgCfdvKa
xZGPOGma+NAWNwTg6YwAOvk=
=KPSa
-----END PGP SIGNATURE-----

--=-+aD/1COj7MpFxMz+sqet--
