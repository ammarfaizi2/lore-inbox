Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbUK0TQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUK0TQx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 14:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbUK0TQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 14:16:53 -0500
Received: from mailbox.surfeu.se ([213.173.154.11]:54442 "EHLO surfeu.fi")
	by vger.kernel.org with ESMTP id S261303AbUK0TQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 14:16:50 -0500
Message-ID: <41A8D303.E28795C4@users.sourceforge.net>
Date: Sat, 27 Nov 2004 21:18:27 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org
CC: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v3.0a file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Added new improved version 3 on-disk format that includes one separate key
  for MD5 IV computation. This fixes a weakness in IV computation that
  normally is not exploitable.
- Fixed a bug that caused key file decrypt failure when gpg home directory
  was on read-only mounted file system. This bug affected encrypted root
  partition usage and is present only in losetup+mount from loop-AES-v2.2c
  and loop-AES-v2.2d versions.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.0a.tar.bz2
    md5sum 524bba6eb2eb330bb2faf2b651db6ab7

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.0a.tar.bz2.sign


Additional ciphers package changes since previous release:
- Added new improved version 3 on-disk format that includes one separate key
  for MD5 IV computation. This fixes a weakness in IV computation that
  normally is not exploitable.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/ciphers/ciphers-v3.0a.tar.bz2
    md5sum a7c060d05d08b89d2e99fe64f7a7b592

    http://loop-aes.sourceforge.net/ciphers/ciphers-v3.0a.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
