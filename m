Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUFZUNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUFZUNh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 16:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUFZUMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 16:12:51 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:57025 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S266425AbUFZUMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 16:12:38 -0400
Date: Sat, 26 Jun 2004 13:12:25 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org,
       USB Storage List <usb-storage@lists.one-eyed-alien.net>,
       stern@rowland.harvard.edu, david-b@pacbell.net, oliver@neukum.org
Subject: Re: drivers/block/ub.c
Message-ID: <20040626201225.GA2149@one-eyed-alien.net>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com,
	arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
	linux-kernel@vger.kernel.org,
	USB Storage List <usb-storage@lists.one-eyed-alien.net>,
	stern@rowland.harvard.edu, david-b@pacbell.net, oliver@neukum.org
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20040626130645.55be13ce@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 26, 2004 at 01:06:45PM -0700, Pete Zaitcev wrote:
> Hi, guys,
>=20
> I have drafted up an implementation of a USB storage driver as I wish
> it done (called "ub"). The main goal of the project is to produce a driver
> which never oopses, and above all, never locks up the machine. To this
> point I did all my debugging while running X11 and yapping on IRC. If this
> goal requires to sacrifice performance, so be it. This is how ub differs
> from the usb-storage.
>=20
> The current usb-storage works quite well on servers where netdump can
> be brought to bear, but on desktop its debuggability leaves some room
> for improvement. In all other respects, it is superior to ub. Since
> characteristics of usb-storage and ub are different I expect them to
> coexist potentially indefinitely (if ub finds any use at all).

Would I be correct in the following assessments:
(1) UB only supports direct-access type devices
(2) UB only supports 'transparent scsi' devices
(3) UB only supports 'bulk-only transport' devices

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA3dipIjReC7bSPZARAupfAJ4n6L2E7UN6jqv9121r+2F0sUMMOwCdG3lc
n42O1dnSyJHxA1wvED48taY=
=Z/AR
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
