Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUEFMW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUEFMW4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUEFMW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:22:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18908 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262052AbUEFMWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:22:41 -0400
Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Matthew Wilcox <willy@debian.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sourav Sen <souravs@india.hp.com>,
       Matt_Domsch@dell.com, matthew.e.tolentino@intel.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040506115919.GZ2281@parcelfarce.linux.theplanet.co.uk>
References: <003801c43347$812a1590$39624c0f@india.hp.com>
	 <20040506114414.A14543@infradead.org>
	 <20040506115919.GZ2281@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DWk91SIcPBHtFP7OtNPg"
Organization: Red Hat UK
Message-Id: <1083845904.3844.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 06 May 2004 14:18:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DWk91SIcPBHtFP7OtNPg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-05-06 at 13:59, Matthew Wilcox wrote:
> On Thu, May 06, 2004 at 11:44:14AM +0100, Christoph Hellwig wrote:
> > On Thu, May 06, 2004 at 02:22:46PM +0530, Sourav Sen wrote:
> > > Hi,
> > >=20
> > > The following simple patch creates a read-only file
> > > "memmap" under <mount point>/firmware/efi/ in sysfs
> > > and exposes the efi memory map thru it.
> >=20
> > doesn't exactly fit into the one value per file approach, does it?
>=20
> It's not exactly modifiable.=20

come on, it's the ideal hotplug memory interface ;)
should we try to unify the memory map exports between architectures
instead of matching the firmware-of-the-day for each architecture ??


--=-DWk91SIcPBHtFP7OtNPg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAmi0PxULwo51rQBIRAqbCAJ9C12H6pTCO+gt2IxF+DJ+LZj3NywCgnLdO
fDAMqM95/kUeLPXyqUYb97Y=
=EC3X
-----END PGP SIGNATURE-----

--=-DWk91SIcPBHtFP7OtNPg--

