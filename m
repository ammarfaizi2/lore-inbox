Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUAaS1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 13:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbUAaS1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 13:27:05 -0500
Received: from wblv-36-186.telkomadsl.co.za ([165.165.36.186]:29572 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264941AbUAaS1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 13:27:01 -0500
Subject: Re: [ANNOUNCE] udev 015 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040131181559.GA22442@vrfy.org>
References: <20040126215036.GA6906@kroah.com>
	 <1075395125.7680.21.camel@nosferatu.lan> <20040129215529.GB9610@kroah.com>
	 <20040131031718.GA21129@vrfy.org> <1075571697.7232.11.camel@nosferatu.lan>
	 <20040131181559.GA22442@vrfy.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wV3O/EuhZtRHEZXxgkzu"
Message-Id: <1075573621.7232.14.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 31 Jan 2004 20:27:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wV3O/EuhZtRHEZXxgkzu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-31 at 20:15, Kay Sievers wrote:

> > get time to test your latest patch - anything specific you need testing
> > of ?
>=20
> Nothing specific, I just need to know if it's working on other setups too=
 :)
>=20
> Just compile it with DEBUG=3Dtrue and let the '/etc/hotplug.d/default/ude=
v.hotplug'
> symlink point to udevsend instead of udev. udevd will be automatically st=
arted.
> On reboot the first sequence I get in the syslog is 138 and udevd is pid =
[51].
>=20
> Don't mount /udev as tmpfs. udevd places its socket and lock file in ther=
e,
> long before you mount it over. I just recognized it cause I had two
> udevd running. /var/lock doesn't work cause it's also cleaned up after we
> are running.
>=20

Our setup runs udev for creating /dev _very_ early, so I do not think
this will be a problem - will let you know.

> You may watch the syslog while connecting/disconnecting devices, to see i=
f
> the events are applied in the right order.
>=20
> thanks,
> Kay
--=20
Martin Schlemmer

--=-wV3O/EuhZtRHEZXxgkzu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAG/N1qburzKaJYLYRAo31AJ4nn5YaX16aZeFGVFlcc+VlIoYFagCgndeh
9BYzXQgxmozo7+q01Wolwz8=
=rZFm
-----END PGP SIGNATURE-----

--=-wV3O/EuhZtRHEZXxgkzu--

