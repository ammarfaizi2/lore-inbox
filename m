Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTJXGzy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 02:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJXGzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 02:55:53 -0400
Received: from mail.actcom.net.il ([192.114.47.15]:29101 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S262061AbTJXGzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 02:55:19 -0400
Date: Fri, 24 Oct 2003 08:54:12 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Sam Ravnborg <sam@ravnborg.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: building out of tree modules with 2.6.0-test8
Message-ID: <20031024065411.GE5017@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+yOEb87YRmRdrPqC"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+yOEb87YRmRdrPqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

Documentation/kbuild/modules.txt on 2.6.0-test8-bk says:=20

"Compiling modules outside the official kernel
---------------------------------------------
Often modules are developed outside the official kernel.
To keep up with changes in the build system the most portable way
to compile a module outside the kernel is to use the following
command-line:

make -C path/to/kernel/src SUBDIRS=3D$PWD modules"

However, trying this yields:=20

"make[1]: Entering directory `/home/muli/kernel/linux-2.5'
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  Building modules, stage 2.
/home/muli/kernel/linux-2.5/scripts/Makefile.modpost:17:=20
*** Uh-oh, you have stale module entries. You messed with SUBDIRS,=20
/home/muli/kernel/linux-2.5/scripts/Makefile.modpost:18:=20
do not complain if something goes wrong.=20
  MODPOST
make[1]: Leaving directory `/home/muli/kernel/linux-2.5'

What is the correct way to build out of tree modules? if there isn't a
correct way, any pointers on how to go about adding support for it?=20

Thanks,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://www.livejournal.com/~mulix

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--+yOEb87YRmRdrPqC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/mMyTKRs727/VN8sRAjTlAKCcYagPtHIK+EhMoArCUbbmvYGDdACgvenB
3SjO5d0cX23iZTrbYdQcw+Y=
=TXXh
-----END PGP SIGNATURE-----

--+yOEb87YRmRdrPqC--
