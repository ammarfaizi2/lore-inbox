Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265036AbUEYTAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbUEYTAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265049AbUEYTAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:00:41 -0400
Received: from sark.cc.gatech.edu ([130.207.7.23]:56524 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP id S265036AbUEYTAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:00:39 -0400
Date: Tue, 25 May 2004 15:00:37 -0400 (EDT)
From: Younggyun Koh <young@cc.gatech.edu>
To: linux-kernel@vger.kernel.org, young@cc.gatech.edu
Subject: Installing 2.6.6 on hp zx6000
Message-ID: <Pine.GSO.4.58.0405251451300.28567@tokyo.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i'm trying to run linux kernel 2.6.6 on hp itanium2 machine - zx6000,
which is running Redhat advanced server 2.1AW...
and i got some questions..

1. has anyone succeeded with the same condition?

2. nfs-utils currently installed is version 0.3.3. the minimum requirement
for 2.6.6 is 1.0.5, but i was told from the system management guy that
installing 1.0.5 might cause serious problems... is it true?

3. i got the link error when i build the kernel

bash-2.05$ make CROSS_COMPILE=/opt/gcc-3.3.3/usr/local/bin/
warning: your linker cannot handle cross-segment segment-relative
relocations.
         please upgrade to a newer version (it is safe to use this linker,
but
         the kernel will be bigger than strictly necessary).
make[1]: `arch/ia64/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-ia64/offsets.h
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
/opt/gcc-3.3.3/usr/local/bin/ld: final link failed: File truncated
make: *** [.tmp_vmlinux1] Error 1

any idea?

thank you very much!

			-Younggyun Koh (young@cc.gatech.edu)
