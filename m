Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267249AbUG1Pru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267249AbUG1Pru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267240AbUG1Ppu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:45:50 -0400
Received: from mailbox.surfeu.se ([213.173.154.11]:36831 "EHLO surfeu.fi")
	by vger.kernel.org with ESMTP id S267258AbUG1PpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:45:01 -0400
Message-ID: <4107CA36.2C105379@users.sourceforge.net>
Date: Wed, 28 Jul 2004 18:45:58 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org
CC: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v2.1c file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Adapted and merged Russell King's loop.c flush_dcache_page() fix. Most
  sane processors were not affected, but some processors with goofy aliasing
  caches were indeed affected (2.4 and 2.6 kernels).
- Added optimized assembler implementations of AES and MD5 functions for
  AMD64 and compatible processors.
- Pentium-2 optimized assembler implementations of AES and MD5 are really
  i386 compatible, so now those assembler implementations are enabled for
  all x86 processors.
- Fixed Makefile to be compatible with distros that include "" characters in
  KERNELRELEASE string.
- Added dkms.conf configuration file for Dynamic Kernel Module Support.
  Charles Duffy wrote original version.
- Added support for /lib/modules/`uname -r`/source symlink.
- Converted MODULE_PARM macros to module_param (2.6 kernels only).
- Added workaround for scripts/modpost breakage (2.6 kernels only).

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.1c.tar.bz2
    md5sum b404d9d679b7096dd3fb089345c52320

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.1c.tar.bz2.sign


Additional ciphers package changes since previous release:
- Fixed Makefile to be compatible with distros that include "" characters in
  KERNELRELEASE string.
- Added dkms.conf configuration file for Dynamic Kernel Module Support.
  Adapted from version that was originally written by Charles Duffy.
- Added support for /lib/modules/`uname -r`/source symlink.
- Added workaround for scripts/modpost breakage (2.6 kernels only).

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/ciphers/ciphers-v2.0i.tar.bz2
    md5sum 1a5e1d967bca0cde71a32e533ef26ce9

    http://loop-aes.sourceforge.net/ciphers/ciphers-v2.0i.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
