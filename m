Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWAUTHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWAUTHy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 14:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWAUTHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 14:07:54 -0500
Received: from mx3.mail.ru ([194.67.23.149]:36645 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1751099AbWAUTHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 14:07:53 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Date: Sat, 21 Jan 2006 22:07:42 +0300
User-Agent: KMail/1.9.1
Cc: Olaf Hering <olh@suse.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601212207.49483.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>  make -kj14 O=../O-powerpc-ppc64-defconfig arch/powerpc/mm/mem.o
>   GEN    /home/olaf/kernel/olh/ppc64/O-powerpc-ppc64-defconfig/Makefile
> scripts/kconfig/conf -s arch/powerpc/Kconfig
> arch/powerpc/platforms/83xx/Kconfig:10:warning: 'select' used by config
> symbol \ 'MPC834x_SYS' refer to undefined symbol 'DEFAULT_UIMAGE' #
> # using defaults found in .config
> #
> make[3]: `.kernelrelease' is up to date.
>   SPLIT   include/linux/autoconf.h -> include/config/*
> + '[' -lt 0400 ']'
> /bin/sh: line 1: [: -lt: unary operator expected

does chmod +x scripts/gcc-version.sh help?

Which raises the question - I believed, we support Intel CC for kernel 
compilation? Or was just just a dream?

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0oaFR6LMutpd94wRAsj3AKDQ/TJDNUFT6HlJ+zkG7mW2pmrRZgCfWjfR
qFqo6sJ1jW/t/w1B26i/hdU=
=ByTQ
-----END PGP SIGNATURE-----
