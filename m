Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293012AbSB0WeZ>; Wed, 27 Feb 2002 17:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293016AbSB0WeI>; Wed, 27 Feb 2002 17:34:08 -0500
Received: from dhcp065-025-113-164.neo.rr.com ([65.25.113.164]:44798 "EHLO
	zahra") by vger.kernel.org with ESMTP id <S293013AbSB0WdG>;
	Wed, 27 Feb 2002 17:33:06 -0500
Date: Wed, 27 Feb 2002 17:33:02 -0500
From: James Cassidy <jcassidy@cs.kent.edu>
To: Tom Eastep <teastep@shorewall.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Northbridge Workaround in 2.4.18 Causing Video Problems
Message-ID: <20020227223301.GA632@qfire.net>
In-Reply-To: <20020226195730.BD7691B93C@mail.shorewall.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20020226195730.BD7691B93C@mail.shorewall.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2002 at 11:57:30AM -0800, Tom Eastep wrote:
> [2.] Full description of the problem/report:
>=20
> System is an Athlon 1.2GZ with VIA KT133 Northbridge and VT82C686 Southbr=
idge. This is a
> Compaq Presario with onboard S3 Savage Video that uses 8 or 16mb of syste=
m RAM as Video
> RAM. Prior to my installing 2.4.18, I have experienced none of the Athlon=
/VIA problems
> that have plagued other users (including the one addressed by the workaro=
und).
>=20
> With 2.4.18:

	Odd, I have had constant problems with crashes when ever I stressed
my memory system with Athlon kernel selected in the kernel config. Same
machine,  Compaq Presario 700 series. Usually a kernel compile was enough
to cause an opps on one of these kernels.=20
	When the path in 2.4.18 in pre1 or pre2 don't remember, it fixed the
problem on my Compaq Presario 700. I've been running the 2.4.18 series
since the patch was added and as of today I have not experienced another
opps of this kind with the Athlon option enabled in the kernel.

	I'll compile a 2.4.18 kernel without the patch tonight and see if I
can generated the crash again.

	I've never seen the VGA console go berserk, and I used it pretty
often.=20
	Although I have seen vesafb generate noise on the console, never looked
into it much, because it usually could easily be cleared. I've never noticed
any flicker in vesafb.

						-- James Cassidy (QFire)

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fV6dJanLLdMos+kRAtlwAKC1/c2KCcM99aUo7Y0OzQYPX8v+rQCeOiTi
HRwOYuTW5ag1EdwU1Ebi/6U=
=Q6X3
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
