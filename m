Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132135AbQLRNm2>; Mon, 18 Dec 2000 08:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132207AbQLRNmS>; Mon, 18 Dec 2000 08:42:18 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:4104 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S132135AbQLRNmE>; Mon, 18 Dec 2000 08:42:04 -0500
Date: Mon, 18 Dec 2000 14:11:36 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: set_rtc_mmss: can't update from 0 to 59
Message-ID: <20001218141136.B15549@krusty.e-technik.uni-dortmund.de>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.kernel.org>
In-Reply-To: <20001217123237.B11947@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001217123237.B11947@one-eyed-alien.net>; from mdharm-kernel@one-eyed-alien.net on Sun, Dec 17, 2000 at 12:32:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 17 Dec 2000, Matthew Dharm wrote:

> I was trying to figure out why I periodically get the message=20
>=20
> set_rtc_mmss: can't update from 0 to 59
>=20
> on my console.  It appears that the kernel is attempting to update my CMOS
> clock for me, based on the more accurate data being provided by my xntpd.
>=20
> According to the notes in the code, this should work if my RTC is less th=
an
> 15 minutes off... which I can guarantee it is.  Accoring to hwclock, it's
> less than a second off.
>=20
> So, what's causing this message?

Check the power supply cabling, I had those messages due to a faulty
contact on a Tyan S1590, after fixing the P8 and P9 (AT-style) power
plugs, those messages were gone.

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iQDVAwUBOj4NCINSvXixLRLzAQHmpwYAsJDXUcRsM0893kWYXIJn/J5xrCulbT2H
Jjn541DePeJ2AiXhEcJGwmxX4qVm5oCvEBs6S5Q3sVMclX29IRBk6nizwefVtIBF
S1dOgQ6sK8zUNLGzOxTswlHQiUbS9ACkHQ/qEKneNxNtjq8ZcbGN8+T78n36qLDU
rOo4PENmP0tp8K7dxZdMitfJrMJtSyqnlTtjjbWBgq0y6nFSX85qZmhehWeub1QR
IDXOafAEvQGMjxe0WAWtu+dQfs8Ctr6k
=BnF8
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
