Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSKVXPT>; Fri, 22 Nov 2002 18:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265380AbSKVXPT>; Fri, 22 Nov 2002 18:15:19 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:61568 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S265339AbSKVXPS> convert rfc822-to-8bit; Fri, 22 Nov 2002 18:15:18 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.20-rc2aa1 refuses to boot into non frame buffer mode
Date: Sat, 23 Nov 2002 10:23:56 +1100
User-Agent: KMail/1.4.3
Cc: Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211231024.00884.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When the vesa framebuffer is compiled into 2.4.20-rc2aa1 kernel it will boot 
into the framebuffer mode even if I specify vga=normal at lilo. I had to 
recompile it without framebuffer support since booting into framebuffer mode 
gives very different benchmark results.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE93ryNF6dfvkL3i1gRAuIjAJ41hqFkx7IYfpsAkn6aatbvU0LC6ACcD3HH
am2vn7vNSabkID0Xvz5VnWY=
=asQi
-----END PGP SIGNATURE-----
