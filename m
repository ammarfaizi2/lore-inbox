Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUDWOaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUDWOaa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbUDWOaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:30:30 -0400
Received: from mh57.com ([217.160.185.21]:38791 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S264826AbUDWOaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:30:15 -0400
Date: Fri, 23 Apr 2004 16:30:04 +0200
From: Martin Hermanowski <martin@mh57.de>
To: Nigel Cunningham <ncunningham@linuxmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SOFTWARE_SUSPEND as a module
Message-ID: <20040423143004.GC20742@mh57.de>
References: <20040422120417.GA2835@gondor.apana.org.au> <20040423005617.GA414@elf.ucw.cz> <20040423093836.GA10550@gondor.apana.org.au> <opr6wvqddzruvnp2@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <opr6wvqddzruvnp2@laptop-linux.wpcb.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: 0.1 (/)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2004 at 11:28:51PM +1000, Nigel Cunningham wrote:
> Hi.
>=20
> On Fri, 23 Apr 2004 19:38:36 +1000, Herbert Xu =20
> <herbert@gondor.apana.org.au> wrote:
[...]
> >As a side-effect it also allows you to resume from devices that couldn't
> >be done before due to the need for user-space setup.  Examples are LVM
> >and NBD.
>=20
> LVM can be compiled in, can't it? Does it need to do some setup from an =
=20
> initrd?

It needs to be recognised by the lvm userspace utilities before it can
be used.

One other thing this might be very useful for is `swsusp from encrypted
swap'. With dm-crypt, it should be very easy to create a crypto mapping
=66rom initrd from which swsusp can resume. IMHO this is a killer feature
for notebook users (everything encrypted but the boot partition).

LLAP, Martin

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAiShsmGb6Npij0ewRAraEAJ4pGh7GOtdTExcZR2aVjey5PGDrWQCeK8u9
elokXnIlLMsQVKr7z1aqAJw=
=j68S
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
