Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbTDPEaM (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 00:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbTDPEaM 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 00:30:12 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:17167 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S264225AbTDPEaK (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 00:30:10 -0400
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Wed, 16 Apr 2003 00:41:48 -0400
To: Florin Iucha <florin@iucha.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030416044144.GA32400@rivenstone.net>
Mail-Followup-To: Florin Iucha <florin@iucha.net>,
	linux-kernel@vger.kernel.org
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20030415182057.GC29143@iucha.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2003 at 01:20:57PM -0500, Florin Iucha wrote:
> On Tue, Apr 15, 2003 at 12:44:40PM -0400, Joseph Fannin wrote:
> > On Tue, Apr 15, 2003 at 03:06:37PM +0200, Alessandro Suardi wrote:
> > <snip>
> > > I surely hit bug 543 in 2.5.65 IIRC, and guess what...
> > >  ATI Radeon 7500 Mobile - XFree 4.2.1
> > >=20
> > > According to other emails on lkml, it appears that DRM and/or AGP
> > >  new kernel code might be at fault. I don't actually remember
> > >  seeing non-Radeon cards being hit by such problems though...
> >=20
> >     I've seen this problem too many times, but haven't tried to track
> > it down.  The video is ATI Rage 128 Pro.
> >=20
> >     A common bit seems to be ATI cards, judging from this thread.  I'm
> > also using the aty128fb framebuffer driver.  My motherboard is Aladdin V
> > based and so uses the ali-agp module.
>=20
> I think it has to do with the interaction between XFree86 4.3.0 and
> the AGP code.
>=20
> I have wdm as my display manager. I am able to login, but when logging
> out the system dies. These are the last two messages printed on the
> serial console:
>    agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
>    agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
> and then, hard freeze.
>=20
> These lines do not appear when using XFree86 4.2.1 .
>=20
> I have a Radeon 8500 and AGP 4x is enabled in BIOS. The motherboard is
> ECS K7S5A (SIS 735 chipset).

    Except that I'm seeing the very same sort of freeze on with a
 Rage128 card with XFree86 4.2.1.

    Are we all Debian sid users, perhaps?

    Or maybe the Rage128 needs a similar patch to the Radeon one you
posted.


--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nN8IWv4KsgKfSVgRAnT6AJ9+fVYtNK0HxPgIH0xq6QnN4g9FGQCePyu/
Cgg77B6RjOwfIbSwEZ7lYSs=
=LYBA
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
