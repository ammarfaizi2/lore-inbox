Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbUBPJZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 04:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265444AbUBPJZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 04:25:37 -0500
Received: from ns.suse.de ([195.135.220.2]:60312 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265442AbUBPJZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 04:25:32 -0500
Date: Mon, 16 Feb 2004 10:23:50 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: kernel-smp on i386, too many arguments to function `aty128_find_mem_vbios'
Message-ID: <20040216092350.GA23211@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  CC [M]  drivers/video/aty/radeon_base.o
drivers/video/aty/radeon_base.c: In function `radeon_screen_blank':
drivers/video/aty/radeon_base.c:945: warning: `val2' might be used uninitialized in this function
drivers/video/aty/radeon_base.c: In function `radeonfb_setcolreg':
drivers/video/aty/radeon_base.c:1026: warning: `vclk_cntl' might be used uninitialized in this function
drivers/video/aty/radeon_base.c: In function `radeonfb_set_par':
drivers/video/aty/radeon_base.c:1320: warning: `pll_output_freq' might be used uninitialized in this function
  CC [M]  drivers/video/aty/radeon_pm.o
  CC [M]  drivers/video/aty/radeon_monitor.o
drivers/video/aty/radeon_monitor.c: In function `radeon_match_mode':
drivers/video/aty/radeon_monitor.c:865: warning: passing arg 1 of `fb_validate_mode' discards qualifiers from pointer target type
  CC [M]  drivers/video/aty/radeon_accel.o
  CC [M]  drivers/video/aty/radeon_i2c.o
  LD [M]  drivers/video/aty/atyfb.o
  CC [M]  drivers/video/aty/aty128fb.o
drivers/video/aty/aty128fb.c: In function `aty128_probe':
drivers/video/aty/aty128fb.c:1955: error: too many arguments to function `aty128_find_mem_vbios'
make[3]: *** [drivers/video/aty/aty128fb.o] Error 1
make[2]: *** [drivers/video/aty] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

current bk.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
