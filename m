Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTFANZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTFANZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:25:31 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:33934 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264593AbTFANZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:25:27 -0400
Date: Sun, 1 Jun 2003 09:37:57 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.5.70-bk6] build error, drivers/built-in.o
Message-ID: <Pine.LNX.4.44.0306010936450.4986-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  HOSTCC  scripts/modpost.o
  HOSTLD  scripts/modpost
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
  CHK     include/linux/compile.h
./scripts/pnmtologo -t mono -n logo_linux_mono -o drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_mono.pbm
  CC      drivers/video/logo/logo_linux_mono.o
./scripts/pnmtologo -t vga16 -n logo_linux_vga16 -o drivers/video/logo/logo_linux_vga16.c drivers/video/logo/logo_linux_vga16.ppm
  CC      drivers/video/logo/logo_linux_vga16.o
./scripts/pnmtologo -t clut224 -n logo_linux_clut224 -o drivers/video/logo/logo_linux_clut224.c drivers/video/logo/logo_linux_clut224.ppm
  CC      drivers/video/logo/logo_linux_clut224.o
  LD      drivers/video/logo/built-in.o
  LD      drivers/video/built-in.o
  LD      drivers/built-in.o
drivers/usb/gadget/built-in.o(.text+0x1b40): In function `net2280_set_fifo_mode':
: multiple definition of `net2280_set_fifo_mode'
drivers/usb/built-in.o(.text+0x1b760): first defined here
drivers/usb/gadget/built-in.o(.text+0x5380): In function `usb_gadget_get_string':
: multiple definition of `usb_gadget_get_string'
drivers/usb/built-in.o(.text+0x1efa0): first defined here
drivers/usb/gadget/built-in.o(.text+0x1ea0): In function `usb_gadget_register_driver':
: multiple definition of `usb_gadget_register_driver'
drivers/usb/built-in.o(.text+0x1bac0): first defined here
drivers/usb/gadget/built-in.o(.text+0x20a0): In function `usb_gadget_unregister_driver':
: multiple definition of `usb_gadget_unregister_driver'
drivers/usb/built-in.o(.text+0x1bcc0): first defined here
make[1]: *** [drivers/built-in.o] Error 1
make: *** [drivers] Error 2


rday

--

Robert P. J. Day
Eno River Technologies
Unix, Linux and Open Source training
Waterloo, Ontario

www.enoriver.com

