Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318760AbSG0N6A>; Sat, 27 Jul 2002 09:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318761AbSG0N6A>; Sat, 27 Jul 2002 09:58:00 -0400
Received: from roc-24-58-90-11.rochester.rr.com ([24.58.90.11]:44466 "EHLO
	tarnation.dyndns.org") by vger.kernel.org with ESMTP
	id <S318760AbSG0N57>; Sat, 27 Jul 2002 09:57:59 -0400
Date: Sat, 27 Jul 2002 09:57:47 -0400
From: Aaron Gaudio <prothonotar@tarnation.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems assigning IRQs on Sony R505ECK laptop
Message-ID: <20020727095747.A21507@tarnation.dyndns.org>
References: <20020726114157.A11147@tarnation.dyndns.org> <1027766903.22179.31.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1027766903.22179.31.camel@sonja.de.interearth.com>; from degger@fhm.edu on Sat, Jul 27, 2002 at 12:48:23PM +0200
X-Operating-System: Linux tarnation.dyndns.org 2.4.18-5custom
X-PGP-Fingerprint: 6249 4FF6 F418 F3F9 5DAF 3E92 C170 C6ED 940D F757
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And lo, upon Sat, Jul 27, 2002 at 12:48:23PM +0200, Daniel Egger spaketh th=
usly:
> Am Fre, 2002-07-26 um 17.41 schrieb Aaron Gaudio:
>=20
> > Hi all. I'm having trouble with linux finding IRQs for several
> > devices on my Sony R505ECK laptop (just got it yesterday :)
>=20
> I've seen similar troubles on a different Vaio (unfortunately I don't
> have the model number handy). Basically what happens is that the
> Local-APIC seemingly isn't initialised correctly, all bridges in the
> system are treated transparently and all devices get the same IRQ (9)
> assigned. The system works just fine but I guess not as efficient as
> it could go because of the interrupt storm on IRQ 9. I can get get all
> data from this machine if someone wants to debug this problem.
>=20

Unfortunately, it doesn't seem like everything is working just fine.
In Windows, yes, all the PCI devices get assigned IRQ 9.. maybe that's
not the most efficient way, but that does seem to work. In Linux, only
5 of the devices get the IRQ, and the others don't (firewire, one of the
USB controllers, one of the CardBus controllers (an internal one,
apparently, because the built-in Orinoco card won't load due to an
IRQ conflict with IRQ 9).

I'd like to figure out how to get these devices working, whether or
not they have to use IRQ 9... then I can worry about making it
as efficient as possible. :)


--=20

Aaron Gaudio                           prothontar @ tarnation.dyndns.org
                   http://tarnation.dyndns.org/~aaron
                            ----------------
  "From fullness, aspect. From aspect, being. From being, emptiness."

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1CptsACgkQwXDG7ZQN91eDngCgzJXQ4FAEhYBJa9ER9dtB9ePY
PCAAn3XMrNAwm/FC/6/pIsOElH3ATqgQ
=q+V+
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
