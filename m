Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273983AbRI0WUm>; Thu, 27 Sep 2001 18:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273977AbRI0WUc>; Thu, 27 Sep 2001 18:20:32 -0400
Received: from pscgate.progress.com ([192.77.186.1]:64652 "EHLO
	pscgate.progress.com") by vger.kernel.org with ESMTP
	id <S273986AbRI0WUP>; Thu, 27 Sep 2001 18:20:15 -0400
Subject: Broken APIC detection 2.4.10?
From: "Sujal Shah" <sshah@progress.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-xOM2Lg0rifpQsPhLg30s"
X-Mailer: Evolution/0.14.99+cvs.2001.09.27.08.08 (Preview Release)
Date: 27 Sep 2001 18:21:54 -0400
Message-Id: <1001629314.16742.76.camel@pcsshah>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xOM2Lg0rifpQsPhLg30s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


I just switched up to 2.4.10 on my Sony Vaio N505VX.  In the boot
messages, I see near the top:

Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!

/proc/interrupts shows XT-PIC for all the interrupts.  This was not the
case before.  Of course, I'm seeing other weirdness which is related
(the YMFPCI based sound card won't reset on reboot without shutting down
completely).

Anyone have any ideas why this is?  The APIC stuff was getting detected
fine in 2.4.7.

I'm going to try 2.4.9-ac16 soon (I was going to anyway), but that may
not happen for a few days. I'll post more if I figure out what
happened.  I'll also start backing down to 2.4.9 and will try that, too.

Thanks,

Sujal

--=20
---- Sujal Shah ---- PSC Labs (Progress Software) ----=20

Now Playing: The Crystal Method - Comin' Back

--=-xOM2Lg0rifpQsPhLg30s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7s6aCrdegDpOByoARAnlXAJ9po1lIs5ffy7QKmiF+zGW6xscj0QCeL+dS
krxR8zd3kqqRmL2s/FRnKmY=
=j1s5
-----END PGP SIGNATURE-----

--=-xOM2Lg0rifpQsPhLg30s--

