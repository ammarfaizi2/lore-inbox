Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281975AbRKUUtM>; Wed, 21 Nov 2001 15:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281976AbRKUUsw>; Wed, 21 Nov 2001 15:48:52 -0500
Received: from dhcp065-024-127-026.columbus.rr.com ([65.24.127.26]:33796 "EHLO
	zion.rivenstone.net") by vger.kernel.org with ESMTP
	id <S281975AbRKUUsk>; Wed, 21 Nov 2001 15:48:40 -0500
Date: Wed, 21 Nov 2001 15:48:36 -0500
To: Anders Linden <anli@perceptive.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Network card timeouts
Message-ID: <20011121154836.A9016@gibraltar.rivenstone.net>
In-Reply-To: <71C83C8929F73A40BBD0C137232DD1972ED4@piff.i.perceptive.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <71C83C8929F73A40BBD0C137232DD1972ED4@piff.i.perceptive.se>
User-Agent: Mutt/1.3.23i
From: Joseph Fannin <jhf@rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2001 at 07:16:23PM +0100, Anders Linden wrote:
> Symptom:
> Network cards that stops working if they are sent enough data.
>=20
> The cards I have got problem with this far:
> Intel Etherexpress Pro 100+ (some kernels ago).
> Davicom Semiconductor, Inc. Ethernet 100/10

    I have seen very similar symptoms in two ISA eepro cards.  I found that,
if I kept a `ping` process running on the machine with an eepro installed,
the card would work okay, but somewhat slowly.  Otherwise it would just
hang, and had to be restarted to work again.

    (Note: this was a few weeks ago, and I'm not using any of my eepro cards
because of it anymore.  I haven't tried the new(ly maintained) driver.)

    It would be interesting to find that this is a more general problem; a
good bit of the reason why I've never reported it is because my eepro cards
are old and suspect themselves.


>=20
> Occasion 1:
> The kernel version on the computers were 2.4.3. Every person in a single
> classroom had problem with Intel cards. They could not even fetch
> webpages before their consoles were spammed with a message like: network
> card timeout. All computers were Compaq. I dont know which hardware they
> had in addition to that. I have also had problems with Intel cards even
> after this occasion on other computers.
>=20
> Occasion 2:
> The later card, Davicom, is probably not a well-known card, but
> nevertheless, it works like shit in Linux. I am using Redhat 7.1 and the
> kernel 2.4.2-2. If I send more than 10M to such a card in an interval of
> a second, it just quits working for 5 seconds. The card has no problems
> at all in other, third party operating systems, like Windows.
>=20
>=20
> Is it the newest kernels that has theese problems? The first occasion
> was exactly after a kernel 2.4.3 has been released, and people I talked
> to said that 2.4.2 and network cards were better friends.
>=20
>=20
> Thanks for your attension
>=20
> /Anders Lind?n
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7/BMkWv4KsgKfSVgRAiBRAJoDBoiPNmprEnyMeNTtO+KMVZs2KACdHgON
KM/LX6KWR6wf25/hdeg2/YE=
=hgtu
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
