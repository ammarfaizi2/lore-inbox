Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWDJNx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWDJNx2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 09:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDJNx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 09:53:28 -0400
Received: from mail.tnnet.fi ([217.112.240.26]:29592 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S1751160AbWDJNx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 09:53:27 -0400
Message-ID: <443A6354.F9C720EF@users.sourceforge.net>
Date: Mon, 10 Apr 2006 16:53:24 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v3.1d file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Fixed Makefile incompatibility with USE_KBUILD=y build option.
- Fixed incompatibility with CONFIG_PAX_KERNEXEC=y PAX config option.
- Fixed incompatibility with old SuSE 8.0 kernel that caused scheduler
  interface to be misdetected.
- Changed mount to honor offset=N and sizelimit=N mount options when they
  were used in combination with random keys generating phash=random mount
  option. Old encrypted data is used in new keys generation, but earlier
  buggy version always read and erased old data at offset=0.
- Added mount patch from Max Vozeler that makes it easier to first fsck and
  then mount encrypted file systems.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.1d.tar.bz2
    md5sum b4d13d6421382ea048e113ad8a868dfa

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.1d.tar.bz2.sign


Additional ciphers package changes since previous release:
- Fixed Makefile incompatibility with USE_KBUILD=y build option.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/ciphers/ciphers-v3.0d.tar.bz2
    md5sum 65d5e85b3aabd5a36a199814c66cd7f9

    http://loop-aes.sourceforge.net/ciphers/ciphers-v3.0d.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
