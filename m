Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTFHVOt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 17:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTFHVOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 17:14:49 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:36623 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S263859AbTFHVOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 17:14:46 -0400
Date: Sun, 8 Jun 2003 14:28:21 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [patch] scsi: ten -> use_10_for_rw / use_10_for_ms
Message-ID: <20030608142821.F25191@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, torvalds@transmeta.com
References: <UTC200305230722.h4N7Mid25812.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200305230722.h4N7Mid25812.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, May 23, 2003 at 09:22:44AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2003 at 09:22:44AM +0200, Andries.Brouwer@cwi.nl wrote:
> In the old days, ancient scsi devices understood 6-byte commands
> and more recent ones also understood 10-byte commands.
> Thus, we had a "ten" flag indicating that 10-byte commands worked.
>=20
> These days, especially for usb-storage devices, the opposite
> sometimes holds - 10-byte commands are supported, but 6-byte commands
> are not.
>=20
> The patch below changes the field ten into the pair of fields
> use_10_for_rw, use_10_for_ms set initially when the driver
> thinks these are supported. Ifthe device returns ILLEGAL_REQUEST
> they are cleared.
>=20
> This patch obsoletes a large amount of code in usb-storage,
> and not only that, once the subsequent patch removes all this
> usb-storage code many devices will work that hang today.

Any idea when you'll submit that patch to usb-storage?

Do you perhaps just want to send what you have to me for integration?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Sir, for the hundreth time, we do NOT carry 600-round boxes of belt-fed=20
suction darts!
					-- Salesperson to Greg
User Friendly, 12/30/1997

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+46p1IjReC7bSPZARAlRWAJ9JvC9CFZNdXMb0ke3G8q3KnDFC7QCfamXN
b6F9r/KWJkRZL9+vDDZOjnY=
=Br0e
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
