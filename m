Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSHTSwi>; Tue, 20 Aug 2002 14:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSHTSwh>; Tue, 20 Aug 2002 14:52:37 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:40019 "EHLO
	bird.iucha.org") by vger.kernel.org with ESMTP id <S317024AbSHTSwg>;
	Tue, 20 Aug 2002 14:52:36 -0400
Date: Tue, 20 Aug 2002 13:56:34 -0500
To: Rob Radez <rob@osinvestor.com>
Cc: lkml <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4
Message-ID: <20020820185634.GD10541@iucha.net>
Mail-Followup-To: Rob Radez <rob@osinvestor.com>,
	lkml <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org
References: <Pine.LNX.4.44.0208191944210.10105-100000@freak.distro.conectiva> <20020820144028.GB10541@iucha.net> <20020820115151.I1625@osinvestor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <20020820115151.I1625@osinvestor.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2002 at 11:51:51AM -0400, Rob Radez wrote:
> On Tue, Aug 20, 2002 at 09:40:28AM -0500, Florin Iucha wrote:
> > It fails to compile on sparc32 with:
>=20
> These errors (and more) are addressed in a patch which should be making i=
ts
> way upstream.  Please feel free to grab it out of the
> sparclinux@vger.kernel.org mailing list archives if you really want to use
> pre4.  Also, sparclinux@vger.kernel.org is the sparc32 mailing list, so
> please post any problems/patches there.

I have found your patch and now it compiles but 'make modules_install'
fails with:

depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre4/kernel/net/sunrpc/sunrpc.o
depmod:         ___illegal_use_of_BTFIXUP_SETHI_in_module
depmod:         ___f_set_pte
depmod:         fix_kmap_begin
depmod:         ___f_flush_cache_all
depmod:         ___f_pte_clear
depmod:         ___f_mk_pte
depmod:         ___f_flush_tlb_all

I have upgraded to the latest modultils. I will install the latest
binutils and try again (right now I am using binutils 2.12.90.0.1-4
from Debian-testing).

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9YpDhNLPgdTuQ3+QRAqAxAJ9HDtjPb03zr0w+nRcTZ9VVlVo5kQCfd2NW
CMh0pzIQPkfXnNZNqH1iXQU=
=mgvX
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
