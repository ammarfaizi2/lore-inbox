Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268887AbRG0QTi>; Fri, 27 Jul 2001 12:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268886AbRG0QT3>; Fri, 27 Jul 2001 12:19:29 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:44549
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S268876AbRG0QTU>; Fri, 27 Jul 2001 12:19:20 -0400
Date: Fri, 27 Jul 2001 09:18:58 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, linux-scsi@vger.kernel.org,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.7-pre9..
Message-ID: <20010727091858.C10787@one-eyed-alien.net>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexander Viro <viro@math.psu.edu>,
	"David S. Miller" <davem@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
	David Woodhouse <dwmw2@redhat.com>, linux-scsi@vger.kernel.org,
	Andrew Morton <andrewm@uow.edu.au>
In-Reply-To: <Pine.LNX.4.33.0107192208070.14141-100000@penguin.transmeta.com> <20010723125635.A35@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010723125635.A35@toy.ucw.cz>; from pavel@suse.cz on Mon, Jul 23, 2001 at 12:56:35PM +0000
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Oh damn....

It looks like I missed an important discussion in the torrent of e-mail
that I receive... could someone give me the 30-second executive summary so
I can look at what may need to change in usb-storage?

Matt

On Mon, Jul 23, 2001 at 12:56:35PM +0000, Pavel Machek wrote:
> Hi!
>=20
> > I've changed all generic code, so drivers are all expected to compile a=
nd
> > work. However, some SCSI drivers use the semaphore trick in their own
> > code, and I've not mucked with that. It's not worth worrying about too
> > much, as the race is basically impossible to hit (famous last words), b=
ut
>=20
> I smell problems in usb/storage/*...
>=20
> <evil>
> What about adding strategic udelay() somewhere so race is easier to hit?
> </evil>
> 								Pavel
> --=20
> Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
> details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

You should try to see the techs say "three piece suit".
					-- The Chief
User Friendly, 11/23/1997

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7YZRxz64nssGU+ykRAteVAJ4wbWaeIfViRTi7CSGy0psN6V38NgCg6wCw
Wr2CmZ/eXqX19nYSLdvgee8=
=H8E1
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
