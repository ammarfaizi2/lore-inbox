Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVEaIEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVEaIEy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVEaIEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:04:34 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:59042 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261345AbVEaIEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:04:21 -0400
Date: Tue, 31 May 2005 10:04:18 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via usbdevio
Message-ID: <20050531080418.GH25536@sunbeam.de.gnumonks.org>
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <20050530212641.GE25536@sunbeam.de.gnumonks.org> <200505301555.39985.david-b@pacbell.net> <200505310109.06445.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Content-Disposition: inline
In-Reply-To: <200505310109.06445.oliver@neukum.org>
User-Agent: mutt-ng 1.5.8-r168i (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, May 31, 2005 at 01:09:06AM +0200, Oliver Neukum
	wrote: > Am Dienstag, 31. Mai 2005 00:55 schrieb David Brownell: > >
	The logic closing an open usbfs file -- which is done before any task >
	> exits with such an open file -- is supposed to block till all its
	URBs > > complete. So the pointer to the task "should" be valid for as
	long as > > any URB it's submitted is active. > > What happens if you
	pass such an fd through a socket? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2005 at 01:09:06AM +0200, Oliver Neukum wrote:
> Am Dienstag, 31. Mai 2005 00:55 schrieb David Brownell:
> > The logic closing an open usbfs file -- which is done before any task
> > exits with such an open file -- is supposed to block till all its URBs
> > complete. =A0So the pointer to the task "should" be valid for as long as
> > any URB it's submitted is active.
>=20
> What happens if you pass such an fd through a socket?

which is exactly what happens on certain distributions for all device
opens if you look at SuSE's recent (in?)famous invention of resmgrd)

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCnBqCXaXGVTD0i/8RAqztAJ0QXv6lqIYFHl/gigxQmqk0kVSZ2ACdFuQL
L8pvLlVkIFqGt5dIeu16XQQ=
=KRuw
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--
