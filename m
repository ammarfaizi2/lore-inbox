Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285445AbRLGJdt>; Fri, 7 Dec 2001 04:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285448AbRLGJdj>; Fri, 7 Dec 2001 04:33:39 -0500
Received: from bb94-125.singnet.com.sg ([165.21.94.125]:53657 "HELO
	accellion.com") by vger.kernel.org with SMTP id <S285445AbRLGJde>;
	Fri, 7 Dec 2001 04:33:34 -0500
Date: Fri, 7 Dec 2001 17:33:26 +0800
From: Mathieu Legrand <mathieu@accellion.com>
To: linux-kernel@vger.kernel.org
Subject: Compaq Proliant DL360 + 2.4.1?-* eepro100 and e100 pause when inactive
Message-ID: <20011207093326.GA22128@accellion.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello:

We have here a Compaq Proliant DL360 server equiped with ethernet
controllers Intel 82557 Ethernet Pro 100 (rev 08).  It came
pre-installed with a old Redhat Linux and since I took it over, I
upgraded to a recent Debian GNU/Linux.

Debian installation sets a 2.2.19 kernel (compaq array enabled).  I
compiled a 2.4.14 (the latest at the time) plain Linux kernel.  Since
then, the ethernet controller seems to pause whenever it is not used.
Recovery time ranges from 10 to 15 sec :/.

I tried many > 2.4.14 kernels with both eepro100 and e100 drivers,
none solved the problem.  The kernel running this server is now
2.4.17-pre5 with cpqarray_2.4.20D_for_2.4.15-pre3 patch and e100 module.
The pause still occurs.

Others Compaq Proliant DL360 we own run Redhat Linux with a plain 2.4.4
(Linus' 2.4.4) using eepro100 driver, and the pause does not occur.  The
pause did not occur either with the 2.2.19 Debian install kernel.

How can I avoid this pause?  Does a specific kernel compilation option
can help?

I noticed eepro100 driver was upgraded soon after 2.4.4, is this
related?  Keeping the ethernet controller active at all time (pinging
continously the server) does help.  Delay before pause seems not to be
constant, I can abandon the ssh session to the server for hours without
having a pause when I return and it also happens to trigger a pause only
after a few minutes of inactivity.

Mathieu.
--=20
Mathieu Legrand <mathieu @ {accellion.com -work | globules.net -perso}>
GPG: 0x349EBC9961C501D1   fp: D6D2D2D74E6320D99B54 38F3349EBC9961C501D1
 - Yoda of Borg are we: Futile is resistance.  Assimilate you, we will.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8EIzmNJ68mWHFAdERAq/PAKC3m9xKRCqyLRa6AURskthRFX+rEACgxSG3
UCxDE9uufc973VbX1NmuPUI=
=+zpb
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
