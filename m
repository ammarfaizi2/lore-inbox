Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSGQR0t>; Wed, 17 Jul 2002 13:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSGQR0t>; Wed, 17 Jul 2002 13:26:49 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:10761 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S315458AbSGQR0s>; Wed, 17 Jul 2002 13:26:48 -0400
Date: Wed, 17 Jul 2002 10:29:39 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Breakage with "usb-storage: catch bad commands"
Message-ID: <20020717102939.A25228@one-eyed-alien.net>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020716140722.GM7955@tahoe.alcove-fr> <20020716103503.B14269@one-eyed-alien.net> <20020717090554.GB14581@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020717090554.GB14581@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Wed, Jul 17, 2002 at 11:05:54AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hrm.. interesting.

It appears that when we probe for a device, we issue a proper INQUIRY.
But, when we probe LUN !=3D 0, we then send a bogus or semi-bogus INQUIRY.
I'll have to look into this more.

Thanks for the info.

Matt

On Wed, Jul 17, 2002 at 11:05:54AM +0200, Stelian Pop wrote:
> On Tue, Jul 16, 2002 at 10:35:04AM -0700, Matthew Dharm wrote:
>=20
> > Can you recompile with the verbose debugging turned on so we can see wh=
ich
> > command caused the problem?

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Why am I talking to a toilet brush?
					-- CEO
User Friendly, 4/30/1998

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9NamDIjReC7bSPZARAigvAJsFO8S6sr/kdKA9DzF0X9S+k/pT3ACfds40
9SMYSMAQJb6cUPOfT90boN8=
=Ins6
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
