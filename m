Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbTLZUPx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 15:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTLZUPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 15:15:53 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:34947 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265236AbTLZUPu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 15:15:50 -0500
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Jellinghaus <aj@dungeon.inka.de>
In-Reply-To: <20031226165456.GA26466@irc.pl>
References: <20031223002126.GA4805@kroah.com>
	 <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
	 <20031223131523.B6864@infradead.org> <1072193516.3472.3.camel@fur>
	 <20031223163904.A8589@infradead.org>
	 <pan.2003.12.25.17.47.43.603779@dungeon.inka.de>
	 <20031225184553.A25397@infradead.org>
	 <1072381287.7638.52.camel@nosferatu.lan>
	 <20031226161949.A31900@infradead.org>  <20031226165456.GA26466@irc.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-b2vZZjFQUVSWWGYYakxT"
Message-Id: <1072469891.21020.3.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Dec 2003 22:18:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b2vZZjFQUVSWWGYYakxT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-12-26 at 18:54, Tomasz Torcz wrote:
> On Fri, Dec 26, 2003 at 04:19:49PM +0000, Christoph Hellwig wrote:
> > On Thu, Dec 25, 2003 at 09:41:28PM +0200, Martin Schlemmer wrote:
> > > So maybe suggest an solution rather than shooting one down all the
> > > time (which do seem logical, and is only apposed by one person curren=
tly
> > > - namely you =3D).
> >=20
> > My suggestion is to just use MAKEDEV asis for devices that are static
> > like the memdevices.  Dynamic solutions do not buy us anything for thos=
e.
>=20
>  They do buy when using tmpfs for /dev.

And it will anyhow require a full evaluation of MAKEDEV (debian's one
anyhow), as it really put a lot of extra crap in.  With Greg's patches I
only need to worry about /dev/core, /dev/std{in,out,err} and alsa.  The
question is now also how do you 'qualify' an device to have sysfs
support.  Sure some is static like /dev/null, but over here /dev/hda is
pretty static as well =3D)


--=20
Martin Schlemmer

--=-b2vZZjFQUVSWWGYYakxT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7JeDqburzKaJYLYRAvPYAJ91vuw7z20L/UXdsLOxzkelyfoLBQCfX4f9
0KChRXtt39jTOFtyZBXAGso=
=J5II
-----END PGP SIGNATURE-----

--=-b2vZZjFQUVSWWGYYakxT--

