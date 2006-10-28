Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752202AbWJ1MOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbWJ1MOa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 08:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbWJ1MOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 08:14:30 -0400
Received: from mail.tnnet.fi ([217.112.240.26]:46988 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S1752196AbWJ1MO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 08:14:29 -0400
Message-ID: <4543499D.67317564@users.sourceforge.net>
Date: Sat, 28 Oct 2006 15:14:21 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v3.1e file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Changed swapon program to use getpagesize() instead of PAGE_SIZE macro.
  Fixes build failure on some architectures. Patch form Max Vozeler.
- Fixed some confusing bits in README. Fix from Jens Lechtenboerger.
- Work around vanished <linux/config.h> in 2.6.19-rc2 kernel. Fixes build
  failure.
- Changed loop code to use kthread_create() instead of kernel_thread() on
  2.6.19-rc and newer kernels.
- Changed losetup and mount programs to output error message if gpg program
  does not exist when gpg encrypted key file is used.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.1e.tar.bz2
    md5sum 021d6a83e05a13ad84cd601d5e5ecefb

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.1e.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
