Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbSK2Lqq>; Fri, 29 Nov 2002 06:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267025AbSK2Lqq>; Fri, 29 Nov 2002 06:46:46 -0500
Received: from 48-121-ADSL.red.retevision.es ([80.224.121.48]:56515 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S267024AbSK2Lqp>; Fri, 29 Nov 2002 06:46:45 -0500
Date: Fri, 29 Nov 2002 12:54:05 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Exaggerated swap usage
Message-ID: <20021129115405.GD15682@jerry.marcet.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.4.20-ac1-marcet i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Forgive me if I don't provide enough information just yet, or am not
clear enough. I simply don't know what setting to tweak.

I'll explain.
In recent 2.4.20 pre and rc kernels ( I tend to use the ac branch ), I
had notice my system, when using X mainly, got terribly slow after some
use. It surprised me that when I tried 2.5.47 this did not happen at
all, since I thought my problem was a lack of memory - the system has
384MB -.
Hence I tried to find where the difference was. What I found is that
2.4.20 kernels - 2.4.19 does the same -, was swapping just too much,
while there was a lot free memory on the system, cached but free.
I disabled all swap and it suddenly began to work smoothly again, yet
with the random kills when memory was a scarce resource on the system.
I've tried different sysctl's vm.overcommit settings but the result is
the same.

I also found a 2.4.x kernel which did not show this behavior, WOLK, in
any version I tried.

Could you please point me toward something I can try tweaking, or some
documentation to read which explains what I can change, unless it's some
kind of kernel problem?

BTW, aa kernels behaved somewhat better on this, only that the last one
I tried -rc2aa1- had some stability problems.

I can provide you with dmesg, /proc/meminfo or whatever might be useful.

Thanks in advance :)


--=20
Javier Marcet <jmarcet@pobox.com>

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3nVV0ACgkQx/ptJkB7frzpVACeLtLDO/l7UusoWUdhYR6P0d7L
n1IAn0m3D5Gxs6b9zdkUatjNrvddSbiZ
=2VsD
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
