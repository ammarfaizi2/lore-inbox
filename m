Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130187AbRCLT6o>; Mon, 12 Mar 2001 14:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRCLT6e>; Mon, 12 Mar 2001 14:58:34 -0500
Received: from mx2.magma.ca ([206.191.0.250]:36569 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id <S130187AbRCLT6R>;
	Mon, 12 Mar 2001 14:58:17 -0500
Date: Mon, 12 Mar 2001 14:57:49 -0500
From: Martin Hicks <mort@bork.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4 and PPPoE problem
Message-ID: <20010312145749.A8645@plato.bork.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm using PPPoE with an i586 machine running 2.4.2.

The machine connects fine and allows network traffic to pass
through the link.

However, certain websites seem to choke.
(notable ones are www.chapters.ca and www.hp.com)

Using Lynx or Netscape I get the same results, a few bytes of
traffic are received and then nothing (eventually the connection
times out). =20

The same does not happen in windows.  (ugh)

I have not encountered any machine that I have telnet/ftp/ssh
access to that breaks in this way so I can only confirm that http traffic=
=20
is not working.

This gateway machine does masquerading, and internal machines and the exter=
nal
machine react the same way.

TIA
mh


Here is some useful info:

mort@galileo:~$ uname -a
Linux galileo 2.4.2 #4 Thu Feb 22 14:13:23 EST 2001 i586 unknown

mort@galileo:~$ /sbin/ifconfig ppp0
ppp0      Link encap:Point-to-Point Protocol =20
          inet addr:209.217.122.37  P-t-P:209.217.122.1  Mask:255.255.255.2=
55
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1480  Metric:1
          RX packets:1272056 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1476697 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3=20
          RX bytes:430171737 (410.2 Mb)  TX bytes:1260803415 (1202.3 Mb)


mort@galileo:~$ /sbin/route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Ifa=
ce
magma           *               255.255.255.255 UH    0      0        0 ppp0
192.168.69.0    *               255.255.255.0   U     0      0        0 eth0
default         magma           0.0.0.0         UG    0      0        0 ppp0




--=20
Martin Hicks   || mort@bork.org   =20
Use PGP/GnuPG  || DSS PGP Key: 0x4C7F2BEE =20
Beer: So much more than just a breakfast drink.

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6rSo90ZUZrUx/K+4RAsF2AKC3bmBDJaVB7WHfcDT/cd0wofn+oACfWdgv
GiUJY9z45Wb5fs/g2vgchyQ=
=WPKL
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
