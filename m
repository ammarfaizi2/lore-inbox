Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbUJXRQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUJXRQq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 13:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbUJXRQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 13:16:46 -0400
Received: from mailbox.surfeu.se ([213.173.154.11]:5604 "EHLO surfeu.fi")
	by vger.kernel.org with ESMTP id S261533AbUJXRQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 13:16:42 -0400
Message-ID: <417BE3D6.BB54FE7D@users.sourceforge.net>
Date: Sun, 24 Oct 2004 20:18:14 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org
CC: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v2.2c file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Added compile time autodetection and workaround for per-thread vs.
  per-process rlimits (2.6 kernels).
- Added Gentoo compatible binary key setup option to mount and losetup
  'mount -p 0 -o phash=unhashed3' or 'losetup -p 0 -H unhashed3'.
- Added random key setup option to mount and losetup. This can be used to
  encrypt /tmp with random keys.
- Added workaround for module_param_array() breakage in 2.6.10-rc

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.2c.tar.bz2
    md5sum 439a25bd1e85e8053bf0cf3c504279ed

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.2c.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
