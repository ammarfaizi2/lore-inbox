Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUCQKRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 05:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUCQKRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 05:17:23 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:40593 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261273AbUCQKRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 05:17:10 -0500
Date: Wed, 17 Mar 2004 10:53:14 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, Karol Kozimor <sziwan@hell.org.pl>,
       john stultz <johnstul@us.ibm.com>, acpi-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Message-ID: <20040317095314.GB14983@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Karol Kozimor <sziwan@hell.org.pl>,
	john stultz <johnstul@us.ibm.com>, acpi-devel@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
References: <16471.43776.178128.198317@wombat.chubb.wattle.id.au> <200403162340.57546.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <200403162340.57546.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2004 at 11:40:57PM -0500, Dmitry Torokhov wrote:
> On Tuesday 16 March 2004 08:33 pm, Peter Chubb wrote:
> > >>>>> "Dmitry" =3D=3D Dmitry Torokhov <dtor_core@ameritech.net> writes:
> >=20
> > Dmitry> On Tuesday 16 March 2004 07:13 pm, Karol Kozimor wrote:
> > >> Thus wrote john stultz: > Hmm. This is untested, but I think this
> > >> should do the trick.
> > >>=20
> > >> Hmm... without the patch, neither cpu MHz nor bogomips are updated,
> > >> with the patch cpu MHz value seems correct (both using acpi.ko and
> > >> speedstep-ich.ko, but the bogomips is still at its initial value.
> > >> Best regards,
> > >>=20
> >=20
> > Dmitry> Karol, do you have a P4? AFAIK P4's TSC is stable even if core
> > Dmitry> frequence changes so loop_per_juffy (=3D=3D bogomips) need not =
be
> > Dmitry> updated.
> >=20
> > The TSC is variable rate for Pentium-IV if you're using clock
> > modulation.
> >=20
> > Peter C
> >=20
>=20
> I understand that by clock modulation you mean throttling as opposed to
> true SpeedStep... OK, that means that for P4+ we somehow need to figure
> out whether the CPU is throttled or not to correctly calculate delays.
> Is there a clean way to get this data?

Hm, will have one patch to test it ready later today -- and a basic patch to
do this distinction is in the hiding of my notebook's harddisk already...
who's willing to do some testing on his SpeedStep-capable Pentium 4 - Mobil=
e.

	Dominik

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWCAKZ8MDCHJbN8YRAofzAKCBU1SRxVyq74ZD4CUChAe49FNKWwCfd+cM
7tbRdB/PnjbU03ruhRGy2G4=
=+BQ9
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
