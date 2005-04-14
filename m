Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVDNUE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVDNUE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVDNUEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:04:25 -0400
Received: from 91.64-26.246.80.66.in-addr.arpa ([66.80.246.91]:7625 "EHLO
	knight.gregfolkert.net") by vger.kernel.org with ESMTP
	id S261485AbVDNUDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:03:52 -0400
Subject: Re: Exploit in 2.6 kernels
From: Greg Folkert <greg@gregfolkert.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Eric Rannaud <eric.rannaud@ens.fr>, John M Collins <jmc@xisl.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050413144126.GK521@csclub.uwaterloo.ca>
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com>
	 <20050412210857.GT11199@shell0.pdx.osdl.net>
	 <1113341579.3105.63.camel@caveman.xisl.com>
	 <20050413130230.GO17865@csclub.uwaterloo.ca>
	 <1113402388.5914.12.camel@localhost>
	 <20050413144126.GK521@csclub.uwaterloo.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O7IVgwJdkZpHHPffN3Vl"
Date: Thu, 14 Apr 2005 16:02:47 -0400
Message-Id: <1113508967.6036.4.camel@king.gregfolkert.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O7IVgwJdkZpHHPffN3Vl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-04-13 at 10:41 -0400, Lennart Sorensen wrote:
> On Wed, Apr 13, 2005 at 09:26:28AM -0500, Eric Rannaud wrote:
> > On Wed, 2005-04-13 at 09:02 -0400, Lennart Sorensen wrote:
> > > modprobe nvidia || m-a -t prepare nvidia && m-a -t build nvidia && m-=
a -t install nvidia && modprobe nvidia
> >=20
> > Something along the lines of:
> > modprobe nvidia || sh NVIDIA-Linux-x86-1.0-6629-pkg1.run -s -f --no-net=
work && modprobe nvidia
> >=20
> > should work on any distribution (it runs NVIDIA installer silently).
> > (see sh NVIDIA-Linux-x86-1.0-6629-pkg1.run --advanced-options)
>=20
> It will work on most.  Some don't like where the nvidia installer dumps
> it files in some cases.  Certainly doesn't work on every amd64 system
> since they can't agree where 64bit libs should go yet.
>=20
> It also violates my principles more than using binary only drivers does.
> All files in /usr (except /usr/local) _must_ be installed by one package
> management tool.  No excaptions allowed.  I haven't had to reinstall for
> 6 years, so I am sticking with my principles.

A-Freakin'-MEN me droogy.

Hehehe, either a slow system, or you know how to transfer a working
setup to another machine.

My current image I use(d) for all of my machines was Built a long time
ago, I think slink was what I used to build it. On a Pentium-90.

Currently on an Athlon XP3200+ with bells and whistles not even thought
of then. Moved through about 12 machines since the beginning.
--=20
greg, greg@gregfolkert.net

The technology that is
Stronger, better, faster: Linux

--=-O7IVgwJdkZpHHPffN3Vl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCXsxn7WZpcbUkaHwRAlJCAKCvLderPGIeb3fd7G/rOdABONiF0ACgkfi9
MQ78+N4hk+cLB5VlQJMBiaU=
=CbE0
-----END PGP SIGNATURE-----

--=-O7IVgwJdkZpHHPffN3Vl--

