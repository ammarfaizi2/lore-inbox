Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbTJUUU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTJUUU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:20:59 -0400
Received: from wblv-241-59.telkomadsl.co.za ([165.165.241.59]:22656 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263314AbTJUUUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:20:54 -0400
Subject: Re: [ANNOUNCE] udev 003 release
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: clemens@dwf.com, linux-hotplug-devel@lists.sourceforge.net,
       KML <linux-kernel@vger.kernel.org>, reg@orion.dwf.com
In-Reply-To: <20031021174426.GA1497@kroah.com>
References: <20031017055652.GA7712@kroah.com>
	 <200310171757.h9HHvGiY006997@orion.dwf.com>
	 <20031017181923.GA10649@kroah.com> <20031017182754.GA10714@kroah.com>
	 <1066696767.10221.164.camel@nosferatu.lan>
	 <20031021005025.GA28269@kroah.com>
	 <1066698679.10221.178.camel@nosferatu.lan>
	 <20031021024322.GA29643@kroah.com>
	 <1066707482.10221.243.camel@nosferatu.lan>
	 <20031021174426.GA1497@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6iDn4KJIlLH48DuphRO3"
Message-Id: <1066767647.11872.152.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 21 Oct 2003 22:20:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6iDn4KJIlLH48DuphRO3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-21 at 19:44, Greg KH wrote:
> On Tue, Oct 21, 2003 at 05:38:02AM +0200, Martin Schlemmer wrote:
> >=20
> > Been in the tree for about a week - removed it though (0.2), so only
> > have 003 presently.  I also missed the /etc/hotplug.d/default/ symlink,
> > so initial integration needs tweaking.
>=20
> Do you also have the latest hotplug scripts in gentoo?
>=20

Yep.

No, I installed the binary by hand for some reason at the time,
so missed the creation in the makefile (my screwup =3D).

> > So far have not had any complaints, except for minimal support at this
> > stage, but hey, its still early in the game =3D)
>=20
> Nice.  Be sure to let me know if you do hear any.
>=20
> Remember, gentoo needs to wean itself off of devfs for 2.6...
>=20

Busy =3D)

> > Also, I am using ramfs for now to do the device nodes, and have not
> > looked at minimal /dev layout, although I guess it is not that minimal,
> > as even the input drivers lack udev (sysfs) support currently it seems.
> > Wat was the last eta for initramfs again ?
>=20
> initramfs is in the kernel, you use it to boot already :)
>=20

OK ... I do though remember you saying it should be possible to have
initramfs get the initial /dev going ... any docs on that ?


--=20

Martin Schlemmer




--=-6iDn4KJIlLH48DuphRO3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQA/lZUfqburzKaJYLYRAv7SAJ9TamL2nAas6UGi105yCTZ0LXlQDwCXcknY
SCFxUo55rAZFmfxPheWYAA==
=6905
-----END PGP SIGNATURE-----

--=-6iDn4KJIlLH48DuphRO3--

