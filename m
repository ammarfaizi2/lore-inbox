Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271949AbTGRVIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271873AbTGRVHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:07:17 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:45554 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S271951AbTGRVGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:06:40 -0400
Subject: Re: Linux 2.6.0-test1 Ext3 Ooops. Reboot needed.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: Ricardo Galli <gallir@uib.es>, linux-kernel@vger.kernel.org
In-Reply-To: <20030718140019.4f6667bd.akpm@osdl.org>
References: <200307181228.40142.gallir@uib.es>
	 <20030718140019.4f6667bd.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4JsKzipLD8HMEeuJ4zQa"
Organization: Red Hat, Inc.
Message-Id: <1058563289.5948.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 18 Jul 2003 23:21:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4JsKzipLD8HMEeuJ4zQa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-07-18 at 23:00, Andrew Morton wrote:
> Ricardo Galli <gallir@uib.es> wrote:
> >
> >  Unable to handle kernel paging request at virtual address e9000018
> > EIP is at find_inode_fast+0x20/0x70
> > Call Trace:
> >  [<c0168e42>] iget_locked+0x52/0xc0
> >  [<c018a54b>] ext3_lookup+0x6b/0xd0
> >  [<c015cd92>] real_lookup+0xd2/0x100
>=20
> What is "famd"?  File access monitor daemon? =20
it's probably the SGI thing that dnotify()s directories for one of the
GUI filemanagers out there...=20

--=-4JsKzipLD8HMEeuJ4zQa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/GGTZxULwo51rQBIRAtt3AJwKb01Fkmu1m0Oh03/cf26Vva4nFwCeOqRB
oYVptsevqEl/woN+BSie/10=
=w7e0
-----END PGP SIGNATURE-----

--=-4JsKzipLD8HMEeuJ4zQa--
