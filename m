Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUC0Wmi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 17:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUC0Wmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 17:42:37 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:34199 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261989AbUC0Wmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 17:42:35 -0500
Date: Sat, 27 Mar 2004 14:42:22 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't eject jaz disk on 2.6
Message-ID: <20040327224222.GA5203@one-eyed-alien.net>
Mail-Followup-To: Wakko Warner <wakko@animx.eu.org>,
	linux-kernel@vger.kernel.org
References: <20040327075918.A2232@animx.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20040327075918.A2232@animx.eu.org>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 27, 2004 at 07:59:18AM -0500, Wakko Warner wrote:
> I've used 2.6.0 to 2.6.4 on a computer with a jaz drive.
> Using eject 2.0.13, I'm unable to eject the disk.  I have tested on 2.4.24
> and it does eject.

Over on the usb-storage list, we've just become aware of a similar problem.

Are you using SCSI or IDE?

We've actually recorded the SCSI layer sending us a PREVENT_MEDIUM_REMOVAL,
then a START_STOP (to actually eject), and then an ALLOW_MEDIUM_REMOVAL.
So, nothing gets ejected.  This is under 2.6.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

S:  Another stupid question?
G:  There's no such thing as a stupid question, only stupid people.
					-- Stef and Greg
User Friendly, 7/15/1998

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAZgNOIjReC7bSPZARAiekAJsFc7NfsKqI1/6tCweB1SjYDSBZZwCfbIBp
howHvlcfuhH/G9WWL6sILZw=
=UJR6
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
