Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbUALAZr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 19:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUALAZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 19:25:46 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:7352 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S265811AbUALAZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 19:25:44 -0500
Date: Sun, 11 Jan 2004 16:25:34 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oliver Neukum <oliver@neukum.org>, David Brownell <david-b@pacbell.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USB hangs
Message-ID: <20040112002534.GC8082@one-eyed-alien.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Oliver Neukum <oliver@neukum.org>,
	David Brownell <david-b@pacbell.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk> <4001DB52.7030908@pacbell.net> <200401120033.40230.oliver@neukum.org> <1073866181.26806.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <1073866181.26806.4.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2004 at 12:09:41AM +0000, Alan Cox wrote:
> On Sul, 2004-01-11 at 23:33, Oliver Neukum wrote:
> > For users of a kernel thread it helps. But what affects storage
> > also make affect anything else that has a filesystem running
> > over it. Plus it forces us to keep the storage thread model, which
> > might be a solution that needs to be revisited.
>=20
> Its a larger hammer, for 2.6 I agree that moving the right code to
> GFP_NOIO is far better a solution. For 2.4 I just want it working with
> minimal risk of screwups.

Well, I have no objection to adding that to 2.4 -- either push to Marcelo
yourself or send it to Greg K-H for inclusion in his 2.4 tree and eventual
push upstream.

But we do need to do some sort of 2.6 audit for this sort of thing.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

G:   Baaap booop BAHHHP.
Mir: 9600 Baud?
Mik: No, no!  9600 goes baap booop, not booop bahhhp!
					-- Greg, Miranda and Mike
User Friendly, 12/31/1998

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAAel+IjReC7bSPZARAj+UAKDW9wQuiJD1VXD+inxeESENBFOpgACgntP/
92/LPXR0jA12yJ0fHCPtNY0=
=KfXJ
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
