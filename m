Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWBXTqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWBXTqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 14:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWBXTqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 14:46:43 -0500
Received: from mail.bytecamp.net ([212.204.60.9]:61453 "HELO mail.bytecamp.net")
	by vger.kernel.org with SMTP id S932441AbWBXTqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 14:46:43 -0500
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: Christian Neumair <chris@gnome-de.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dhazelton@enter.net, nix@esperi.org.uk, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, davidsen@tmr.com, axboe@suse.de
In-Reply-To: <43FAED22.nailD1291Q4HS@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	 <200602192053.25767.dhazelton@enter.net> <43F9F11E.nail5BM21M01Q@burner>
	 <200602202311.29759.dhazelton@enter.net>  <43FAED22.nailD1291Q4HS@burner>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mbh7eScNmZXQPZMUnnKO"
Date: Fri, 24 Feb 2006 20:46:21 +0100
Message-Id: <1140810381.3160.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mbh7eScNmZXQPZMUnnKO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 21.02.2006, 11:36 +0100 schrieb Joerg Schilling:
> I did write some time ago that the most probable cause for the Linux
> bug is that
> Linux is sending uninitialized data for the amount of bytes that pad
> to 12 byte.

How are they supposed to be filled? I don't have a clue on the low-level
stuff involved, but isn't this as simple as initializing the rest of the
c array in idescsi_pc_t to 0?

--=20
Christian Neumair <chris@gnome-de.org>

--=-mbh7eScNmZXQPZMUnnKO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD/2KMWfvsaU5lO4kRAs/yAJ0bg6Wzo8Ax3m7Q4FcOftY3AcZbKQCglAoB
eBDIJOr47PzKRCYCq/qUff4=
=m1py
-----END PGP SIGNATURE-----

--=-mbh7eScNmZXQPZMUnnKO--

