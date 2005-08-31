Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVHaADD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVHaADD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 20:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVHaADD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 20:03:03 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:28382 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S932292AbVHaADC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 20:03:02 -0400
Date: Tue, 30 Aug 2005 17:03:16 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: phillips@istop.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Message-ID: <20050831000316.GF22068@insight.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <200508310854.40482.phillips@istop.com> <20050830231307.GE22068@insight.us.oracle.com> <20050830162846.5f6d0a53.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline
In-Reply-To: <20050830162846.5f6d0a53.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2005 at 04:28:46PM -0700, Andrew Morton wrote:
> Joel Becker <Joel.Becker@oracle.com> wrote:
> > 	The fact that sysfs and configfs have similar backing stores
> > does not make them the same thing.
> >=20
>=20
> Sure, but all that copying-and-pasting really sucks.  I'm sure there's so=
me
> way of providing the slightly different semantics from the same codebase?

	The way that configfs and sysfs create/destroy dentries and
their associated inodes is very different from the top, yet similar from
the bottom.  I suspect that some of it could be libraryized.  When I
first looked started configfs, I was starting from an "add on to sysfs"
perspective, after all.  The sysfs maintainers and I agreed, after much
discussion, that we should go to a separate tree.

Joel

--=20

"Here's a nickle -- get yourself a better X server."
	- Keith Packard

			http://www.jlbec.org/
			jlbec@evilplan.org

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDFPPEiHQK5rbv+hERAgndAJ90kjtDndxAiytCsab0Q4ygh2UhGQCfUe8w
TE0wtlMOozibaTNCgswPOeU=
=JOEg
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
