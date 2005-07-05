Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVGEWD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVGEWD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVGEWBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:01:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57309 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261963AbVGEVuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:50:10 -0400
Date: Tue, 5 Jul 2005 23:50:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.12: arm compilation problems
Message-ID: <20050705215001.GC2259@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I get this, trying to cross-compile 2.6.12 for arm. I tried different
configs... What am I doing wrong? [2.6.11 compiles ok, and even works
on my zaurus after some patches. I tried unpatched 2.6.12, too.]

  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
/scratchbox/compilers/arm-gcc-3.3.4-glibc-2.3.2/bin/arm-linux-ld:arch/arm/kernel/vmlinux.lds:648:
syntax error
make: *** [.tmp_vmlinux1] Error 1
207.04user 14.19system 237.78 (3m57.784s) elapsed 93.04%CPU
pavel@amd:/data/l/linux-delme$

							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
