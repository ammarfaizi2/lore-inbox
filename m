Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbVBCPVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbVBCPVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVBCPTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:19:53 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:48133 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S263098AbVBCPRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:17:18 -0500
Subject: Re: dm-crypt crypt_status reports key?
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Christopher Warner <chris@servertogo.com>
Cc: Matt Mackall <mpm@selenic.com>, Christophe Saout <christophe@saout.de>,
       christopher@kernelcode.com, linux-kernel <linux-kernel@vger.kernel.org>,
       dm-crypt@saout.de, Alasdair G Kergon <agk@redhat.com>
In-Reply-To: <1107425749.9294.56.camel@linux-cw>
References: <20050202211916.GJ2493@waste.org>
	 <1107394381.10497.16.camel@server.cs.pocnet.net>
	 <20050203015236.GO2493@waste.org>
	 <1107398069.11826.16.camel@server.cs.pocnet.net>
	 <20050203040542.GQ2493@waste.org>  <1107440300.15236.58.camel@ghanima>
	 <1107425749.9294.56.camel@linux-cw>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-47064DXugM5iVy3HeBW0"
Date: Thu, 03 Feb 2005 16:17:16 +0100
Message-Id: <1107443836.15236.65.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-47064DXugM5iVy3HeBW0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-02-03 at 05:15 -0500, Christopher Warner wrote:
> On Thu, 2005-02-03 at 15:18 +0100, Fruhwirth Clemens wrote:
> >=20
> > Keys are handed to dm-crypt regularly the first time. But when dm-crypt
> > hands keys back to user space, it uses some sort of blinding to make th=
e
> > keys meaningless for user space.=20

> I've been following this thread and i'm clearly at a loss as to how any
> of this will prevent someone from writing a util to get the key?

This is not about trying to hide something which cannot be hidden.

See http://lkml.org/lkml/2005/2/2/256 . It's about a design that can
cope with unintentional program/user errors. Think of it as a trigger
safety.=20

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-47064DXugM5iVy3HeBW0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAkB8W7sr9DEJLk4RAjV7AJ0YTqJ1AuF2E4a7XriWXPUVlSIWgQCfQ+7G
aAyLZ6P1SnlOdgYykpuZ9c8=
=FHaz
-----END PGP SIGNATURE-----

--=-47064DXugM5iVy3HeBW0--
