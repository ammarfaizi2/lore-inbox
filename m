Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423290AbWKHUda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423290AbWKHUda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423329AbWKHUda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:33:30 -0500
Received: from master.altlinux.org ([62.118.250.235]:9222 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1423290AbWKHUd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:33:29 -0500
Date: Wed, 8 Nov 2006 23:33:19 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, akpm@osdl.org,
       Wilco Beekhuizen <wilcobeekhuizen@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
Message-ID: <20061108203319.GA7485@procyon.home>
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com> <1162817254.5460.4.camel@localhost.localdomain> <1162847625.10086.36.camel@localhost.localdomain> <20061108202218.8f542fbf.vsu@altlinux.ru> <1163009130.23956.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <1163009130.23956.57.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2006 at 06:05:30PM +0000, Alan Cox wrote:
> > > +struct pci_device_id *pci_find_present(const struct pci_device_id *i=
ds)
> >=20
> > New API without proper refcounting?  Ewww.
>=20
> pci_device_id objects are not refcounted and don't vanish underneath us.
> Devices may but we aren't dealing in devices. The function operates
> under the list lock internally so should be safe.

Oops, sorry, did not read the patch carefully enough...  Please ignore
this comment.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUj8PW82GfkQfsqIRAm08AJ0TYAZjI6RWV3BxxOTisw63nEr+SQCfU9he
ph0zfpLBN215cjrWnyJH/Uw=
=cYA2
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
