Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269433AbRHCQEa>; Fri, 3 Aug 2001 12:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269434AbRHCQEU>; Fri, 3 Aug 2001 12:04:20 -0400
Received: from h24-76-184-93.vs.shawcable.net ([24.76.184.93]:33962 "HELO
	md5.ca") by vger.kernel.org with SMTP id <S269433AbRHCQEJ>;
	Fri, 3 Aug 2001 12:04:09 -0400
Date: Fri, 3 Aug 2001 09:04:02 -0700
From: Pavel Zaitsev <pavel@md5.ca>
To: linux-kernel@vger.kernel.org
Subject: df hangs after hung mount
Message-ID: <20010803090402.A3649@md5.ca>
Reply-To: pavel@md5.ca
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-Arbitrary-Number-Of-The-Day: 42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I sometimes try to mount a CDROM drive, and mount hangs hard, in 'D' state =
 as specified in
ps listing. Sometimes I do df, and that hangs as well. kill -9 doesn't work=
 on those proggies.
That is with 2.4.3 and 2.4.7 kernels. Shouldn't they fail if cdrom is dysfu=
nctional?
thx,
p.

[pavel@calgary pavel]$ lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (r=
ev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev=
 03)
00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (r=
ev 30)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/=
2X (rev 5c)

--=20
Take out your recursive cannons and shoot!
110461387
http://gpg.md5.ca
http://perlpimp.com

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7astyEhbFhd1U3E0RAli3AJ9wFlHRhST1UjA1qsHJBhWF8KLMygCfVJae
+3RXy7CyuF0nIyifRG1JLrU=
=S4xp
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
