Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUI0S1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUI0S1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUI0S1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:27:20 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:14858 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S266910AbUI0S1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:27:14 -0400
Subject: Re: [PATCH] __VMALLOC_RESERVE export
From: Antony Suter <suterant@users.sourceforge.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: List LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
In-Reply-To: <20040927181229.A25704@infradead.org>
References: <1096304623.9430.8.camel@hikaru.lan>
	 <20040927181229.A25704@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-W2Mh46ObWVOAjaytFUq5"
Message-Id: <1096309603.9430.17.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 04:26:43 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W2Mh46ObWVOAjaytFUq5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-28 at 03:12, Christoph Hellwig wrote:
> On Tue, Sep 28, 2004 at 03:03:43AM +1000, Antony Suter wrote:
> > __VMALLOC_RESERVE itself is not exported but is used by something that
> > is. This patch is against 2.6.9-rc2-bk11
> >=20
> > This is required by the nvidia binary driver 1.0.6111
>=20
> And the driver does absolutely nasty things it shouldn't do.  This is an
> implementation detail that absolutely should not be exported.

However __VMALLOC_RESERVE, specific to arch-i386 is now used by the
macro MAXMEM. MAXMEM is _not_ specific to arch-i386. The nvidia driver
has a kernel module that uses the macro MAXMEM. Is it wrong for a kernel
module to use MAXMEM?

--=20
- Antony Suter  (suterant users sourceforge net)  "Bonta"
- "Facts do not cease to exist because they are ignored." - Aldous Huxley

--=-W2Mh46ObWVOAjaytFUq5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBWFtjZu6XKGV+xxoRAuHoAKCB5fcymeLLXSktOdD93fgWnxuUrgCgnRup
p4I2dmzdg982KRwmi3hYzQQ=
=dmkz
-----END PGP SIGNATURE-----

--=-W2Mh46ObWVOAjaytFUq5--

