Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWGaPWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWGaPWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWGaPWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:22:52 -0400
Received: from nsm.pl ([195.34.211.229]:12556 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S932319AbWGaPWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:22:51 -0400
Date: Mon, 31 Jul 2006 17:22:47 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
Message-ID: <20060731152247.GA6768@irc.pl>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
References: <20060730120844.GA18293@outpost.ds9a.nl> <20060730160738.GB13377@irc.pl> <Pine.LNX.4.64.0607301043070.7932@montezuma.fsmlabs.com> <20060731055655.GB7094@irc.pl> <Pine.LNX.4.64.0607310701190.10584@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607310701190.10584@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2006 at 07:04:07AM -0700, Zwane Mwaikambo wrote:
> On Mon, 31 Jul 2006, Tomasz Torcz wrote:
>=20
> > On Sun, Jul 30, 2006 at 10:45:13AM -0700, Zwane Mwaikambo wrote:
> >=20
> > > CONFIG_X86_ACPI_CPUFREQ
> >=20
> >   I had this one =3Dy. After setting =3Dn, cpufreq-nforce2 (=3Dm) works=
 again.
> >=20
> > powernowd: PowerNow Daemon v0.96, (c) 2003-2005 John Clemens
> > powernowd: Found 1 cpu:  -- 1 thread (or core) per physical cpu
> > /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: No
> > such file or directory
> > powernowd:   cpu0: 1228Mhz - 1753Mhz (7 steps)
>=20
> Hi Tomasz,
>=20
> 	Could you also please test Bert's patch which propogates error=20
> return values with your previous configuration?

  Bert's patch works. With CONFIG_X86_ACPI_CPUFREQ=3Dy and
cpufre-nforce2=3Dm I have working cpufreq (like in 2.6.17 and before).

--=20
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEziBHThhlKowQALQRAjxVAKDk83nOi9lYqPSU2NAH7IsHbJrCMgCgsFyi
lH2YST+vCmMJod2T1gEnNRo=
=tWS1
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
