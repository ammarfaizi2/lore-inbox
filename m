Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265931AbUGIUEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUGIUEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUGIUDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:03:46 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:48086 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S265931AbUGIUDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:03:12 -0400
Date: Fri, 9 Jul 2004 22:03:07 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       Frank Pavlic <pavlic@de.ibm.com>, Thomas Spatzier <tspat@de.ibm.com>
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
Message-ID: <20040709200307.GC11138@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	Christian Borntraeger <linux-kernel@borntraeger.net>,
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
	Frank Pavlic <pavlic@de.ibm.com>, Thomas Spatzier <tspat@de.ibm.com>
References: <20040709140630.GA27350@wavehammer.waldi.eu.org> <20040709192253.GA11138@wavehammer.waldi.eu.org> <20040709123005.086fdfc5.davem@redhat.com> <200407092150.22868.linux-kernel@borntraeger.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <200407092150.22868.linux-kernel@borntraeger.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 09, 2004 at 09:50:22PM +0200, Christian Borntraeger wrote:
> David S. Miller wrote:
> > Put it in the inet6device private area.

struct net_device defines a void pointer named ip6_ptr. This clearly
defines that as opaque data. There is no other ipv6 specific field.

A simple solution will be adding a pointer to a public struct with ipv6
specific things.

> > It's been a year, and you haven't put forth the effort to look
> > for solutions like that?
>=20
> I think its sensible to add the driver authors to cc. Hopefully we can ag=
ree=20
> on a nice solution.

I hope so.

Bastian

--=20
Only a fool fights in a burning house.
		-- Kank the Klingon, "Day of the Dove", stardate unknown

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iEYEARECAAYFAkDu+fsACgkQnw66O/MvCNHkbwCgi8/V+lto9oQBg7TCxARcB1z/
ExcAn1eqPGoTzmfnY7vXZmZL1pkcle8X
=EDxY
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
