Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264772AbSJaIrO>; Thu, 31 Oct 2002 03:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264787AbSJaIrO>; Thu, 31 Oct 2002 03:47:14 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:30307 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S264772AbSJaIrN>;
	Thu, 31 Oct 2002 03:47:13 -0500
Date: Thu, 31 Oct 2002 09:53:32 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031095332.F5815@jaquet.dk>
References: <20021030233605.A32411@jaquet.dk> <20021031083205.GC833@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021031083205.GC833@suse.de>; from axboe@suse.de on Thu, Oct 31, 2002 at 09:32:05AM +0100
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2002 at 09:32:05AM +0100, Jens Axboe wrote:
> On Wed, Oct 30 2002, Rasmus Andersen wrote:
> >  o noswap: Disabling swap by stubbing out all of swapfile.c,
> >    swap_stat.c, page_io.c, highmem.c and some of memory.c.=20
> >    Patch at: www.jaquet.dk/kernel/config_tiny/2.5.44-noswap
>=20
> You can't stub out all of highmem.c, it's also used for bounce io
> (highmem as well as isa for > 16mb adresses)

OK, I missed the ISA > 16MB stuff. I have a look at it again.
I don't think that people is going to have CONFIG_HIGHMEM
and CONFIG_TINY on at the same time anyways (could be expressed
explicitly, though).

Thanks for your comments,
  Rasmus

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wO+MlZJASZ6eJs4RArkSAKCC0q3daMzoZQekr/q2IbUGHo4T1wCfZ6jO
t/HLZrcxL3fQK9rSJtFexI8=
=LADP
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
