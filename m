Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUAPTua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUAPTua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:50:30 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:51087 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265756AbUAPTtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:49:42 -0500
Subject: Re: [PATCH] add sysfs class support for vc devices [10/10]
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20040116111738.74636496.akpm@osdl.org>
References: <20040115204048.GA22199@kroah.com>
	 <20040115204111.GB22199@kroah.com> <20040115204125.GC22199@kroah.com>
	 <20040115204138.GD22199@kroah.com> <20040115204153.GE22199@kroah.com>
	 <20040115204209.GF22199@kroah.com> <20040115204241.GG22199@kroah.com>
	 <20040115204259.GH22199@kroah.com> <20040115204311.GI22199@kroah.com>
	 <20040115204329.GJ22199@kroah.com> <20040115204356.GK22199@kroah.com>
	 <20040115201358.75ffc660.akpm@osdl.org>
	 <1074279897.23742.754.camel@nosferatu.lan>
	 <20040116111738.74636496.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qYZGaeuHUKtl3awj3Sw4"
Message-Id: <1074282773.23742.756.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Jan 2004 21:52:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qYZGaeuHUKtl3awj3Sw4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-16 at 21:17, Andrew Morton wrote:
> Martin Schlemmer <azarah@nosferatu.za.org> wrote:
> >
> > On Fri, 2004-01-16 at 06:13, Andrew Morton wrote:
> > > Greg KH <greg@kroah.com> wrote:
> > > >
> > > > This patch add sysfs support for vc char devices.
> > > >=20
> > > >  Note, Andrew Morton has reported some very strange oopses with thi=
s
> > > >  patch, that I can not reproduce at all.  If anyone else also has
> > > >  problems with this patch, please let me know.
> > >=20
> > > It seems to have magically healed itself :(
> > >=20
> > > Several people were hitting it.  We shall see.
> >=20
> > Might it be due to the vt-locking-fixes patch?
> >=20
>=20
> No, I was able to reproduce the oops with just two of Greg's patches on
> bare 2.6.1-rcX.
>=20
> It was some refcounting problem in the tty layer.  100% deterministic, no=
t
> a race.

No, I meant that fixed it.  The locking patch was added _after_ you
removed the vc patch ...

--=20
Martin Schlemmer

--=-qYZGaeuHUKtl3awj3Sw4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBACEEVqburzKaJYLYRAkP2AJ0a1hNYrG36vE4KA599X43T09hiogCfZq3Z
fnmeuZCdMNhtmg0vldPHqtU=
=9MH3
-----END PGP SIGNATURE-----

--=-qYZGaeuHUKtl3awj3Sw4--

