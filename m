Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUAUI1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 03:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUAUI1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 03:27:36 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:4245 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262123AbUAUI1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 03:27:34 -0500
Date: Wed, 21 Jan 2004 09:26:35 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Bongani Hlope <bonganilinux@mweb.co.za>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: limit-timer_pm-printk-storms.patch
Message-ID: <20040121082635.GA5980@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Andrew Morton <akpm@osdl.org>,
	Bongani Hlope <bonganilinux@mweb.co.za>,
	linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
References: <20040120212514.43e31237.bonganilinux@mweb.co.za> <20040120115751.5e4441bc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20040120115751.5e4441bc.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2004 at 11:57:51AM -0800, Andrew Morton wrote:
> Bongani Hlope <bonganilinux@mweb.co.za> wrote:
> >
> > This patch has been inspired by the limit-IO-error-printk-storms patch.=
 On my PII when I enable=20
> > CONFIG_X86_PM_TIMER this gets called a lot of times, I guess my VIA chi=
pset is too broken to play with this.
> >=20
> > <example>
> > ...
> > Jan 19 04:21:46 bongani kernel: bad pmtmr read: (15567390, 15567423, 15=
567393)
> > Jan 19 04:21:46 bongani kernel: bad pmtmr read: (1746710, 1746719, 1746=
713)
> > Jan 19 04:21:47 bongani kernel: bad pmtmr read: (2239982, 2239999, 2239=
986)
>=20
> Does the PM timer actually do the right thing once these printk's are
> suppressed?

Just recognized my backup notebook, a Pentium III / Intel 440-BX-AGPset=20
does the same thing -- the pmtmr readings are always quite close to each=20
other, but not linear.

However, overall the PM timer _does_ the right thing all the time [it always
did the right thing on that system, as that's where the original patch was
created....]

	Dominik

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADje7Z8MDCHJbN8YRAg3aAKCrqiLzPpLrWeZCKHt0uCyDgo2UywCeKCE5
KE/ycUpYc+twa464VGX7yeg=
=RXL5
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
