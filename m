Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbSI3UYs>; Mon, 30 Sep 2002 16:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSI3UYs>; Mon, 30 Sep 2002 16:24:48 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:34855 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S261308AbSI3UYf>;
	Mon, 30 Sep 2002 16:24:35 -0400
Subject: Re: [uml-devel] uml-patch-2.5.39
From: James Stevenson <james@stev.org>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <200209301955.OAA03608@ccure.karaya.com>
References: <200209301955.OAA03608@ccure.karaya.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Sep 2002 21:26:21 +0100
Message-Id: <1033417581.1854.1.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The build works again.

not as far as i can tell.

just after typing make

Makefile:363: target `arch/um/os-Linux' given more than once in the same
rule.
Makefile:363: target `arch/um/kernel' given more than once in the same
rule.
Makefile:363: target `arch/um/drivers' given more than once in the same
rule.
Makefile:363: target `arch/um/sys-i386' given more than once in the same
rule.
Makefile:533: target `_modinst_arch/um/os-Linux' given more than once in
the same rule.
Makefile:533: target `_modinst_arch/um/kernel' given more than once in
the same rule.
Makefile:533: target `_modinst_arch/um/drivers' given more than once in
the same rule.
Makefile:533: target `_modinst_arch/um/sys-i386' given more than once in
the same rule.
  Generating include/linux/version.h (unchanged)
make[1]: Entering directory
`/home2/james/kernel-build/linux-2.5.39/scripts'
  gcc -Wp,-MD,./.fixdep.d -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer   -o fixdep fixdep.c
  gcc -Wp,-MD,./.split-include.d -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer   -o split-include split-include.c
  gcc -Wp,-MD,./.docproc.d -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer   -o docproc docproc.c
  gcc -Wp,-MD,./.conmakehash.d -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer   -o conmakehash conmakehash.c
make[1]: Leaving directory
`/home2/james/kernel-build/linux-2.5.39/scripts'
***
*** You changed .config w/o running make *config?
*** Please run "make oldconfig"
***
make: *** [include/linux/autoconf.h] Error 1






