Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTIQJXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 05:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbTIQJXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 05:23:50 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:44656 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262570AbTIQJXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 05:23:45 -0400
Subject: 2.6.0-test5: Undefined reference to 'monotonic_clock'
From: Stephen Torri <storri@sbcglobal.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-baogAyrlOVgwlCxLfJf5"
Message-Id: <1063790623.6829.7.camel@base>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Sep 2003 04:23:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-baogAyrlOVgwlCxLfJf5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I am compiling 2.6.0-test5 on a Alpha box. I grepped for the phrase
'monotonic_clock' because for some reason the file that was to provide
it was missing. The machine is a Alpha EV56 EB164 type, PC164 variation
using the 2.95.4. Here is the error message:

storri@alpha:$ sudo make vmlinux
make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      kernel/configs.o
  LD      kernel/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `hangcheck_fire':
/usr/src/linux-2.6.0-test5/drivers/char/hangcheck-timer.c:87: undefined
reference to `monotonic_clock'
/usr/src/linux-2.6.0-test5/drivers/char/hangcheck-timer.c:87: undefined
reference to `monotonic_clock'
/usr/src/linux-2.6.0-test5/drivers/char/hangcheck-timer.c:103: undefined
reference to `monotonic_clock'
/usr/src/linux-2.6.0-test5/drivers/char/hangcheck-timer.c:103: undefined
reference to `monotonic_clock'
drivers/built-in.o: In function `pnp_device_probe':
/usr/src/linux-2.6.0-test5/drivers/pnp/driver.c:119: undefined reference
to `monotonic_clock'
drivers/built-in.o:/usr/src/linux-2.6.0-test5/drivers/pnp/driver.c:119:
more undefined references to `monotonic_clock' follow
make: *** [.tmp_vmlinux1] Error 1

Stephen
--=20
Stephen Torri
GPG Key: http://www.cs.wustl.edu/~storri/storri.asc

--=-baogAyrlOVgwlCxLfJf5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/aCgemXRzpT81NcgRAlSMAKCvnMov/bNchx4y7gfp3sx1GpJ3bQCfWQtg
WnWDKfmi+sVAO7+jpNohODA=
=GLwb
-----END PGP SIGNATURE-----

--=-baogAyrlOVgwlCxLfJf5--

