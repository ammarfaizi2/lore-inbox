Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTFRLIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 07:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTFRLIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 07:08:54 -0400
Received: from host81-134-138-64.in-addr.btopenworld.com ([81.134.138.64]:30083
	"HELO factotum.office.bytemark.co.uk") by vger.kernel.org with SMTP
	id S265152AbTFRLIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 07:08:51 -0400
From: Pete Taphouse <pete@bytemark.co.uk>
To: linux-kernel@vger.kernel.org
Subject: ptrace/kmod exploit still works in 2.4.21?
Date: Wed, 18 Jun 2003 12:22:04 +0100
User-Agent: KMail/1.5.2
Organization: Bytemark Computer Consulting Ltd
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_jtE8+1f2PlSaype";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200306181222.11691.pete@bytemark.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_jtE8+1f2PlSaype
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi,

I've been doing some experiments with the 2.4.21 kernel, and the ptrace=20
exploit: the result of which is that I've compiled a kernel with the=20
processor set to i386.  I then ran this kernel on 2 computers, one is a Dur=
on=20
machine with SIS chipset, the other is a Pentium 4 machine with the Intel 8=
45=20
chipset. The exploit still gave me a root shell on the Pentium 4 machine, b=
ut=20
didn't on the Duron one.

I've read the previous post about this, and in both cases I only logged in =
as=20
an unprivileged user.  I didn't login as root and then su to an unprivilege=
d=20
use first. I checked to see that I was root by opening /etc/shadow.

The exploit used was:
http://packetstormsecurity.nl/0304-exploits/ptrace-kmod.c

The config file for the kernel I compiled is at:
http://www.bytemark-hosting.co.uk/config.txt

Any ideas?

=2D-=20
Peter Taphouse

Bytemark Hosting
http://www.bytemark-hosting.co.uk
tel. +44 (0) 8707 455 026

--Boundary-02=_jtE8+1f2PlSaype
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+8EtjIAZ7OKeBB58RAoLWAJ0UaxABVxCF8hr+zHZEtdgWPIRLGQCfVchC
vjgguI5GCGo6iIUqxY1HGfU=
=hcxZ
-----END PGP SIGNATURE-----

--Boundary-02=_jtE8+1f2PlSaype--

