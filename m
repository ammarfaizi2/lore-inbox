Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261722AbREUHI6>; Mon, 21 May 2001 03:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbREUHIs>; Mon, 21 May 2001 03:08:48 -0400
Received: from lenka.ph.ipex.cz ([212.71.128.11]:60968 "EHLO lenka.ph.ipex.cz")
	by vger.kernel.org with ESMTP id <S261722AbREUHIi>;
	Mon, 21 May 2001 03:08:38 -0400
Date: Mon, 21 May 2001 09:09:46 +0200
From: Robert Vojta <vojta@ipex.cz>
To: linux-kernel@vger.kernel.org
Subject: 3c905C-TX [Fast Etherlink] problem ...
Message-ID: <20010521090946.D769@ipex.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Telephone: +420 603 167 911
X-Company: IPEX, s.r.o.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
  I have this card in intranet server and I'm very confused about very often
message in log like this:

eth0: Transmit error, Tx status register 82.
  Flags; bus-master 1, dirty 20979238(6) current 20979242(10)
  Transmit list 1f659290 vs. df659260.
  0: @df659200  length 800005ea status 000105ea
  1: @df659210  length 80000296 status 00010296
  2: @df659220  length 800005ea status 000105ea
  3: @df659230  length 80000296 status 00010296
  4: @df659240  length 800005ea status 000105ea
  5: @df659250  length 800005ea status 000105ea
  6: @df659260  length 800005ea status 000105ea
  7: @df659270  length 800005ea status 000105ea
  8: @df659280  length 800005ea status 000105ea
  9: @df659290  length 800005ea status 800005ea
  10: @df6592a0  length 80000056 status 00010056
  11: @df6592b0  length 8000005a status 0001005a
  12: @df6592c0  length 800005ea status 000105ea
  13: @df6592d0  length 80000296 status 00010296
  14: @df6592e0  length 800005ea status 000105ea
  15: @df6592f0  length 8000029a status 0001029a

  We have diskless machines and this is not a good thing, because when this
happens all traffic is stopped, all diskless machines are waiting and users
can't do nothing for several seconds (2-3 seconds). It's not critical, but
it's not comfortable. I tried another card, tried kernels 2.2.16, 2.2.19,
2.4.x series, change cable and still this problem. Any idea what may I do?

  .R.V.

Card is 00:12.0 Ethernet controller: 3Com Corporation 3c905C-TX
	[Fast Etherlink] (rev 74)

--=20
   _
  |-|  __      Robert Vojta <vojta-at-ipex.cz>          -=3D Oo.oO =3D-
  |=3D| [Ll]     IPEX, s.r.o.
  "^" =3D=3D=3D=3D`o

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjsIvzoACgkQInNB3KDLeVMHCgCaA1gkw5+1KRCXG7vfsphHxoh+
BBkAnAmfdwdVxOHrFJMoVlOW20cLr2Ev
=2Ysy
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
