Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTK3I7U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 03:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTK3I7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 03:59:20 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:20352 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262280AbTK3I7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 03:59:07 -0500
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Clausen <clausen@gnu.org>
Cc: John Bradford <john@grabjohn.com>, Andries Brouwer <aebr@win.tue.nl>,
       Szakacsits Szabolcs <szaka@sienet.hu>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
In-Reply-To: <20031129223103.GB505@gnu.org>
References: <20031128045854.GA1353@home.woodlands>
	 <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org>
	 <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
	 <20031129123451.GA5372@win.tue.nl>
	 <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
	 <20031129223103.GB505@gnu.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+8BTWesL3HCVRtpJbSVZ"
Organization: Red Hat, Inc.
Message-Id: <1070182676.5214.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 30 Nov 2003 09:57:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+8BTWesL3HCVRtpJbSVZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-11-29 at 23:31, Andrew Clausen wrote:
> On Sat, Nov 29, 2003 at 01:50:00PM +0000, John Bradford wrote:
> > Why don't we take the opporunity to make all CHS code configurable out
> > of the kernel, and define a new, more compact, partition table format
> > which used LBA exclusively, and allowed more than four partitions in
> > the main partition table?
>=20
> Intel's EFI GPT partition table format seems quite acceptable.

EFI GPT has some severe downsides (like requiring the last sector on
disk, which in linux may not be accessible if the total number of
sectors is not a multiple of 2, and making dd of one disk to another
impossible if the second one is bigger)


--=-+8BTWesL3HCVRtpJbSVZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/ybEUxULwo51rQBIRAs73AKCVgCTSiujCgnQBocOsiyronOXVEgCgmgTx
cv9yhia5EE8CkRZif33wcLk=
=ErpM
-----END PGP SIGNATURE-----

--=-+8BTWesL3HCVRtpJbSVZ--
