Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbTECJsv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 05:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbTECJsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 05:48:51 -0400
Received: from dsl-62-3-122-162.zen.co.uk ([62.3.122.162]:2178 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S263286AbTECJst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 05:48:49 -0400
Subject: Re: Compile error kernel 2.4.21-rc1
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1051952389.3976.35.camel@marx>
References: <1051938126.3976.11.camel@marx>  <1051946869.3976.32.camel@marx>
	 <1051952389.3976.35.camel@marx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iUNvFVmBPjg9+fHuk1oE"
Organization: Trudheim Technology Limited
Message-Id: <1051956068.3979.37.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 03 May 2003 11:01:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iUNvFVmBPjg9+fHuk1oE
Content-Type: multipart/mixed; boundary="=-xirzy6VBAZJB6IGu7vwR"


--=-xirzy6VBAZJB6IGu7vwR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-05-03 at 09:59, Anders Karlsson wrote:
> On Sat, 2003-05-03 at 08:27, Anders Karlsson wrote:
> > On Sat, 2003-05-03 at 06:02, Anders Karlsson wrote:
> > > Hi,
> > >=20
> > > Just tried to compile kernel 2.4.21-rc1 and I get the compile error a=
s
> > > per attached file 'compile_error.txt'. The config file used is also
> > > attached. This happened while doing 'make rpm'. This is being compile=
d
> > > on SuSE Pro 8.2 which is using GCC 3.3.
> > >=20
> > > I'll happily try out patches.
> >=20
> > Found another compile error. Again attached in 'compile_error.txt'.
> >=20
> And another one.

And yet another one.

/Anders

--=-xirzy6VBAZJB6IGu7vwR
Content-Disposition: attachment; filename=compile_error.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=compile_error.txt; charset=UTF-8

gcc -D__KERNEL__ -I/usr/src/packages/BUILD/kernel-2.4.21rc1/include -Wall -=
Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fom=
it-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 -DMODUL=
E -DMODVERSIONS -include /usr/src/packages/BUILD/kernel-2.4.21rc1/include/l=
inux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=3Dsdla=
_chdlc  -c -o sdla_chdlc.o sdla_chdlc.c
sdla_chdlc.c:594:43: missing terminating " character
sdla_chdlc.c: In function `wpc_init':
sdla_chdlc.c:595: error: parse error before "Failed"
sdla_chdlc.c:595: error: stray '\' in program
sdla_chdlc.c:595:68: missing terminating " character
sdla_chdlc.c: In function `port_set_state':
sdla_chdlc.c:3462: warning: comparison between signed and unsigned
sdla_chdlc.c: In function `wanpipe_tty_write':
sdla_chdlc.c:4008: warning: comparison between signed and unsigned
sdla_chdlc.c: In function `wanpipe_tty_receive':
sdla_chdlc.c:4145: warning: comparison between signed and unsigned
sdla_chdlc.c:4155: warning: comparison between signed and unsigned
sdla_chdlc.c: In function `change_speed':
sdla_chdlc.c:4352: warning: comparison between signed and unsigned
/usr/src/packages/BUILD/kernel-2.4.21rc1/include/asm/io.h: At top level:
/usr/src/packages/BUILD/kernel-2.4.21rc1/include/linux/module.h:299: warnin=
g: `__module_kernel_version' defined but not used
/usr/src/packages/BUILD/kernel-2.4.21rc1/include/linux/module.h:302: warnin=
g: `__module_using_checksums' defined but not used
sdla_chdlc.c:4747: warning: `__module_license' defined but not used
make[4]: *** [sdla_chdlc.o] Error 1
make[4]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1/driver=
s/net/wan'
make[3]: *** [_modsubdir_wan] Error 2
make[3]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1/driver=
s/net'
make[2]: *** [_modsubdir_net] Error 2
make[2]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1/driver=
s'
make[1]: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/usr/src/packages/BUILD/kernel-2.4.21rc1'
Bad exit status from /var/tmp/rpm-tmp.10977 (%build)
make: *** [rpm] Error 1


--=-xirzy6VBAZJB6IGu7vwR--

--=-iUNvFVmBPjg9+fHuk1oE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+s5NkLYywqksgYBoRAjKxAJ92lVdJHczPdpgdS1AkjEO/qCJ98ACeMKm+
6vLWPjo+wvgMdWwHpcfbqNo=
=jy+S
-----END PGP SIGNATURE-----

--=-iUNvFVmBPjg9+fHuk1oE--

