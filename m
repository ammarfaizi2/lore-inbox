Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUGVOBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUGVOBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 10:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUGVOBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 10:01:39 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:21960 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S265812AbUGVOBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 10:01:36 -0400
Date: Thu, 22 Jul 2004 09:35:51 -0400
From: Harald Welte <laforge@gnumonks.org>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: crossgcc <crossgcc@sources.redhat.com>,
       "'Hollis Blanchard'" <hollisb@us.ibm.com>,
       "'bertrand marquis'" <bertrand_marquis@yahoo.fr>,
       "'trevor_scroggins@hotmail.com'" <trevor_scroggins@hotmail.com>,
       "'Dan Kegel'" <dank@kegel.com>,
       "'Geert Uytterhoeven'" <geert@linux-m68k.org>,
       "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No rule to make target `net/ipv4/netfilter/ipt_ecn.o'
Message-ID: <20040722133551.GB14946@obroa-skai.de.gnumonks.org>
References: <313680C9A886D511A06000204840E1CF08F43050@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <313680C9A886D511A06000204840E1CF08F43050@whq-msgusr-02.pit.comms.marconi.com>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.6.8-rc1-qs
X-Date: Today is Boomtime, the 56th day of Confusion in the YOLD 3170
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 22, 2004 at 03:57:14AM -0400, Povolotsky, Alexander wrote:
> Hi,
> I created such elf.h file and placed it into /usr/include under Cygwin in=
 Z:
> It works (the problem is solved) - so consider it to be tested now !

> PS But the compilation did not complete, the next error is:
>=20
> make[3]: *** No rule to make target
>  `net/ipv4/netfilter/ipt_ecn.o', needed by `net/ipv4/netfilter/built-in.o=
'.
> Stop.
> make[2]: *** [net/ipv4/netfilter] Error 2
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2

crosscompiling the linux kernel from an OS with broken (aka case-independen=
t)
filesystem (like FAT / VFAT / NTFS) will not work for
netfilter/iptables, since we have things like ipt_tos.c (tos match) and
ipt_TTL.c (tos target).

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA/8K3XaXGVTD0i/8RAvKPAJ4n32zpYQ23iCL35M4s1S+q2ER2JACeNFec
To6JEWlBLlBvGxWlj6VxflQ=
=KOn0
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
