Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTEWAS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 20:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTEWAS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 20:18:28 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:38594 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S263503AbTEWASW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 20:18:22 -0400
Subject: WARNINGS on 2.5.69-mm8
From: Max Valdez <maxvalde@fis.unam.mx>
To: kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RCJCtUYbfDVuORMXFxw3"
Organization: 
Message-Id: <1053632060.5663.17.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 22 May 2003 19:34:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RCJCtUYbfDVuORMXFxw3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This is a non optimized .config file, but there are at least some minor
problems.

I aplyed Yoshifuji's patch to arch/i386/kernel/apm.c for a
SET_MODULE_OWNER warning, but still have another one, and some others.

I attach the config and this is the output on make modules:
*** Warning: "screen_info" [drivers/video/vga16fb.ko] undefined!
*** Warning: "isapnp_protocol" [sound/isa/snd-es18xx.ko] undefined!
*** Warning: "dmi_broken" [arch/i386/kernel/cpu/cpufreq/powernow-k7.ko]
undefined!
*** Warning: "unregister_serial" [drivers/char/mwave/mwave.ko]
undefined!
*** Warning: "register_serial" [drivers/char/mwave/mwave.ko] undefined!
*** Warning: "set_fs_pwd" [fs/intermezzo/intermezzo.ko] undefined!
*** Warning: "set_fs_root" [fs/intermezzo/intermezzo.ko] undefined!
*** Warning: "SET_MODULE_OWNER" [drivers/char/i8k.ko] undefined!
  ld -m elf_i386 -r -o arch/i386/kernel/apm.ko arch/i386/kernel/apm.o
arch/i386/kernel/apm.mod.o

Any help apreciated :-)
Max
--=20
uname -a: Linux garaged.fis.unam.mx 2.4.21-pre4-ac4 #5 SMP Thu Feb 13 10:26=
:24 CST 2003 i686 unknown unknown GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-RCJCtUYbfDVuORMXFxw3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+zSY7srSE6THXcZwRAmQhAKCAgtkd4a+yXXkehDwUc0PrzeV53ACfVJF6
qtFx/mMV2at6lK8GJ5ql6cQ=
=cqyd
-----END PGP SIGNATURE-----

--=-RCJCtUYbfDVuORMXFxw3--

