Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVELMVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVELMVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVELMVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:21:48 -0400
Received: from mail.portrix.net ([212.202.157.208]:26776 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261590AbVELMVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:21:25 -0400
Message-ID: <42834A2E.60908@ppp0.net>
Date: Thu, 12 May 2005 14:21:02 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm1, build results compared to 2.6.12-rc3-mm3
References: <20050512033100.017958f6.akpm@osdl.org>
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm1/


Comparing 2.6.12-rc3-mm3 to 2.6.12-rc4-mm1 (defconfig)

- sparc64: broke
    CC      arch/sparc64/kernel/signal32.o
    CC      arch/sparc64/kernel/ioctl32.o
    CC      arch/sparc64/kernel/binfmt_elf32.o
    CC      arch/sparc64/kernel/module.o
    CC      arch/sparc64/kernel/kprobes.o
  In file included from /usr/src/ctest/mm/kernel/arch/sparc64/kernel/kprobes.c:8:
  /usr/src/ctest/mm/kernel/include/linux/kprobes.h:122: error: parse error before "spinlock_t"
  /usr/src/ctest/mm/kernel/include/linux/kprobes.h:123: warning: function declaration isn't a prototype
  make[2]: *** [arch/sparc64/kernel/kprobes.o] Error 1
  make[1]: *** [arch/sparc64/kernel] Error 2
  make: *** [_all] Error 2
  Details: http://l4x.org/k/?d=3653

- arm: fixed
  Details: http://l4x.org/k/?d=3634

- arm26: still broken
  Details: http://l4x.org/k/?d=3635

- cris: still broken
  Details: http://l4x.org/k/?d=3636

- frv: still broken
  Details: http://l4x.org/k/?d=3637

- h8300: still broken
  Details: http://l4x.org/k/?d=3638

- ia64: still broken
  Details: http://l4x.org/k/?d=3640

- m32r: still broken
  Details: http://l4x.org/k/?d=3641

- m68k: still broken
  Details: http://l4x.org/k/?d=3642

- m68knommu: still broken
  Details: http://l4x.org/k/?d=3644

- parisc: still broken
  Details: http://l4x.org/k/?d=3646

- s390: still broken
  Details: http://l4x.org/k/?d=3649

- sh: still broken
  Details: http://l4x.org/k/?d=3650

- sh64: still broken
  Details: http://l4x.org/k/?d=3651

- v850: still broken
  Details: http://l4x.org/k/?d=3655

Summary: 8 ok, 14 failed

-- 
Jan
