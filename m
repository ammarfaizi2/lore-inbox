Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVATCuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVATCuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVATCuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:50:21 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:51650 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261926AbVATCuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 21:50:09 -0500
Date: Wed, 19 Jan 2005 18:49:00 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, zaitcev@yahoo.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on USB_STORAGE=n
Message-ID: <20050120024900.GA5506@one-eyed-alien.net>
Mail-Followup-To: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>,
	zaitcev@yahoo.com, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20041220001644.GI21288@stusta.de> <20041220003146.GB11358@kroah.com> <20041223024031.GO5217@stusta.de> <20050119220707.GM4151@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20050119220707.GM4151@kroah.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 19, 2005 at 02:07:07PM -0800, Greg KH wrote:
> On Thu, Dec 23, 2004 at 03:40:31AM +0100, Adrian Bunk wrote:
> > On Sun, Dec 19, 2004 at 04:31:46PM -0800, Greg KH wrote:
> > > On Mon, Dec 20, 2004 at 01:16:44AM +0100, Adrian Bunk wrote:
> > > > I've already seen people crippling their usb-storage driver with=20
> > > > enabling BLK_DEV_UB - and I doubt the warning in the help text adde=
d=20
> > > > after 2.6.9 will fix all such problems.
> > > >=20
> > > > Is there except for kernel size any good reason for using BLK_DEV_U=
B=20
> > > > instead of USB_STORAGE?
> > >=20
> > > You don't want to use the scsi layer?  You like the stability of it at
> > > times?  :)
> > >=20
> > > > If not, I'd suggest the patch below to let BLK_DEV_UB depend
> > > > on EMBEDDED.
> > >=20
> > > No, it's good for non-embedded boxes too.
> >=20
> >=20
> > My current understanding is:
> > - BLK_DEV_UB supports a subset of what USB_STORAGE can support
> > - for an average user, there's no reason to enable BLK_DEV_UB
> > - if you really know what you are doing, there might be several reasons
> >   why you might want to use BLK_DEV_UB
>=20
> I have been running with just the code portion of this patch for a while
> now, with good results (no Kconfig changes.)
>=20
> Pete and Matt, do you mind me applying the following portion of the
> patch to the kernel tree?

I have no objection.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

E:  You run this ship with Windows?!  YOU IDIOT!
L:  Give me a break, it came bundled with the computer!
					-- ESR and Lan Solaris
User Friendly, 12/8/1998

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFB7xwcIjReC7bSPZARAvrVAKCXa5mDlqDqtRGHqT7ujkUlW0593ACffe5H
jyu83Dp36AaVWzUisZBx+Fs=
=FONx
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
