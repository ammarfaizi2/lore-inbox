Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbTJUDhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 23:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbTJUDhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 23:37:43 -0400
Received: from wblv-241-59.telkomadsl.co.za ([165.165.241.59]:7555 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262862AbTJUDhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 23:37:40 -0400
Subject: Re: [ANNOUNCE] udev 003 release
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: clemens@dwf.com, linux-hotplug-devel@lists.sourceforge.net,
       KML <linux-kernel@vger.kernel.org>, reg@orion.dwf.com
In-Reply-To: <20031021024322.GA29643@kroah.com>
References: <20031017055652.GA7712@kroah.com>
	 <200310171757.h9HHvGiY006997@orion.dwf.com>
	 <20031017181923.GA10649@kroah.com> <20031017182754.GA10714@kroah.com>
	 <1066696767.10221.164.camel@nosferatu.lan>
	 <20031021005025.GA28269@kroah.com>
	 <1066698679.10221.178.camel@nosferatu.lan>
	 <20031021024322.GA29643@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-geI0d1qhhxLpZFC3NVzl"
Message-Id: <1066707482.10221.243.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 21 Oct 2003 05:38:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-geI0d1qhhxLpZFC3NVzl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-21 at 04:43, Greg KH wrote:

> > > The naming will be consistant from now on.  Next release will be 004,
> > > followed by 005, and so on.  Remember, version numbers mean nothing :=
)
> > >=20
> >=20
> > Well, if you had an 0.2 already, 003 sorda comes and screw the pooch=20
> > (if trying to work with a package manager - although it seems we are
> > OK with ours seeing 003 as the later) :)
>=20
> Exactly, switching this early is fine by all of the package managers
> I've looked at.  Does this mean you have a udev gentoo package
> somewhere?
>=20

Been in the tree for about a week - removed it though (0.2), so only
have 003 presently.  I also missed the /etc/hotplug.d/default/ symlink,
so initial integration needs tweaking.

So far have not had any complaints, except for minimal support at this
stage, but hey, its still early in the game =3D)

Also, I am using ramfs for now to do the device nodes, and have not
looked at minimal /dev layout, although I guess it is not that minimal,
as even the input drivers lack udev (sysfs) support currently it seems.
Wat was the last eta for initramfs again ?

> > > Of course you need a kernel patch for the sound class that is only
> > > available in my kernel tree right now for sound devices to work with
> > > udev...
> > >=20
> >=20
> > Need help testing ? :) (Yes, I am a lazy bastard, and a patch against
> > test8 would help if you needed the testing)
>=20
> I need to get these class patches out sometime soon, been too busy
> lately...
>=20

NP, thanks anyhow.


Thanks,

--=20

Martin Schlemmer




--=-geI0d1qhhxLpZFC3NVzl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQA/lKoaqburzKaJYLYRAqq/AKCNMASgrEMNu7qyfEvCq6iHGs2cRgCUChIB
gzn3//xuxdYB7dHE4bdw3w==
=VIBU
-----END PGP SIGNATURE-----

--=-geI0d1qhhxLpZFC3NVzl--

