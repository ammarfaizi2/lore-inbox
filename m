Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUBBTPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbUBBTPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:15:31 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:11911 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265810AbUBBTPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:15:25 -0500
Subject: Re: module-init-tools/udev and module auto-loading
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20040202181229.GB28007@mail.shareable.org>
References: <1075674718.27454.17.camel@nosferatu.lan>
	 <20040202052100.GA21753@kroah.com>
	 <20040202181229.GB28007@mail.shareable.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9np3WROI0Ce6MbiDSo1t"
Message-Id: <1075749297.6931.25.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 21:14:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9np3WROI0Ce6MbiDSo1t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-02-02 at 20:12, Jamie Lokier wrote:
> Greg KH wrote:
> > Rusty had it correct in that you need to try to load for the type of
> > module:
> > 	alias eth1 tulip
> > 	alias usb-controller usb-ohci
> > and so on.  That's the much better way.
>=20
> Shouldn't these things be autodetected?
>=20

My general experience is that it does work fine in most cases, except
maybe sound and net which you need your aliases.


--=20
Martin Schlemmer

--=-9np3WROI0Ce6MbiDSo1t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAHqGxqburzKaJYLYRAtRRAJ9/A81cHRYNs9yxgUP+S4+5CNie4QCeM6f2
uXZBxK8IIqcCsT+q2kGjYvs=
=QiW/
-----END PGP SIGNATURE-----

--=-9np3WROI0Ce6MbiDSo1t--

