Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbUCPXfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUCPXfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:35:36 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:47001 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261841AbUCPXfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:35:24 -0500
Date: Wed, 17 Mar 2004 00:33:34 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Karol Kozimor <sziwan@hell.org.pl>, dtor_core@ameritech.net,
       acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Message-ID: <20040316233334.GA9001@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	john stultz <johnstul@us.ibm.com>,
	Karol Kozimor <sziwan@hell.org.pl>, dtor_core@ameritech.net,
	acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
References: <20040316182257.GA2734@dreamland.darkstar.lan> <20040316194805.GC20014@picchio.gall.it> <20040316214239.GA28289@hell.org.pl> <1079479694.5408.47.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <1079479694.5408.47.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2004 at 03:28:15PM -0800, john stultz wrote:
> On Tue, 2004-03-16 at 13:42, Karol Kozimor wrote:
> > Thus wrote Daniele Venzano:
> > > > I have a notebook with an Athlon-M CPU. I tried linux 2.6.4 with
> > > > CONFIG_X86_PM_TIMER=3Dy and I noticed that /proc/cpuinfo doesn't get
> > > > updated when I switch frequency (via sysfs, using powernow-k7). The=
 is
> > > > issue seems cosmetic only, CPU frequency changes (watching
> > > > temperature/battery life).
> > > I can confirm, I'm seeing the same behavior. Please note that the
> > > bogomips count gets updated, it's only the frequency that doesn't
> > > change.
> >=20
> > Same here with a P4-M, follow-up to John and Dmitry.
>=20
> Hmm. This is untested, but I think this should do the trick.
>=20
> Dominik: Is there any reason I'm not seeing why cpu_khz should only be
> updated when using the TSC?

Is cpu_khz always correct (or, at least, nonzero) when we're reaching this=
=20
code path?

	Dominik

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAV47OZ8MDCHJbN8YRAlPkAJ9oJplYqOgfJ7PexNqOdvel1+E/mgCcD5Aa
NL0+uIk+qLboaYSJHhMy6+o=
=lGxu
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
