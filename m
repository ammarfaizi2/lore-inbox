Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTEQM0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 08:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTEQM0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 08:26:13 -0400
Received: from dracula.eas.gatech.edu ([130.207.67.209]:51922 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S261433AbTEQM0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 08:26:12 -0400
Date: Sat, 17 May 2003 08:34:47 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: linux-kernel@vger.kernel.org, Joseph Fannin <jhf@rivenstone.net>
Subject: Re: 2.6 must-fix, v4
Message-ID: <20030517123447.GA31064@shaftnet.org>
References: <20030516161717.1e629364.akpm@digeo.com> <20030516161753.08470617.akpm@digeo.com> <20030517051621.GA10348@rivenstone.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20030517051621.GA10348@rivenstone.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2003 at 01:16:21AM -0400, Joseph Fannin wrote:
> On Fri, May 16, 2003 at 04:17:53PM -0700, Andrew Morton wrote:
> > - synaptic touchpad support
> >=20
> >   Apparently there's a userspace `tpconfig'
>=20
>    For 2.4, yes, but the new input layer doesn't allow the raw
> access to the device needed for tpconfig to frob the touchpads'
> configuration -- this is the reason for Bugzilla #18.  Vojitech
> Pavlik said writing support for raw access from userspace wouldn't be
> much less work than writing the kernel support.

More important than 'tpconfig' is that the native synaptics drivers for=20
both gpm and XFree86 won't work under 2.5+ either.

Jens Taprogee has also been working on a Synaptics Input driver.  The=20
main difference in what I have is that his passes the absolute events up=20
to the mousdev layer, which in turn does the heavy lifting.  Much better=20
IMO, as mousedev can get new features which will apply to all=20
absolute-mode touchpads and other input devices.

 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
                                                           ICQ #1318444
Quidquid latine dictum sit, altum viditur                 Melbourne, FL

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+xixmPuLgii2759ARAhHfAJ9xN3MTY3d898ZRkSavG7IKyLGl0gCcDg3g
eOv17OyeCxPqujY2Ie0sdrk=
=KvJX
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
