Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVBVTQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVBVTQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVBVTQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:16:35 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:36619 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261317AbVBVTQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:16:27 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, michal@logix.cz, adam@yggdrasil.com
In-Reply-To: <20050214101615.6882c6ba.akpm@osdl.org>
References: <Xine.LNX.4.44.0502101247390.9159-100000@thoron.boston.redhat.com>
	 <1108387234.8086.37.camel@ghanima>
	 <20050214075655.6dec60cb.davem@davemloft.net>
	 <1108400799.23133.34.camel@ghanima>
	 <20050214090726.2d099d96.davem@davemloft.net>
	 <1108402135.23133.48.camel@ghanima> <20050214101615.6882c6ba.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1jWwCYcfVWkjEHx1otG1"
Date: Tue, 22 Feb 2005 20:16:24 +0100
Message-Id: <1109099784.13145.24.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1jWwCYcfVWkjEHx1otG1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-02-14 at 10:16 -0800, Andrew Morton wrote:
> Fruhwirth Clemens <clemens@endorphin.org> wrote:
> >
> > First, one has to make kmap fallible.
>=20
> I think it would be relatively simple and sane to modify the existing
> kmap() implementations to add a new try_kmap() which is atomic and return=
s
> failure if it would have needed to sleep.

Is anyone going to implement that? I would be willing to rework my
scatterwalk code one more time, but I'm not going to touch the kernel
vm.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-1jWwCYcfVWkjEHx1otG1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCG4UIbjN8iSMYtrsRAomOAJ9jpnU0F8C4P927EjofS9q6vP5aqACaAlnd
VLVZt7Q5azq1ZMFm46H4Ju8=
=o7BW
-----END PGP SIGNATURE-----

--=-1jWwCYcfVWkjEHx1otG1--
