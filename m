Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSKVCkK>; Thu, 21 Nov 2002 21:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbSKVCkK>; Thu, 21 Nov 2002 21:40:10 -0500
Received: from leviathan.kumin.ne.jp ([211.9.65.12]:49209 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S265066AbSKVCkJ>; Thu, 21 Nov 2002 21:40:09 -0500
Message-Id: <200211220246.AA00001@prism.kumin.ne.jp>
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Date: Fri, 22 Nov 2002 11:46:44 +0900
To: linux-kernel@vger.kernel.org
Subject: patch-2.5.48-dj1 compile error
In-Reply-To: <200208311112.AA00120@prism.kumin.ne.jp>
References: <200208311112.AA00120@prism.kumin.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I update linux-2.5.48 to use patch-2.5.48-dj1,
but a patch error and a compile error occured.

(1) patch error

patching file sound/oss/rme96xx.c
Hunk #3 FAILED at 54.
Hunk #4 succeeded at 145 (offset -4 lines).
Hunk #6 succeeded at 236 (offset -4 lines).
Hunk #8 succeeded at 352 (offset -4 lines).
Hunk #10 succeeded at 900 (offset -4 lines).
Hunk #12 succeeded at 1087 (offset -9 lines).
Hunk #14 succeeded at 1168 (offset -9 lines).
Hunk #16 succeeded at 1440 (offset -9 lines).
Hunk #18 FAILED at 1503.
Hunk #19 succeeded at 1523 (offset -9 lines).
Hunk #21 succeeded at 1591 (offset -9 lines).
Hunk #23 succeeded at 1701 (offset -9 lines).
Hunk #25 succeeded at 1799 (offset -9 lines).
2 out of 26 hunks FAILED -- saving rejects to file sound/oss/rme96xx.c.rej

(2) compile error

arch/i386/kernel/apm.c:998: warning: `sysrq_poweroff_op' defined but not used
fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:395: warning: long long unsigned int format, different type arg (arg 24)
drivers/base/base.h:35: warning: `class_hotplug' defined but not used
drivers/base/base.h:35: warning: `class_hotplug' defined but not used
drivers/base/base.h:35: warning: `class_hotplug' defined but not used
drivers/base/base.h:35: warning: `class_hotplug' defined but not used
drivers/base/base.h:35: warning: `class_hotplug' defined but not used
drivers/char/agp/agp.h:87: warning: `global_cache_flush' defined but not used
drivers/char/agp/agp.h:87: warning: `global_cache_flush' defined but not used
drivers/net/eepro100.c:2343: warning: `eepro100_remove_one' defined but not used
drivers/parport/parport_pc.c: In function `parport_pc_init':
drivers/parport/parport_pc.c:3048: warning: passing arg 1 of `pnp_register_driver' discards qualifiers from pointer 
target type
In file included from include/net/xfrm.h:6,
                 from net/core/skbuff.c:61:
include/linux/crypto.h: In function `crypto_tfm_alg_modname':
include/linux/crypto.h:202: dereferencing pointer to incomplete type
include/linux/crypto.h:205: warning: control reaches end of non-void function
make[2]: *** [net/core/skbuff.o] Error 1
make[1]: *** [net/core] Error 2
make: *** [net] Error 2

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
