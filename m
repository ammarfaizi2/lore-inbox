Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUF0VDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUF0VDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 17:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUF0VDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 17:03:38 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:11229 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262380AbUF0VDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 17:03:33 -0400
Date: Sun, 27 Jun 2004 14:03:21 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
       arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, david-b@pacbell.net, oliver@neukum.org
Subject: Re: drivers/block/ub.c
Message-ID: <20040627210321.GA12839@one-eyed-alien.net>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
	arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
	linux-kernel@vger.kernel.org, david-b@pacbell.net,
	oliver@neukum.org
References: <20040627050201.GA24788@kroah.com> <Pine.LNX.4.44L0.0406271120520.10357-100000@netrider.rowland.org> <20040627132945.70350f2a@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20040627132945.70350f2a@lembas.zaitcev.lan>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 27, 2004 at 01:29:45PM -0700, Pete Zaitcev wrote:
> On Sun, 27 Jun 2004 11:23:10 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> wrote:
>=20
> > + * -- use serial numbers to hook onto same hosts (same minor) after
> > disconnect
>=20
> It was a poor wording by me. It refers to the drift of naming due to
> increments in usb_host_id. After a disconnect and reconnect, /dev/uba1
> refers to the device, but /proc/partitions says "ubb".
>=20
> To correct this, I have to set gendisk->fist_minor before calling
> add_disk(), but in order to do that, a driver has to track devices
> somehow. A serial number looks like an obvious candidate for a key.

Serial numbers are unreliable for this.  We've had a long history with this
issue.  Many devices do not provide a serial number.  Many devices provide
a serial number, but it is not a constant.  Many devices provide invalid
serial numbers.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

IT KEEPS ASKING ME WHERE I WANT TO GO TODAY! I DONT WANT TO GO ANYWHERE!
					-- Greg
User Friendly, 11/28/97

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA3zYZIjReC7bSPZARAtJpAKCYsjsEB0MbYsQGPm6b/QOcB/bJ9QCfVijX
aEtWgu0EhUxkecCvJw9u/PY=
=Oxao
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
