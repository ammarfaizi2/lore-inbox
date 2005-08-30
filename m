Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVH3XMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVH3XMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVH3XMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:12:52 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:13245 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S932282AbVH3XMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:12:52 -0400
Date: Tue, 30 Aug 2005 16:13:08 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Daniel Phillips <phillips@istop.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Message-ID: <20050830231307.GE22068@insight.us.oracle.com>
Mail-Followup-To: Daniel Phillips <phillips@istop.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Greg KH <greg@kroah.com>
References: <200508310854.40482.phillips@istop.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline
In-Reply-To: <200508310854.40482.phillips@istop.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 31, 2005 at 08:54:39AM +1000, Daniel Phillips wrote:
> But it would be stupid to forbid users from creating directories in sysfs=
 or=20
> to forbid kernel modules from directly tweaking a configfs namespace.  Wh=
y=20
> should the kernel not be able to add objects to a directory a user create=
d? =20
> It should be up to the module author to decide these things.

	This is precisely why configfs is separate from sysfs.  If both
user and kernel can create objects, the lifetime of the object and its
filesystem representation is very complex.  Sysfs already has problems
with people getting this wrong.  configfs does not.
	The fact that sysfs and configfs have similar backing stores
does not make them the same thing.

Joel

--=20

"Against stupidity the Gods themselves contend in vain."
	- Freidrich von Schiller

			http://www.jlbec.org/
			jlbec@evilplan.org

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDFOgDiHQK5rbv+hERAtzUAJ4wMwhSw7AbvpPrnrZ96lFmJkFHIgCcDWlg
3oaRr9xVr43+xEgxt8hIrRY=
=OGG3
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--
