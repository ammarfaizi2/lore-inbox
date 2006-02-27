Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWB0Anh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWB0Anh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 19:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWB0Anh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 19:43:37 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:56988 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751464AbWB0Ang (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 19:43:36 -0500
Subject: Re: [PATCH] Revert sky2 to 0.13a
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Arjan van de Ven <arjan@infradead.org>, woho@woho.de,
       Stephen Hemminger <shemminger@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44022DEC.1070601@gmx.net>
References: <4400FC28.1060705@gmx.net>
	 <20060225180353.5908c955@localhost.localdomain>
	 <200602260957.04305.woho@woho.de>  <1140966011.22812.2.camel@localhost>
	 <1140968831.2934.32.camel@laptopd505.fenrus.org>
	 <1140970427.23375.11.camel@localhost>  <44022DEC.1070601@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7Or1xrPHtpmDwZY2aHFu"
Date: Mon, 27 Feb 2006 01:43:48 +0100
Message-Id: <1141001028.23375.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7Or1xrPHtpmDwZY2aHFu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-26 at 23:38 +0100, Carl-Daniel Hailfinger wrote:
> Ian Kumlien schrieb:
> > I also saw some oddities... portage stopped working, i dunno if this ca=
n
> > be MSI related or so, else something is trashing memory in a very
> > special way =3DP
>=20
> Yes, 0.15 causes memory corruption even if MSI is disabled.

So if i run with iommu=3Dforced or what the hell the option is called i
should be able to catch these trashings?

I also found it odd that it was only python that suffered... Starting
large and long running C apps worked just fine.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-7Or1xrPHtpmDwZY2aHFu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1-ecc0.1.6 (GNU/Linux)

iD8DBQBEAktE7F3Euyc51N8RAvebAJ9zXjQNhcWjWiYXZye9PcD5U0bWbgCfTBfJ
fYPcXjnh2P1HVd5YqXgrb2M=
=7Nws
-----END PGP SIGNATURE-----

--=-7Or1xrPHtpmDwZY2aHFu--

