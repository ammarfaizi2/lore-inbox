Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266192AbUBKW0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266217AbUBKW0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:26:40 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:9618 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266192AbUBKW0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:26:38 -0500
Subject: Re: [ANNOUNCE] udev 016 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040211221324.GC14231@kroah.com>
References: <20040203201359.GB19476@kroah.com>
	 <1075844602.7473.75.camel@nosferatu.lan> <20040211221324.GC14231@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dIFH+F22/vkwpb/jt+Op"
Message-Id: <1076538429.22542.12.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 00:27:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dIFH+F22/vkwpb/jt+Op
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-02-12 at 00:13, Greg KH wrote:
> On Tue, Feb 03, 2004 at 11:43:22PM +0200, Martin Schlemmer wrote:
> > On Tue, 2004-02-03 at 22:13, Greg KH wrote:
> >=20
> > Once again, patch to make logging a config option.
> >=20
> > Reason for this (since you asked for it =3D):
> > - In our setup it is easy (although still annoying) .. just
> > edit the ebuild, add logging support (or remove it) and rebuild.
> > For say a binary distro, having the logging is useful for debugging
> > some times, but its more a once of, or rare thing, as you do not
> > add or change config files every day.  Sure, we can have logging
> > by default, but many do not want ~300 lines of extra debugging in
> > their logs is not pleasant, and they will complain.  Rebuilding
> > the package for that binary package (given the users it is targeted
> > to) is usually not within most users grasp.
>=20
> Ok, I applied this patch.
>=20
> And then I went back and fixed it so it actually would work :(
>=20
> Here's the changes I had to make to get everything to build properly,
> and to let us have a boolean type for the config files.
>=20

Interest sake ... when did it actually fail?  (When linking with
klibc maybe?  Been using here without problems).


Thanks,

--=20
Martin Schlemmer

--=-dIFH+F22/vkwpb/jt+Op
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAKqw9qburzKaJYLYRAu2MAJ94p6sM7D7m202y8GBYxXiY4xlJRACfSmw6
M/V4ZhNKO9urm3+F1WC3oLE=
=xiCm
-----END PGP SIGNATURE-----

--=-dIFH+F22/vkwpb/jt+Op--

