Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKVMzi>; Wed, 22 Nov 2000 07:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQKVMz2>; Wed, 22 Nov 2000 07:55:28 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:5384 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129259AbQKVMzZ>;
	Wed, 22 Nov 2000 07:55:25 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.3.21 is available
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Nov 2000 23:25:17 +1100
Message-ID: <6715.974895917@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the "never release a security fix in a hurry" release.  The
security fixes in modutils 2.3.20 had some side effects on some config
files.  Linus knocked back environment variable MOD_SAFEMODE, instead
the kernel propagates the real uid that caused modprobe to be invoked.

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.3

patch-modutils-2.3.21.bz2       Patch from modutils 2.3.20 to 2.3.21
modutils-2.3.21.tar.bz2         Source tarball, includes RPM spec file
modutils-2.3.21-1.src.rpm       As above, in SRPM format
modutils-2.3.21-1.i386.rpm      Compiled with egcs-2.91.66, glibc 2.1.2
modutils-2.3.21-1.sparc.rpm     Compiled for combined sparc 32/64

Changelog extract

	* Remove compile warnings in xstrcat.
	* snprintf cleanups.
	* Set safemode when uid != euid.
	* Strip quotes from shell responses.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
