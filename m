Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265246AbUFHQAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUFHQAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 12:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbUFHQAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 12:00:49 -0400
Received: from lists.us.dell.com ([143.166.224.162]:18071 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265246AbUFHQAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 12:00:44 -0400
Date: Tue, 8 Jun 2004 11:00:27 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: intel-agp: skip non-AGP devices
Message-ID: <20040608160027.GA13214@lists.us.dell.com>
References: <20040601160457.GA11437@lists.us.dell.com> <20040601162058.GA20983@infradead.org> <20040601163100.GC1265@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20040601163100.GC1265@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2004 at 05:31:00PM +0100, Dave Jones wrote:
> On Tue, Jun 01, 2004 at 05:20:58PM +0100, Christoph Hellwig wrote:
>=20
>  > > The patch below checks for a valid cap_ptr prior to printing the
>  > > message, now at KERN_WARNING level (it's not really an error, is it?)
>  >=20
>  > The real problem is that agpgart doesn't properly fill in the pci_id
>  > table but claims all devices and then does it's own probing internally.
>  > This also breaks hotplug in a funny way.
>=20
> This is fixed in agpgart-bk / -mm.  Andi went through all the drivers
> adding their id's.  Should be going to Linus soon.
>=20
> 		Dave

FWIW, sworks-agp.c has the same issue in mainline yet today.
agpgart: Unsupported Serverworks chipset (device id: 0011)=20
agpgart: Unsupported Serverworks chipset (device id: 0201)=20

I'll look at -mm to verify it's fixed there.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAxeKbIavu95Lw/AkRAnJLAKCPQ7dIPm36UHBQRcB8w9ISvdN81ACeKK7n
B8zeJbS0Iv62xn6YvdupbFk=
=PKrp
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
