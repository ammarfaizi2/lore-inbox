Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUAaSrR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 13:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUAaSrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 13:47:17 -0500
Received: from wblv-36-186.telkomadsl.co.za ([165.165.36.186]:32644 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265071AbUAaSrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 13:47:14 -0500
Subject: Re: [ANNOUNCE] udev 015 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040131183956.GA22534@vrfy.org>
References: <20040126215036.GA6906@kroah.com>
	 <1075395125.7680.21.camel@nosferatu.lan> <20040129215529.GB9610@kroah.com>
	 <20040131031718.GA21129@vrfy.org> <1075571697.7232.11.camel@nosferatu.lan>
	 <20040131181559.GA22442@vrfy.org> <1075573621.7232.14.camel@nosferatu.lan>
	 <20040131183956.GA22534@vrfy.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Uk3acwMNjSiBW7v0F1Ib"
Message-Id: <1075574823.7232.16.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 31 Jan 2004 20:47:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Uk3acwMNjSiBW7v0F1Ib
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-31 at 20:39, Kay Sievers wrote:
> On Sat, Jan 31, 2004 at 08:27:01PM +0200, Martin Schlemmer wrote:
> > On Sat, 2004-01-31 at 20:15, Kay Sievers wrote:
> >=20
> > > > get time to test your latest patch - anything specific you need tes=
ting
> > > > of ?
> > >=20
> > > Nothing specific, I just need to know if it's working on other setups=
 too :)
> > >=20
> > > Just compile it with DEBUG=3Dtrue and let the '/etc/hotplug.d/default=
/udev.hotplug'
> > > symlink point to udevsend instead of udev. udevd will be automaticall=
y started.
> > > On reboot the first sequence I get in the syslog is 138 and udevd is =
pid [51].
> > >=20
> > > Don't mount /udev as tmpfs. udevd places its socket and lock file in =
there,
> > > long before you mount it over. I just recognized it cause I had two
> > > udevd running. /var/lock doesn't work cause it's also cleaned up afte=
r we
> > > are running.
> > >=20
> >=20
> > Our setup runs udev for creating /dev _very_ early, so I do not think
> > this will be a problem - will let you know.
>=20
> What means very early?
> I would expect hotplug events before your setup runs.
>=20

True, but then / is ro anyhow.  Its before / gets mounted rw, so I would
say its early.


--=20
Martin Schlemmer

--=-Uk3acwMNjSiBW7v0F1Ib
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAG/gnqburzKaJYLYRAozVAJkB27kMZeyal5aepifXdsHP5w/72wCcCJzA
sU24f2T/T2Rr0Dhj8OWArWk=
=usJ6
-----END PGP SIGNATURE-----

--=-Uk3acwMNjSiBW7v0F1Ib--

