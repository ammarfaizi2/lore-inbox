Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVBNRGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVBNRGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 12:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVBNRGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 12:06:45 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:16901 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261487AbVBNRGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 12:06:43 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, michal@logix.cz, adam@yggdrasil.com
In-Reply-To: <20050214075655.6dec60cb.davem@davemloft.net>
References: <Xine.LNX.4.44.0502101247390.9159-100000@thoron.boston.redhat.com>
	 <1108387234.8086.37.camel@ghanima>
	 <20050214075655.6dec60cb.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2l+PliWPXzRg8o2eRp+R"
Date: Mon, 14 Feb 2005 18:06:39 +0100
Message-Id: <1108400799.23133.34.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2l+PliWPXzRg8o2eRp+R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-02-14 at 07:56 -0800, David S. Miller wrote:
> On Mon, 14 Feb 2005 14:20:34 +0100
> Fruhwirth Clemens <clemens@endorphin.org> wrote:
>=20
> > Conclusion: The idea of high-mem and low-mem seperation is fundamentall=
y
> > broken. The limitation of page table entries to a fixed set is causing
> > more complications than it solves. Laziness to do things right at memor=
y
> > management shifts the burden to the users of the interface.=20
>=20
> Doing it "at memory management" is what many other OS's do and
> is incredibly costly especially on SMP systems.  Please ponder
> those issues for some time before you blast Linux's MM design
> decisions.  They were not made in a vacuum.

There is nothing wrong with having special methods, that lack generality
but are superior in performance. There is something wrong, when there
are no other. And there are no other for holding three kmappings or more
concurrently.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-2l+PliWPXzRg8o2eRp+R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCENqfbjN8iSMYtrsRAihmAJwJOg8jVqozFEnErWkXd2bcOksoHQCeMa2t
fEvVubfuMey7+ij+CywzzAI=
=DTJV
-----END PGP SIGNATURE-----

--=-2l+PliWPXzRg8o2eRp+R--
