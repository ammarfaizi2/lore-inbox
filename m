Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWBSHGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWBSHGv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 02:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWBSHGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 02:06:51 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:8597 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S1751106AbWBSHGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 02:06:50 -0500
Date: Sat, 18 Feb 2006 23:06:31 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Wolfgang =?iso-8859-1?Q?M=FCes?= <wolfgang@iksw-muees.de>,
       martinmaurer@gmx.at
Subject: Re: [linux-usb-devel] Re: 2.6.15: usb storage device not detected
Message-ID: <20060219070631.GA6943@one-eyed-alien.net>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>, CaT <cat@zip.com.au>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	Wolfgang =?iso-8859-1?Q?M=FCes?= <wolfgang@iksw-muees.de>,
	martinmaurer@gmx.at
References: <20060109130540.GB2035@zip.com.au> <20060109101713.469d3a7f.zaitcev@redhat.com> <20060219051915.GA1888@zip.com.au> <20060218224924.737bd36b.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20060218224924.737bd36b.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2006 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2006 at 10:49:24PM -0800, Pete Zaitcev wrote:
>=20
> I see... This is a device which dislikes the stall clear when called after
> a stall on the control pipe.
>=20
> I knew this was inevitable ever since Wolfgang pointed me at it when we
> debugged Martin's Elitegroup K7S5A.
>=20
> I'm going to send the attached patch to Greg to get it into 2.6.17
> (this way it will be separated from all the reset machinery which goes
> into 2.6.16). I have tested it on my honest to goodness ZIP-100, and
> yes, it stalls the control pipe at the GetMaxLUN, and yes, it works
> after that. Here's the hope that it is some kind of an urban legend.

It's not an urban legend.  There are several different devices which were
all marketed as ZIP-100.  The early generation ones had this problem.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

E:  You run this ship with Windows?!  YOU IDIOT!
L:  Give me a break, it came bundled with the computer!
					-- ESR and Lan Solaris
User Friendly, 12/8/1998

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD+Bj3HL9iwnUZqnkRAqePAKCbLIJFutm9mNxGYN/+9Kv2kas3pQCgp7xb
tr2BQ1xcY5oHja2ZrJmQ2Jo=
=USA/
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
