Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268399AbUHLElV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268399AbUHLElV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 00:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268390AbUHLElU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 00:41:20 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:15072 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S268381AbUHLEj0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 00:39:26 -0400
Subject: Re: 2.6.8-rc3-np1
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: lkml@lpbproduction.scom
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <200408111604.30739.lkml@lpbproductions.com>
References: <4117494E.704@yahoo.com.au>
	 <1092262435.8976.59.camel@nosferatu.lan>
	 <200408111604.30739.lkml@lpbproductions.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v9CP41KR7GhA8KwolRKZ"
Message-Id: <1092285761.8976.62.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 06:42:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v9CP41KR7GhA8KwolRKZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-08-12 at 01:04, Matt Heler wrote:
> This applied fine here with some tweaking. Removing the nmi fixes from th=
e np=20
> patch allowed it to apply just fine with some offsets , but not fuzz.
>=20


Yeah, I got it to apply with one small reject I think.  I assume you
did build it?  Do you have CONFIG_SCHED_SMT enabled?

>=20
>=20
>=20
> On Wednesday 11 August 2004 3:13 pm, Martin Schlemmer wrote:
> > On Mon, 2004-08-09 at 11:52, Nick Piggin wrote:
> > > http://www.kerneltrap.org/~npiggin/2.6.8-rc3-np1/
> > >
> > > Patch is against 2.6.8-rc3-mm2 only at this stage due to significant
> > > memory management changes in there making it difficult to track Linus=
'
> > > tree as well.
> > >
> > > Feedback on the scheduler would be much appreciated, as it might get
> > > a run in Andrew's tree soon.
> >
> > I am trying to get it patched against rc4-mm1, but it seems there
> > are some issues with the SMT bits - dependent_sleeper for example
> > is still around although it was removed with all previous patches
> > (and uses task_t.time_slice which is no longer there).
> >
> > I assume you forgot to apply them?  Possible to get a complete
> > patch?  If not, I'll see if I can get something going after some
> > sleep.
> >
> >
> > Thanks,
--=20
Martin Schlemmer

--=-v9CP41KR7GhA8KwolRKZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBGvVBqburzKaJYLYRAotmAJ9SLWDqOjVIh/fThze+KMEcgp6XBwCfX9eh
ZYj9IiOh0MFZCzjrwMLrHcc=
=XNRX
-----END PGP SIGNATURE-----

--=-v9CP41KR7GhA8KwolRKZ--

