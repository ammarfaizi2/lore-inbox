Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTFYPZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTFYPZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:25:45 -0400
Received: from grendel.firewall.com ([66.28.56.41]:35736 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S264559AbTFYPZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:25:44 -0400
Date: Wed, 25 Jun 2003 17:39:43 +0200
From: Marek Habersack <grendel@debian.org>
To: Christoph Hellwig <hch@infradead.org>, Steve Lord <lord@sgi.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
Message-ID: <20030625153943.GJ1745@thanes.org>
Reply-To: grendel@debian.org
References: <20030625095126.GD1745@thanes.org> <1056545505.1170.19.camel@laptop.americas.sgi.com> <20030625134129.GG1745@thanes.org> <1056551143.5779.0.camel@laptop.fenrus.com> <20030625153545.A16074@infradead.org> <1056553902.1416.61.camel@laptop.americas.sgi.com> <20030625161627.A20049@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline
In-Reply-To: <20030625161627.A20049@infradead.org>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2003 at 04:16:27PM +0100, Christoph Hellwig scribbled:
[snip]
> > at Irix and confirm this. Imposing different semantics on the rest of
> > the filesystems did not seem like the right thing to do.
>=20
> Actually there's a posix option group for finding out exactly that,
> (see http://people.redhat.com/drepper/posix-option-groups.html#CHOWN_REST=
RICTED)
> but yeah it might be more of a legacy thing.
>=20
> Adding a common sysctl for this would allow glibc to properly implement
> patchconf(..., _PC_CHOWN_RESTRICTED), but it seems SuSv2/3 sais it must
> be always defined:
>=20
> http://www.opengroup.org/onlinepubs/007908799/xsh/chown.html
This being clear, maybe it should be a compile-time option in XFS? Or
would that be unacceptable?

marek

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++cI/q3909GIf5uoRAgzVAJ98btK2JPKyHIIn8GqfHvXTCUZYOACfdHEV
NMeGov/h5IOA05fJbMl9iMQ=
=S36X
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
