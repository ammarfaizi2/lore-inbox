Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264528AbTKNFVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 00:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTKNFVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 00:21:51 -0500
Received: from relay.pair.com ([209.68.1.20]:35592 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S264528AbTKNFVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 00:21:48 -0500
X-pair-Authenticated: 68.42.66.6
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
From: Daniel Gryniewicz <dang@fprintf.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RkWuvu1JK8aWraOfTs3x"
Message-Id: <1068787304.4157.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 14 Nov 2003 00:21:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RkWuvu1JK8aWraOfTs3x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-13 at 22:11, Neil Brown wrote:
> RFCI =3D=3D Request For Clever Ideas.
>=20
> Hi all..
>=20
>  I want be able to partition "md" raid arrays.
>  e.g. I want to be able to use RAID1 to mirror sda and sdb as whole
>  drives, and then partitions that into root, swap, other (or whatever
>  suits the particular situation).

<snip>

Can't LVM do this?  I have a raid array (mirror) that is LVM'd into
multiple partitions.  It currently runs 2.4, but it should work fine
with 2.6, right?  All the rest of my boxes have 2.6 and LVM, but no raid
(no duplicate hard drives).
--=20
Daniel Gryniewicz <dang@fprintf.net>

--=-RkWuvu1JK8aWraOfTs3x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/tGZoomPajV0RnrERAuh7AJ0WQxWWuEO+vqBJ/7viUNzCIZfD0gCeO4EW
FaibFFLk8+xk2dneYnDgjdg=
=Llhx
-----END PGP SIGNATURE-----

--=-RkWuvu1JK8aWraOfTs3x--
