Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273299AbRINFC1>; Fri, 14 Sep 2001 01:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273300AbRINFCS>; Fri, 14 Sep 2001 01:02:18 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:13074
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S273299AbRINFCI>; Fri, 14 Sep 2001 01:02:08 -0400
Date: Thu, 13 Sep 2001 22:01:18 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Val Henson <val@nmt.edu>, jgarzik@mandrakesoft.com, becker@scyld.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
Message-ID: <20010913220118.A647@one-eyed-alien.net>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Val Henson <val@nmt.edu>, jgarzik@mandrakesoft.com,
	becker@scyld.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010913195141.B799@boardwalk> <20010913193937.O21906@cpe-24-221-152-185.az.sprintbbd.net> <20010913205459.A1169@boardwalk> <20010913200237.P21906@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010913200237.P21906@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Thu, Sep 13, 2001 at 08:02:37PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I would agree that listing them under the highest capable is probably the
best.  It is, at least, consistent with the 10/100 cards.

Also, people will pick up the card, think "gigabit ethernet", and then look
under the 1000 section.  I don't think anyone will really think GigE and
then look under 10/100.

The Intel 82543 and 82544 gigabit parts are all 10/100/1000 -- I'll be
writing a driver for those in a few weeks if nobody beats me to it, so I
think it would be good to settle this.

Matt

On Thu, Sep 13, 2001 at 08:02:37PM -0700, Tom Rini wrote:
> On Thu, Sep 13, 2001 at 08:55:01PM -0600, Val Henson wrote:
> > On Thu, Sep 13, 2001 at 07:39:37PM -0700, Tom Rini wrote:
> > > On Thu, Sep 13, 2001 at 07:51:41PM -0600, Val Henson wrote:
> > > > -      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFI=
G_NCR885E
> > > > +      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFI=
G_YELLOWFIN
> > >=20
> > > Since you're killing this, why not just remove this question entirely?
> >=20
> > This is one of the "design decisions" I referred to.  It makes no
> > sense to list a 100 Mbit driver under "Ethernet (1000 Mbit)".  This is
> > my solution.  This is the first case of a dual 1000/100 Mbit driver
> > and if there's a better way to handle it I'd like to hear it.
>=20
> Er, sungem does 10/100/1000 too I think.. (It's what's in the new G4
> towers..).  IMHO, listing it once under the greatest makes sense.  But
> sungem/gmac are under 10/100 I think.
>=20
> --=20
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

C:  They kicked your ass, didn't they?
S:  They were cheating!
					-- The Chief and Stef
User Friendly, 11/19/1997

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7oY8ez64nssGU+ykRAgldAKCLWmSCNgVI0s65WNGYFakagBACPwCcD9xE
viBYvDcNim9m7pYg2R4qCuA=
=qXo0
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
