Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265318AbTFFFhp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 01:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTFFFho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 01:37:44 -0400
Received: from pan.togami.com ([66.139.75.105]:22429 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S265318AbTFFFhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 01:37:43 -0400
Subject: 2.5.70 thru bk10 amd64 compile failure
From: Warren Togami <warren@togami.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1054878617.3699.134.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 05 Jun 2003 19:50:17 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.togami.com/~warren/archive/2003/opteron/kernel-2.5.70.cfg

kernel-2.5.70, 2.5.70-bk9 and 2.5.70-bk10 all fail compilation here on
my amd64 with gcc-3.2.2-10 on stock RedHat GinGin64.  Please pardon me
if this is a duplicate report, I am now subscribing in order to keep a
closer eye on this list.

  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux
arch/x86_64/ia32/built-in.o(.text+0x6885): In function `vt_check':
: undefined reference to `vt_ioctl'
arch/x86_64/ia32/built-in.o(.text+0x6978): In function `do_fontx_ioctl':
: undefined reference to `fg_console'
arch/x86_64/ia32/built-in.o(.text+0x69a9): In function `do_fontx_ioctl':
: undefined reference to `con_font_op'
arch/x86_64/ia32/built-in.o(.text+0x69c2): In function `do_fontx_ioctl':
: undefined reference to `fg_console'
arch/x86_64/ia32/built-in.o(.text+0x69f3): In function `do_fontx_ioctl':
: undefined reference to `con_font_op'
arch/x86_64/ia32/built-in.o(.text+0x6ad5): In function
`do_kdfontop_ioctl':
: undefined reference to `con_font_op'
arch/x86_64/ia32/built-in.o(.text+0x6b89): In function
`do_unimap_ioctl':
: undefined reference to `fg_console'
arch/x86_64/ia32/built-in.o(.text+0x6b8e): In function
`do_unimap_ioctl':
: undefined reference to `con_set_unimap'
arch/x86_64/ia32/built-in.o(.text+0x6ba1): In function
`do_unimap_ioctl':
: undefined reference to `fg_console'
arch/x86_64/ia32/built-in.o(.text+0x6ba6): In function
`do_unimap_ioctl':
: undefined reference to `con_get_unimap'
make: *** [vmlinux] Error 1


