Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUAKQOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265914AbUAKQOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:14:39 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:52402 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265907AbUAKQOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:14:37 -0500
Date: Sun, 11 Jan 2004 17:14:32 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6: can't get 3c575/PCMCIA working - other PCMCIA card work
Message-ID: <20040111161432.GA10906@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040106111939.GA2046@piper.madduck.net> <20040111120053.C1931@flint.arm.linux.org.uk> <20040111123208.GA4766@piper.madduck.net> <20040111125404.E1931@flint.arm.linux.org.uk> <20040111144343.GA8410@piper.madduck.net> <20040111150223.A8427@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20040111150223.A8427@flint.arm.linux.org.uk>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Russell King <rmk+lkml@arm.linux.org.uk> [2004.01.11.1602 +0100=
]:
> > Cause the driver gets loaded whether cardmgr is started or not. But in
> > any case, cardmgr does not configure the interface.
>=20
> cardmgr doesn't play a part when you've inserted a cardbus card - it
> doesn't even know that a card has been inserted into the slot.

So with 'PCMCIA' you didn't mean the user-space programs.

> The hotplug scripts are then supposed to load the driver as
> necessary (using /etc/modules.conf) which creates a network
> interface.  This then causes the hotplug scripts to be invoked
> again, this time for the new network interface, which should
> configure it.

Nifty. I will RTFM and hopefully find my way around in this versatile
complexity.

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"when faced with a new problem, the wise algorithmist
 will first attempt to classify it as np-complete.
 this will avoid many tears and tantrums as
 algorithm after algorithm fails."
                                                          -- g. niruta

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAXZoIgvIgzMMSnURAj9uAJ9B6+zoctGVduXlLLxVYKh4RDlilACfWhZd
9e0oCUwbGhZ4eoS0OmncFXM=
=FObT
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
