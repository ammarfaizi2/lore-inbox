Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTD2ObO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 10:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbTD2ObO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 10:31:14 -0400
Received: from dracula.eas.gatech.edu ([130.207.67.209]:63134 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S262018AbTD2ObM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 10:31:12 -0400
Date: Tue, 29 Apr 2003 10:40:55 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: bas.mevissen@hetnet.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcom BCM4306/BCM2050  support
Message-ID: <20030429144055.GA11583@shaftnet.org>
References: <4b4e01c30e4e$0352c5a0$d16897c2@hetnet.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <4b4e01c30e4e$0352c5a0$d16897c2@hetnet.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2003 at 02:51:12PM +0200, bas.mevissen@hetnet.nl wrote:
> > Don't expect specs or opensource drivers for any of these pieces
> > of hardware until these vendors figure out a way to hide the frequency
> > programming interface.
>=20
> What did Intersil do? How did the linux-wlan-ng project handle this?

The linux-wlan-ng project only handles the prism2/2.5/3 chipsets, which=20
are *extremely* well documented (and 2.4G-only), so there really isn't=20
anything to "handle"; from the driver perspective  you just say "give=20
me channel X" and that's it.   If the eeprom-based tables say you can=20
use the channel, it lets you; otherwise it's No Soup For You. =20

Intersil is a poor example; they've generally been quite forthcoming
with documentation.  Granted, the docs for the PrismGT/etc stuff are
pretty bad, but you can get them without selling your soul.=20

(it's also worth mentioning that Intersil partially funded
linux-wlan-ng's development)
=20
RF tables and regulation might be an excuse chipset companies use to
hide their specs, but the real reasons tend to be a bit more along the
lines of:

"We want to protect our valuable IP"

=2E..which translates to:

"We want to protect our violations of other people's valuable IP"

It's CYA, plain and simple.  They're so terrified of litigation that=20
they feel that *any* semi-public information (even if only source code)=20
is a threat.=20

Many of them genuinely want to provide Linux support, in the form of
binary drivers much like Windows has.  Then they balk when realizing
what a support hell (and $$$) it will be to pull it off without
providing source code, thanks to the monolothic nature of the Linux
kernel.=20

Or at least that's been my experience in the past year.

 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
                                                           ICQ #1318444
Quidquid latine dictum sit, altum viditur                 Melbourne, FL

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+ro73PuLgii2759ARAoFLAJ9po7iOMpyXyEUGNUxkNGvb/sgtFwCeMnOg
QHpwXMxt+TOczQsx/BFnXz4=
=0glK
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
