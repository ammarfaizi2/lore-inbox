Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318059AbSHHWgr>; Thu, 8 Aug 2002 18:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318065AbSHHWgr>; Thu, 8 Aug 2002 18:36:47 -0400
Received: from ppp-217-133-219-100.dialup.tiscali.it ([217.133.219.100]:21997
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318059AbSHHWgr>; Thu, 8 Aug 2002 18:36:47 -0400
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
	mips, m68k, sh, cris to use it
From: Luca Barbieri <ldb@ldb.ods.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.44.0208090018470.8911-100000@serv>
References: <Pine.LNX.4.44.0208090018470.8911-100000@serv>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-WV2ui8jXC1RpKSx4Kpte"
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2002 00:40:17 +0200
Message-Id: <1028846417.1669.95.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WV2ui8jXC1RpKSx4Kpte
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2002-08-09 at 00:27, Roman Zippel wrote:
> Hi,
> 
> On 9 Aug 2002, Luca Barbieri wrote:
> 
> > - Didn't implement atomic_{add,sub,inc,dec}_return. This is currently
> > not used in the generic kernel but it can be useful.
> 
> m68k has a cmpxchg like instruction, which can be used for that.
> 
> > - Had inline assembly for things the compiler should be able to generate
> > on its own
> 
> The compiler can cache the value in a register
It shouldn't since it is volatile and the machine has instructions with
memory operands.

Anyway, let's ignore the m68k-specific parts of the patch.


--=-WV2ui8jXC1RpKSx4Kpte
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9UvNQdjkty3ft5+cRApkXAKDc0xjWlt8tGH1GtNOvoYPRfhkosACg0sln
rFSX4MIrzPuMbxoS2yGpfHg=
=J+us
-----END PGP SIGNATURE-----

--=-WV2ui8jXC1RpKSx4Kpte--
