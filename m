Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbUAKOnv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUAKOnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:43:51 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:56529 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265921AbUAKOnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 09:43:49 -0500
Date: Sun, 11 Jan 2004 15:43:43 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6: can't get 3c575/PCMCIA working - other PCMCIA card work
Message-ID: <20040111144343.GA8410@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040106111939.GA2046@piper.madduck.net> <20040111120053.C1931@flint.arm.linux.org.uk> <20040111123208.GA4766@piper.madduck.net> <20040111125404.E1931@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20040111125404.E1931@flint.arm.linux.org.uk>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Russell King <rmk+lkml@arm.linux.org.uk> [2004.01.11.1354 +0100=
]:
> Cardbus cards look exactly like normal PCI cards, and are therefore
> the drivers are handled by the PCI subsystem.  PCMCIA helps out only
> to detect the card insertion/removal events.

Are you sure about the latter. Cause the driver gets loaded whether
cardmgr is started or not. But in any case, cardmgr does not
configure the interface. Where can I find the hook for Cardbus cards
to do configuration after initialisation?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"i wish there was a knob on the tv to turn up the intelligence.
 there's a knob called 'brightness', but it doesn't seem to work."
                                                          -- gallagher

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAWEfIgvIgzMMSnURAjedAJ9UKDW4NFG/jEC3dygVyXi96r4LgwCfSrlA
7JHGONgAu+2UG+GKVct+VWo=
=nFk1
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
