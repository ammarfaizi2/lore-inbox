Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVAPV61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVAPV61 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVAPV61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:58:27 -0500
Received: from [217.112.240.26] ([217.112.240.26]:17804 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S262619AbVAPV6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:58:22 -0500
Message-ID: <41EAE36F.35354DDF@users.sourceforge.net>
Date: Sun, 16 Jan 2005 23:58:07 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v3.0b file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Fixed externally compiled module version multi-key-v3 ioctl
  incompatibility with boxes running 64 bit kernel and 32 bit userland.
  Kernel patch versions were not affected (2.4 and 2.6 kernels).
- Fixed bug that made v3 on-disk format always use file backed code path on
  some 2.6 kernels that did not have LO_FLAGS_DO_BMAP defined. No data loss,
  but file backed code path is not journaled file system safe. Same bug also
  had cosmetic side effect of "losetup -a" status query always displaying
  file backed v2 on-disk format as v3 on-disk format.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.0b.tar.bz2
    md5sum b295ff982cd4503603b38fdc54e604cc

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.0b.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
