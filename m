Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272358AbTHNM5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272359AbTHNM5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:57:53 -0400
Received: from mail.donpac.ru ([217.107.128.190]:1750 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S272358AbTHNM5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:57:51 -0400
Date: Thu, 14 Aug 2003 16:57:18 +0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <willy@debian.org>,
       Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@redhat.com>, rddunlap@osdl.org,
       davej@redhat.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030814125718.GB7457@pazke>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <willy@debian.org>,
	Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@redhat.com>, rddunlap@osdl.org,
	davej@redhat.com,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	kernel-janitor-discuss@lists.sourceforge.net
References: <3F3A9FA1.8000708@pobox.com> <Pine.GSO.4.21.0308141202410.12289-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0308141202410.12289-100000@vervain.sonytel.be>
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -11.7 (-----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 226, 08 14, 2003 at 12:05:28PM +0200, Geert Uytterhoeven wrote:
> On Wed, 13 Aug 2003, Jeff Garzik wrote:
> > > On Wed, Aug 13, 2003 at 03:44:44PM -0400, Jeff Garzik wrote:
> > >>enums are easy  putting direct references would be annoying, but I al=
so=20
> > >>argue it's potentially broken and wrong to store and export that=20
> > >>information publicly anyway.  The use of enums instead of pointers is=
=20
> > >>practically required because there is a many-to-one relationship of i=
ds=20
> > >>to board information structs.
> > >=20
> > > The hard part is that it's actually many-to-many.  The same card can =
have
> > > multiple drivers.  one driver can support many cards.
> >=20
> > pci_device_tables are (and must be) at per-driver granularity.  Sure th=
e=20
> > same card can have multiple drivers, but that doesn't really matter in=
=20
> > this context, simply because I/we cannot break that per-driver=20
> > granularity.  Any solution must maintain per-driver granularity.
>=20
> Aren't there any `hidden multi-function in single-function' PCI devices o=
ut
> there? E.g. cards with a serial and a parallel port?
=20
Look at drivers/parport/parport-serial.c, it contains whole zoo of such bea=
sts :)

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/O4cuby9O0+A2ZecRAgTCAJ0Z9X+zWsOXfYiw5/QhQsoTKE8SfgCgi1Cq
/UCE38XeWmCLOa/+0wOs4aM=
=cQ+c
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
