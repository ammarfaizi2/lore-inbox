Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266562AbRGXBZm>; Mon, 23 Jul 2001 21:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266579AbRGXBZc>; Mon, 23 Jul 2001 21:25:32 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:13836
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S266562AbRGXBZX>; Mon, 23 Jul 2001 21:25:23 -0400
Date: Mon, 23 Jul 2001 18:24:57 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Paul Jakma <paul@clubi.ie>
Cc: Ben Greear <greearb@candelatech.com>,
        Chris Friesen <cfriesen@nortelnetworks.com>, sourav@csa.iisc.ernet.in,
        linux-kernel@vger.kernel.org
Subject: Re: Arp problem
Message-ID: <20010723182456.B3826@one-eyed-alien.net>
Mail-Followup-To: Paul Jakma <paul@clubi.ie>,
	Ben Greear <greearb@candelatech.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	sourav@csa.iisc.ernet.in, linux-kernel@vger.kernel.org
In-Reply-To: <3B5CC947.2E027588@candelatech.com> <Pine.LNX.4.33.0107240208460.10839-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107240208460.10839-100000@fogarty.jakma.org>; from paul@clubi.ie on Tue, Jul 24, 2001 at 02:10:33AM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've done this before... I used ethernet aliases to put an alias on one
subnet and the master (non-alias) on the other.  Then it was just a matter
of some ipchains rules and turning on forwarding.

Matt

On Tue, Jul 24, 2001 at 02:10:33AM +0100, Paul Jakma wrote:
> On Mon, 23 Jul 2001, Ben Greear wrote:
>=20
> > The arp-filter patch is in the kernel since about 2.4.4, so you just ne=
ed
> > to turn it on...
>=20
> on a related note:
>=20
> if i have 2 logical subnets on the wire, linux listening on both, is
> there any way to get linux to fully route packets between the 2
> subnets?
>=20
> at the moment it just issues a icmp_redirect, which isn't good enough
> for certain hosts (eg win9x at least).
>=20
> > Ben
>=20
> regards,
> --=20
> Paul Jakma	paul@clubi.ie	paul@jakma.org
> PGP5 key: http://www.clubi.ie/jakma/publickey.txt
> -------------------------------------------
> Fortune:
> How come everyone's going so slow if it's called rush hour?
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It's not that hard.  No matter what the problem is, tell the customer=20
to reinstall Windows.
					-- Nurse
User Friendly, 3/22/1998

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7XM5oz64nssGU+ykRArXfAJ4h2IxhJlnt2qkdltKAQdsqRzTn2wCfbxty
JMH9p/UGh+IJPmdjdPH0on4=
=sTMi
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
