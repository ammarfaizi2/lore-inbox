Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUBCUte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUBCUte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:49:34 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:22152 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266129AbUBCUtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:49:32 -0500
Subject: Re: [ANNOUNCE] udev 016 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040203201359.GB19476@kroah.com>
References: <20040203201359.GB19476@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-teR40gfJtCL1APwKsauG"
Message-Id: <1075841390.7473.57.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 22:49:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-teR40gfJtCL1APwKsauG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-03 at 22:13, Greg KH wrote:

>=20
> 	  Right now, udevsend and udev are built against klibc (udevsend
> 	  is only 2.5Kb big), and udevd is linked dynamically against
> 	  glibc, due to it using pthreads.  This is ok, as udev can
> 	  still be placed into initramfs and run at early boot, it's
> 	  only after init starts up that udevsend and udevd will kick
> 	  in.
>=20

I am guessing this breaks group names (and not gid's) in
udev.permissions?  Or was support added to klibc?


Thanks,

--=20
Martin Schlemmer

--=-teR40gfJtCL1APwKsauG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAIAluqburzKaJYLYRArTyAKCcqy6sCceenEzRbpsgSMErlAzyFwCgkNzJ
bCio2WJzYZHw75N1CGAOvlg=
=gSel
-----END PGP SIGNATURE-----

--=-teR40gfJtCL1APwKsauG--

