Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRDGTBc>; Sat, 7 Apr 2001 15:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDGTBW>; Sat, 7 Apr 2001 15:01:22 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:3630 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129638AbRDGTBB>; Sat, 7 Apr 2001 15:01:01 -0400
Date: Sat, 7 Apr 2001 20:00:53 +0100
From: Tim Waugh <twaugh@redhat.com>
To: =?iso-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
Cc: Michael Reinelt <reinelt@eunet.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
Message-ID: <20010407200053.B3280@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <Pine.LNX.4.10.10104071043360.1085-100000@linux.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10104071043360.1085-100000@linux.local>; from groudier@club-internet.fr on Sat, Apr 07, 2001 at 11:04:38AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 07, 2001 at 11:04:38AM +0200, G=E9rard Roudier wrote:

> Given your description, this board is certainly not a multi-fonction PCI
> device. Multi-function PCI devices provide separate resources for each
> function in a way that allows each function to be driven by separate
> software drivers.

Yes, but the vendor screwed it up (probably to save money).  This is
_very_ common.  It is very unusual to have a multifunction I/O card
that gets this right (in fact Lava is the only one I can think of
off-hand).

> Band-aiding the kernel code in order to cope with such brain-deaded
> hardware would be a pity, in my opinion. Burden must stay where it
> is deserved.

If we have to do this, then Gunther's approach (multifunc_quirks or
whatever) looks a lot better than having a separate driver for every
single multi-IO card.

Tim.
*/

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6z2PlONXnILZ4yVIRAopkAKCn8eQqffatOBIbEDO5pfVGEHZLxQCglWTR
Nt8LdwqvfsABruH4vxLwOn0=
=uW5n
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
