Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269241AbUIHTTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269241AbUIHTTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269277AbUIHTTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:19:11 -0400
Received: from mailbox.surfeu.se ([213.173.154.11]:55946 "EHLO surfeu.fi")
	by vger.kernel.org with ESMTP id S269241AbUIHTTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:19:06 -0400
Message-ID: <413F5B89.4AF97168@users.sourceforge.net>
Date: Wed, 08 Sep 2004 22:20:41 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org
CC: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v2.2a file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Fixed multi-key ioctl incompatibility with sparc64 boxes running 64 bit
  kernel and 32 bit userland. Fix enabled for 2.4.26 and later 2.4 kernels.
  2.6 kernels were not affected.
- Added key scrubbing support for AES loop cipher. This feature is not
  enabled by default because it doubles storage space requirement for loop
  encryption keys. To enable, add KEYSCRUB=y parameter to loop module make
  command. (2.4 and 2.6 kernels only).
- Added multi-key compatibility to losetup and mount -p option handling.
- Fixed incompatibility with 2.6.8.1 kernel struct bio handling.
- Small optimization to bio I/O barrier support. Also added support for
  queue->issue_flush_fn() I/O barrier calls. (2.6 kernels only).
- Added workaround for kernel bug that causes I/O errors on -EWOULDBLOCK I/O
  elevator failures (2.6 kernels only).

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.2a.tar.bz2
    md5sum ab10564704317b38b5c7f24e382acae3

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.2a.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
