Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUACVUy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUACVUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:20:53 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:48807 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264265AbUACVTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:19:16 -0500
Subject: Re: does udev really require hotplug?
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Andrea Barisani <lcars@gentoo.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>
In-Reply-To: <20040102101051.GA12073@sole.infis.univ.trieste.it>
References: <20040102101051.GA12073@sole.infis.univ.trieste.it>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gP1uqDMXYUIA89zYdPj2"
Message-Id: <1073164919.6075.41.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 03 Jan 2004 23:21:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gP1uqDMXYUIA89zYdPj2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-02 at 12:10, Andrea Barisani wrote:
> Hi everybody and happy new year!
>=20
> Just one simple question about a very simple matter that right now=20
> I can't figure out: does udev need hotplug package presence?
>=20
> >From your README:
>=20
>   If for some reason you do not install the hotplug scripts, you must tel=
l the
>   kernel to point the hotplug binary at wherever you install udev at.  Th=
is can
>   be done by:
> 	echo "/sbin/udev" > /proc/sys/kernel/hotplug
>=20
>=20
> ...does this work properly?

Yes, you just miss all other events that hotplug usually handles, and
not udev ...

>  It's not clear if some features are lost by not having=20
> hotplug script installed. Also is this policy subject to changes in the n=
ear
> future?
>=20

I do not think so, but Greg will have to comment ...


--=20

Martin Schlemmer




--=-gP1uqDMXYUIA89zYdPj2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/9zJ3qburzKaJYLYRAv2QAKCQkR1B7QEGcp8IknbtHtj77HLegACcCKTW
bUb6wZWMt3PpDsceJWPXnHw=
=5IbB
-----END PGP SIGNATURE-----

--=-gP1uqDMXYUIA89zYdPj2--

