Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267499AbUHRSz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267499AbUHRSz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUHRSz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:55:27 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:47861 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S267499AbUHRSzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:55:22 -0400
Subject: Re: 2.6.8.1-mm1 Tty problems?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Olaf Hering <olh@suse.de>
Cc: ismail =?ISO-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>,
       Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040818064229.GD22332@suse.de>
References: <2a4f155d040817070854931025@mail.gmail.com>
	 <412247FF.5040301@microgate.com>
	 <2a4f155d0408171116688a87f1@mail.gmail.com>
	 <4122501B.7000106@microgate.com>
	 <2a4f155d04081712005fdcdd9b@mail.gmail.com>
	 <41225D16.2050702@microgate.com>
	 <2a4f155d040817124335766947@mail.gmail.com>
	 <41226512.9000405@microgate.com> <20040818062210.GB22332@suse.de>
	 <2a4f155d040817233463d2b78d@mail.gmail.com>
	 <20040818064229.GD22332@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LHARjxtXs/Ss151FzfYl"
Message-Id: <1092855516.8998.34.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 20:58:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LHARjxtXs/Ss151FzfYl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-18 at 08:42, Olaf Hering wrote:
>  On Wed, Aug 18, ismail d=C3=B6nmez wrote:
>=20
> > On Wed, 18 Aug 2004 08:22:10 +0200, Olaf Hering <olh@suse.de> wrote:=20
> > > /dev/tty is supposed to be char c 5 0, /class/tty/tty/dev will tell u=
dev
> > > how to create it, see man 4 tty.
> > > No idea who came up with the bright idea to put legacy bsd devices in=
 a
> > > subdir. Documentation/devices.txt shows that my patch is ok, it handl=
es
> > > up to 256 device nodes.
> > > If you are using udev, file a bugreport for your distros package. In =
the
> > > meantime, remove the offending line from your udev.rules file.
> >=20
> > I don't think you understood me. /dev/tty is created as a char device
> > in 2.6.8.1 kernel. So I am sure udev is fine but it shows up as a
> > directory in 2.6.8.1-mm1 kernel and if I backup bk-driver-core.patch
> > its all normal again.
>=20
> Works fine here.
> Check you udev.rules file if some rule matches the pattern ptyp0.

Hmm, Ok, so I see we have pty devices in there as well.  Ismail, what
tries to use /dev/tty anyhow?

--=20
Martin Schlemmer

--=-LHARjxtXs/Ss151FzfYl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBI6bcqburzKaJYLYRAgxdAJ9FEh7L5DKCo/zARrJHiSqvhAfl7QCfUxOZ
ac5UFEjwpxAu4USKnM0VLcc=
=cwtx
-----END PGP SIGNATURE-----

--=-LHARjxtXs/Ss151FzfYl--

