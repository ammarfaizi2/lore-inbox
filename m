Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTIGPpE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 11:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTIGPpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 11:45:04 -0400
Received: from tomts9.bellnexxia.net ([209.226.175.53]:27277 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263349AbTIGPo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 11:44:58 -0400
Date: Sun, 7 Sep 2003 11:41:28 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test4-bk9:  card services build error
Message-ID: <Pine.LNX.4.44.0309071139520.16112-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  from a build of 2.6.0-test4-bk9 (didn't appear to be there in bk8):

...

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      kernel/configs.o
  LD      kernel/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x8511c): In function `CardServices':
: undefined reference to `pcmcia_deregister_client'
drivers/built-in.o(.text+0x86d15): In function `pcmcia_bus_remove_socket':
: undefined reference to `pcmcia_deregister_client'
drivers/built-in.o(__ksymtab+0x1150): undefined reference to `pcmcia_deregister_client'
make: *** [.tmp_vmlinux1] Error 1

thoughts?

rday

