Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVGRHRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVGRHRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVGRHRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:17:04 -0400
Received: from bataysk.donpac.ru ([80.254.111.21]:14232 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261668AbVGRHOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:14:32 -0400
Date: Mon, 18 Jul 2005 11:14:17 +0400
To: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
Cc: Vojtech Pavlik <vojtech@suse.cz>, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Synaptics probe problem on Acer Travelmate 3004WTMi
Message-ID: <20050718071417.GE20588@pazke>
Mail-Followup-To: Thomas Sailer <sailer@sailer.dynip.lugs.ch>,
	Vojtech Pavlik <vojtech@suse.cz>, dtor_core@ameritech.net,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <1121275408.3583.35.camel@playstation2.hb9jnx.ampr.org> <d120d500050713103222aa9c91@mail.gmail.com> <20050713183804.GA2072@ucw.cz> <1121666056.3787.1.camel@unreal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <1121666056.3787.1.camel@unreal>
X-Uname: Linux 2.6.13-rc2-pazke i686
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 199, 07 18, 2005 at 07:54:16AM +0200, Thomas Sailer wrote:
> On Wed, 2005-07-13 at 20:38 +0200, Vojtech Pavlik wrote:
>=20
> > Also try the usual options ("i8042.nomux=3D1" and "usb-handoff"). One or
> > both may make the problem disappear.
>=20
> usb-handoff did it, thanks a lot!

IIRC there was a patch which used DMI to automatically enable USB handoff
on machines that need it. Was it rejected ?

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC21bJR2OTnxNuAyMRAoY9AKCIgedrPPC3ncxLrHhpJ6IbHqxFFwCgsyjH
40cGLW7PqycbLZF++5Pm/3A=
=ky5H
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
