Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291248AbSBHAuZ>; Thu, 7 Feb 2002 19:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291274AbSBHAuO>; Thu, 7 Feb 2002 19:50:14 -0500
Received: from modemcable192.234-203-24.hull.mc.videotron.ca ([24.203.234.192]:27909
	"EHLO Krystal") by vger.kernel.org with ESMTP id <S291248AbSBHAt7>;
	Thu, 7 Feb 2002 19:49:59 -0500
Date: Thu, 7 Feb 2002 19:49:54 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Promise PDC20268 spurious interrupt
Message-ID: <20020208004954.GA19421@Krystal>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-20181-1013129395-0001-2"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.2.20 (i586)
X-Uptime: 19:42:36 up 9 days,  9:49,  2 users,  load average: 0.49, 0.33, 0.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-20181-1013129395-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a problem here since I plugged my second hard disk on my Promise
Ultra 100 TX2 PDC20268 controller. It occurs all the time when I use softwa=
re
raid 0. I looked at the LKML archives, and this problem does not seems to be
solved. There is a simpler way to generate the problem than to use raid.

It occurs when I use dd for reading on my both hard disks in parallel.
The disks are both masters of their channel.

When I do this test, The message I get is=20

spurious 8259A interrupt: IRQ7.
spurious 8259A interrupt: IRQ15.

And I can look at /proc/interrupts and see the ERR counter increment at
a phenomenal speed.

I wonder if this problem is due to the linux driver support or if it is
a hardware bug.


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-20181-1013129395-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8YyCxPyWo/juummgRAg/fAJ99+sekpIWuBUaPBNIAFDEEfbHsXwCfbNBn
90KydsH/MRpho0kpXjsJHMU=
=Q2mM
-----END PGP SIGNATURE-----

--=_Krystal-20181-1013129395-0001-2--
