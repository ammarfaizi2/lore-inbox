Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTJUBLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 21:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTJUBLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 21:11:00 -0400
Received: from wblv-241-59.telkomadsl.co.za ([165.165.241.59]:59010 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262598AbTJUBK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 21:10:57 -0400
Subject: Re: [ANNOUNCE] udev 003 release
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: clemens@dwf.com, linux-hotplug-devel@lists.sourceforge.net,
       KML <linux-kernel@vger.kernel.org>, reg@orion.dwf.com
In-Reply-To: <20031021005025.GA28269@kroah.com>
References: <20031017055652.GA7712@kroah.com>
	 <200310171757.h9HHvGiY006997@orion.dwf.com>
	 <20031017181923.GA10649@kroah.com> <20031017182754.GA10714@kroah.com>
	 <1066696767.10221.164.camel@nosferatu.lan>
	 <20031021005025.GA28269@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XyRisxYwWMVVKQvdgPe5"
Message-Id: <1066698679.10221.178.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 21 Oct 2003 03:11:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XyRisxYwWMVVKQvdgPe5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-21 at 02:50, Greg KH wrote:

> > Three questions if you do not mind:
> >=20
> > 1)  Is it possible to maintain naming of tarball/version ?  Meaning,
> >     say we forget about the 003 version, could the next be 0.4, or even
> >     0.3.1 or whatever ?  Just changing makes trying to keep packages
> >     sane a hassle.  Thanks :)
>=20
> The naming will be consistant from now on.  Next release will be 004,
> followed by 005, and so on.  Remember, version numbers mean nothing :)
>=20

Well, if you had an 0.2 already, 003 sorda comes and screw the pooch=20
(if trying to work with a package manager - although it seems we are
OK with ours seeing 003 as the later) :)

> >     If not, any idea if/when udev will start following official
> >     libsysfs?  Yes, not a biggie, but it would be nice to have
> >     sysfsutils its own package :)
>=20
> I just got a patch today from Dan that merged the latest version of
> libsysfs into udev.  It's in the udev bk tree already.  libsysfs will
> always be a copy in the udev tree, as udev links statically, and it
> keeps the build process and debug process much easier.
>=20
> sysfsutils can still be its own package, other programs are starting to
> use libsysfs already.
>=20

Ok, ill have a look at the bk tree at som stage, thanks.

> > 3)  Any plans to have namedev support wildcarts ?  Like:
> >=20
> >   dsp*:root:audio:0660
> >   audio*:root:audio:0660
> >   midi*:root:audio:0660
> >   mixer*:root:audio:0660
>=20
> Yes, I would love to support that.  Care to send a patch?  :)
>=20

:P  I wont promise, as my schedule is a bit tight, but I'll send
along if I get to cook something up.

> Of course you need a kernel patch for the sound class that is only
> available in my kernel tree right now for sound devices to work with
> udev...
>=20

Need help testing ? :) (Yes, I am a lazy bastard, and a patch against
test8 would help if you needed the testing)


Thanks,

--=20

Martin Schlemmer
Gentoo Linux Developer, Desktop/System Team Developer
Cape Town, South Africa



--=-XyRisxYwWMVVKQvdgPe5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/lIe3qburzKaJYLYRArJvAKCBDdtgZAH/C3SxO5f85lYqMZ/oMwCgm5P7
31BGsgMvUSp5hG53/KVhUpY=
=NIAm
-----END PGP SIGNATURE-----

--=-XyRisxYwWMVVKQvdgPe5--

