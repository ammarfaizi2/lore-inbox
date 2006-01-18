Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWARPt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWARPt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWARPt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:49:28 -0500
Received: from mail.tnnet.fi ([217.112.240.26]:46474 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S1030357AbWARPt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:49:27 -0500
Message-ID: <43CE6384.284B823C@users.sourceforge.net>
Date: Wed, 18 Jan 2006 17:49:24 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v3.1c file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- WBINVD assembler instruction is no longer used on Xen builds.
- Makefile changed to probe .h header files instead of .c source files. (2.4
  and 2.6 kernels)
- compat_ioctl code updated to handle all 32bit/64bit loop ioctl conversions
  on 2.6 kernels. No longer depends on fs/compat_ioctl.c handling them.
- Semaphores are not used/needed anymore on 2.6 kernels.
- Makefile changed to work around 2.6.16-rc1 build breakage.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.1c.tar.bz2
    md5sum 3e54b8e66142fe58282e58075f73e58c

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.1c.tar.bz2.sign


Additional ciphers package changes since previous release:
- Makefile changed to work around 2.6.16-rc1 build breakage.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/ciphers/ciphers-v3.0c.tar.bz2
    md5sum 8770eb519b448ef0d4a0306e015de283

    http://loop-aes.sourceforge.net/ciphers/ciphers-v3.0c.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
