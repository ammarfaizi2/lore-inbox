Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132472AbRAERvA>; Fri, 5 Jan 2001 12:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132458AbRAERuu>; Fri, 5 Jan 2001 12:50:50 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:4738 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S132135AbRAERuM>; Fri, 5 Jan 2001 12:50:12 -0500
Date: Fri, 5 Jan 2001 12:50:07 -0500
From: Pete Toscano <pete@research.netsol.com>
To: linux-kernel@vger.kernel.org
Subject: usb + smp + apollo pro 133a + 2.4.0 = still broken
Message-ID: <20010105125006.B1569@tesla.admin.cto.netsol.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 12:46pm  up  1:50,  4 users,  load average: 0.14, 0.09, 0.08
X-Married: 418 days, 17 hours, 1 minutes, and 21 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

just a heads up that usb in smp-enabled 2.4.0 kernels running on
machines with the via apollo pro 133a chipset is still broken.  the last
word i heard was that it's a pci irq routing problem.  smp and usb will
play together pretty nicely if you disable apic (ie. "noapic" to lilo).

i'm more than willing to help test patches and provide any more info to
people working on this, but i lack the low-level knowledge to actually
fix it.

thanks,
pete

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6VglOH/Abp5AIJzYRAh7nAKChZGz+WlI+CSEZIP+ON58X/mGBFQCgoKz/
TaXAelB+yKdCrDydOcXx0lU=
=fbs7
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
