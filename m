Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265702AbTF2PdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 11:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbTF2PdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 11:33:09 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:35311 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265702AbTF2PdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 11:33:03 -0400
Subject: Re: delegating to a cpu
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030629153401.18476.qmail@web20001.mail.yahoo.com>
References: <20030629153401.18476.qmail@web20001.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-b/Gm4+Nt7M+nHwzKHdN/"
Organization: Red Hat, Inc.
Message-Id: <1056901638.1720.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 29 Jun 2003 17:47:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b/Gm4+Nt7M+nHwzKHdN/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-06-29 at 17:34, Raghava Raju wrote:
> Hi,=20
>=20
> Currently interrupt handler in our driver uses
> tasklet to process some of less important info
> to save some interrupt time. But problem is that
> tasklet ends up in the same cpu, and second  cpu=20
> is not taking much of the work.=20
> 1) Is there any mechanism to delegate the less
> important work to other cpu an example would really=20
> help.

you don't give a lot of information about what you are trying to do...
could you post an URL to your driver source, that's the easiest way to
give this information...

--=-b/Gm4+Nt7M+nHwzKHdN/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+/woDxULwo51rQBIRAqZMAJoCIWcjgovr24/aX5AQUyOE8zxlsQCfTtrs
X2m/tOD0pVVVTOtcA54Hevw=
=to7c
-----END PGP SIGNATURE-----

--=-b/Gm4+Nt7M+nHwzKHdN/--
