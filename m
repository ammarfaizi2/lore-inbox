Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSLCPIm>; Tue, 3 Dec 2002 10:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSLCPIm>; Tue, 3 Dec 2002 10:08:42 -0500
Received: from coruscant.franken.de ([193.174.159.226]:24453 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S261582AbSLCPIl>; Tue, 3 Dec 2002 10:08:41 -0500
Date: Thu, 28 Nov 2002 09:27:01 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc4 netfilter_ipv4 circular dependency
Message-ID: <20021128082700.GB7297@naboo.club.berlin.ccc.de>
References: <8832.1038373821@kao2.melbourne.sgi.com> <1038393296.14825.2.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <1038393296.14825.2.camel@rth.ninka.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux naboo 2.4.19-pre4-ben0
X-Date: Today is Boomtime, the 40th day of The Aftermath in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2002 at 02:34:56AM -0800, David S. Miller wrote:
> On Tue, 2002-11-26 at 21:10, Keith Owens wrote:
> > Warning on build of 2.4.20-rc4.
> >=20
> > Circular include/linux/netfilter_ipv4/ip_conntrack_helper.h <-
> > include/linux/netfilter_ipv4/ip_conntrack.h dependency dropped
>=20
> Keith, please report this to the proper place, as per
> MAINTAINERS that would be the netfilter lists.

thanks, david.

> They don't have time to read linux-kernel and it's only a common
> courtesy to at least CC: such reports there.

As long as the subject contains 'netfilter' or 'iptables', the mails
from linux-kernel get sorted into my personal inbox.  But
netfilter-devel is safer, indeed.

Expect a patch soon.

> Thanks.
--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M-=
=20
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE95dNUXaXGVTD0i/8RAouOAJ4gPOIaTzJ1a4b8xhnFsuy20C1mtQCffwHR
4hTscTk799IEuLhlXO/07oY=
=K7fP
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
