Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275424AbRJNPF5>; Sun, 14 Oct 2001 11:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275511AbRJNPFr>; Sun, 14 Oct 2001 11:05:47 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:50342 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S275424AbRJNPFg>; Sun, 14 Oct 2001 11:05:36 -0400
Date: Sun, 14 Oct 2001 10:06:03 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reg-porting guide (fwd)
Message-ID: <20011014100603.T1177@draal.physics.wisc.edu>
In-Reply-To: <Pine.LNX.4.10.10110141319060.14935-100000@blrmail>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gIHggtDV96iaw8wO"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10110141319060.14935-100000@blrmail>; from sathish.j@tatainfotech.com on Sun, Oct 14, 2001 at 01:19:16PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gIHggtDV96iaw8wO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

SATHISH.J [sathish.j@tatainfotech.com] wrote:
> Hi,
> I want to port an application from linux 32 bit to 64 bit. Where can I get
> details on the same? Is there any porting guide for this? Please send me
> the link.=20

99% of the time, (32-bit) linux applications will compile and run fine on my
alpha.  There are 3 potential problems though:
    1) sizeof(long) !=3D sizeof(int)
    2) any assembly language in the source.
    3) sizeof(void*) !=3D sizeof(int)
The first two can be readily identified by grepping for "long", "asm" and
looking for .s files.  The last one causes compiler warnings, but does not
usually cause the application to fail to compile or run.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--gIHggtDV96iaw8wO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvJqdsACgkQjwioWRGe9K2RxQCffKYWVjU3YUi5B16K3GMQqB1h
zWcAniADN+2CUaWmKVLYbwN0rQxzj7lr
=uzID
-----END PGP SIGNATURE-----

--gIHggtDV96iaw8wO--
