Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVE3SCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVE3SCY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVE3SCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:02:23 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.4.204]:64824 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261662AbVE3SCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:02:02 -0400
Date: Mon, 30 May 2005 14:01:56 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Adaptec AIC-79xx HostRaid
In-reply-to: <20050530172105.GA15253@havoc.gtf.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Clemente Aguiar <caguiar@madeiratecnopolo.pt>,
       linux-kernel@vger.kernel.org
Message-id: <20050530180156.GA32606@optonline.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=vkogqOf2sHV7VnPd;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
References: <6A0C419392D7BA45BD141D0BA4F253C776F1@loureiro.madeiratecnopolo.pt>
 <20050530172105.GA15253@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2005 at 01:21:05PM -0400, Jeff Garzik wrote:
> On Mon, May 30, 2005 at 06:13:03PM +0100, Clemente Aguiar wrote:
> >=20
> > Hello,
> >=20
> > We have acquired some IBM xServers which have an integrated raid contro=
ller
> > based on the Adaptec AIC-79xx U320 SCSI controller (called HostRaid).
> >=20
> > Is there already support for HostRaid? Are there drivers for it?
> > >From which kernel version and where do I find it in the config?
>=20
> HostRaid is just software RAID; you can ignore it and let Linux use the
> underlying SCSI devices via the standard aic79xx driver.

As far as I know, it is software raid done much closer to the hw than
the linux sw raid (md).

There is a module (binary only) from Adaptec that lets Linux use HostRaid,
but from what I saw, it just worked with RHEL 3.x and some other ancient
RH releases. When I was installing RHEL 4 on an IBM xServer, I decided to
just do standard linux sw array.

Jeff.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCm1UUwFP0+seVj/4RAkadAJ0fpaXUx9/pByLsHYMHGvC6GvyJJwCfcFMg
LZMFOzoSE8qpYLg6twWishI=
=D7gf
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
