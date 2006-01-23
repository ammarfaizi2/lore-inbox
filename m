Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWAWM2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWAWM2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAWM2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:28:33 -0500
Received: from admingilde.org ([213.95.32.146]:54680 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751398AbWAWM2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:28:32 -0500
Date: Mon, 23 Jan 2006 13:28:31 +0100
From: Martin Waitz <tali@admingilde.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andi Kleen <ak@suse.de>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fixing make mandocs
Message-ID: <20060123122831.GC11002@admingilde.org>
Mail-Followup-To: "Randy.Dunlap" <rdunlap@xenotime.net>,
	Andi Kleen <ak@suse.de>, kernel-janitors@lists.osdl.org,
	linux-kernel@vger.kernel.org
References: <200601230531.27609.ak@suse.de> <20060122204921.613349e5.rdunlap@xenotime.net> <200601230552.09142.ak@suse.de> <20060122205349.0ec46cbe.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20060122205349.0ec46cbe.rdunlap@xenotime.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Jan 22, 2006 at 08:53:49PM -0800, Randy.Dunlap wrote:
> > > > Here would be a good janitor task for 2.6.16. make mandocs
> > > > currently doesn't build because a number of descriptions are
> > > > missing parameters etc.  It would be good if someone could fix
> > > > that and submit patches for 2.6.16.

the thing that really breaks the build is the new __copy_to_user
prototype which kernel-doc could not understand.
This is fixed in my tree.

> > Ok good. Are they going into 2.6.16?

I'll try to get at least the one kernel-doc fix into 2.6.16.

--=20
Martin Waitz

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD1Mvvj/Eaxd/oD7IRApu6AJ45f0HrOGg6WXYtKhYp6EFfYKZmPwCeNRzC
fvYrLMnd9IkBj7vIbW2Tvg4=
=KC1Y
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
