Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286150AbRLJDDt>; Sun, 9 Dec 2001 22:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286151AbRLJDDj>; Sun, 9 Dec 2001 22:03:39 -0500
Received: from fe8.southeast.rr.com ([24.93.67.55]:33284 "EHLO
	mail8.carolina.rr.com") by vger.kernel.org with ESMTP
	id <S286150AbRLJDD0>; Sun, 9 Dec 2001 22:03:26 -0500
From: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
Date: Sun, 9 Dec 2001 22:03:20 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre{7,8} fails to link
Message-ID: <20011210030320.GA1621@clt88-175-140.carolina.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/net.o(.data+0x174): undefined reference to `local symbols in
discarded section .text.exit'
make[1]: *** [vmlinux] Error 1

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011006 (Debian prerelease)

$ ld -v
GNU ld version 2.11.92.0.12.3 20011121 Debian/GNU Linux

-
Zilvinas Valinskas
