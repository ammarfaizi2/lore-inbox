Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272495AbTHKKZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 06:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272494AbTHKKZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 06:25:59 -0400
Received: from coruscant.franken.de ([193.174.159.226]:43668 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272495AbTHKKZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 06:25:57 -0400
Date: Mon, 11 Aug 2003 12:21:01 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Christoph Hellwig <hch@infradead.org>, sal@agora.pl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.18/2.4.20 filemap.c pmd bug (was Re: Problem with mm in 2.4.19 and 2.4.20)
Message-ID: <20030811102101.GG8953@sunbeam.de.gnumonks.org>
References: <20030208121633.GB17017@virgin.gazeta.pl> <20030811073443.GA8953@sunbeam.de.gnumonks.org> <20030811104823.A15144@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Content-Disposition: inline
In-Reply-To: <20030811104823.A15144@infradead.org>
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Pungenday, the 4th day of Bureaucracy in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christian.  First of all, thanks for your quick reply.

On Mon, Aug 11, 2003 at 10:48:23AM +0100, Christoph Hellwig wrote:
=20
> Well, qlogic + lvm is vert prone of stack overflows. =20

In my case, we use neither of them.

> You're using aic7xxx I assume? =20

yes.  The device is reported as

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=3D7, 32/253 SCBs


> Some other interesting drivers?

Well, there's a tulip based network board and one symbios SCSI controller
(ncr53c8xx driver) in the system.  But since the '(scsi0:A:9:0): Locking
max tag count at 64' message always indicates 'scsi0', I think it has to
do with aic7xxx.

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/N24NXaXGVTD0i/8RAibUAJwJVMSkGH2cAGSskZdftjk30xVnIgCgojwD
YGQTo1uukz3aDwCUHT1DNVw=
=MDoy
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--
