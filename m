Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278555AbRJXPFX>; Wed, 24 Oct 2001 11:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278550AbRJXPFF>; Wed, 24 Oct 2001 11:05:05 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:89 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278549AbRJXPE7>; Wed, 24 Oct 2001 11:04:59 -0400
Date: Wed, 24 Oct 2001 16:05:33 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Dave Garry <daveg@firsdown.demon.co.uk>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.12 / linux-2.4.13 parallel port problem
Message-ID: <20011024160533.R7544@redhat.com>
In-Reply-To: <3BD6BF43.D347719B@firsdown.demon.co.uk> <20011024143601.M7544@redhat.com> <3BD6D7E8.BDC1AB2B@firsdown.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ZFWKH0K7XiCjBLDd"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD6D7E8.BDC1AB2B@firsdown.demon.co.uk>; from daveg@firsdown.demon.co.uk on Wed, Oct 24, 2001 at 04:02:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZFWKH0K7XiCjBLDd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2001 at 04:02:00PM +0100, Dave Garry wrote:

> Thanks for the tip, but it's not helping. I've tried
> "irq=3Dauto" and "irq=3D7" but it still wont play.
>=20
> I just noticed that CONFIG_PARPORT_PC_FIFO is set to NO
> and I'm rebuilding with it set to YES to see if that
> helps...

Yes, you need that enabled or it won't even have the code for using
the FIFO compiled in.

> This option was also off when I was using 2.4.10 so
> I'm not sure if it will help.

But 2.4.10 still had the bug that advertised modes that it wouldn't
use.

Tim.
*/

--ZFWKH0K7XiCjBLDd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE71ti9yaXy9qA00+cRAqXpAJ9OQ4CLhM6SV6LbHhYWxfcNvNy0AQCgpGQp
zoQIc9EUV/BmcUlg19jDDnI=
=B4tK
-----END PGP SIGNATURE-----

--ZFWKH0K7XiCjBLDd--
