Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132693AbRDKR6I>; Wed, 11 Apr 2001 13:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRDKR54>; Wed, 11 Apr 2001 13:57:56 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:23168 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S132689AbRDKR5r>; Wed, 11 Apr 2001 13:57:47 -0400
Date: Wed, 11 Apr 2001 12:57:31 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Peter Rival <frival@zk3.dec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alpha "process table hang"
Message-ID: <20010411125731.B6472@draal.physics.wisc.edu>
In-Reply-To: <20010411104040.A8773@draal.physics.wisc.edu> <3AD489D1.D5FCCB4B@zk3.dec.com> <20010411120044.A6472@draal.physics.wisc.edu> <3AD491C9.6424D932@zk3.dec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AD491C9.6424D932@zk3.dec.com>; from frival@zk3.dec.com on Wed, Apr 11, 2001 at 01:18:01PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Peter Rival [frival@zk3.dec.com] wrote:
> Hmpf.  Haven't seen this at all on any of the Alphas that I'm running.  W=
hat
> exact system are you seeing this on, and what are you running when it hap=
pens?

This is a LX164 system, 533 MHz.

I have a hunch it's related to the X server because I've seen it many,
many times while sitting at the console (in X), but never when I'm
logged on remotely.  I've seen it with both XFree86 3.3.6, 4.0.2, 4.0.3,
Matrox Millenium II video card, 8MB.

I'm also experiencing regular X crashes, but the process-table-hang
doesn't occur at the same time as an X crash (or v/v).  I sent a patch
to xfree86@xfree86.org a few days ago that seemed to fix (one of) the X
crashes (in the mga driver, ask if you want details).

(But since the X server shouldn't have the ability to corrupt the
kernel's process list, there has to be a problem in the kernel
somewhere)

Note that this system was completely stable with 2.2 kernels.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrUmwsACgkQjwioWRGe9K1ZswCg8/xXgdHnE1KC8tYUp7dOTG7U
KyoAn0Obk0zpAZ39P6Qggb2xO8m3l2/u
=6agq
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
