Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318064AbSG2UPT>; Mon, 29 Jul 2002 16:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318065AbSG2UPT>; Mon, 29 Jul 2002 16:15:19 -0400
Received: from mx02.komtel.net ([212.7.146.1]:49973 "EHLO mx02.komtel.net")
	by vger.kernel.org with ESMTP id <S318064AbSG2UPQ>;
	Mon, 29 Jul 2002 16:15:16 -0400
Date: Mon, 29 Jul 2002 22:17:59 +0200
From: Stefan Kleyer <kleyer@foni.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19rc3-ac4 parse error
Message-Id: <20020729221759.1576dd0d.kleyer@foni.net>
Organization: TUX WE TRUST
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this error while compiling: 

make[4]: Entering directory `/usr/src/linux.19rc3-ac4-sk/drivers/char/drm'
gcc -D__KERNEL__ -I/usr/src/linux.19rc3-ac4-sk/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -I /usr/lib/gcc-lib/i386-slackware-linux/2.95.3/include -DKBUILD_BASENAME=r128_drv  -c -o r128_drv.o r128_drv.c
In file included from r128_drv.c:36:
ati_pcigart.h: In function `r128_ati_pcigart_init':
ati_pcigart.h:96: parse error before `)'
ati_pcigart.h:102: parse error before `)'
ati_pcigart.h:107: parse error before `)'
ati_pcigart.h:115: parse error before `)'
ati_pcigart.h:135: parse error before `)'
ati_pcigart.h: In function `r128_ati_pcigart_cleanup':
ati_pcigart.h:173: parse error before `)'
In file included from r128_drv.c:80:
drm_context.h: In function `r128_context_switch':
drm_context.h:228: parse error before `)'
drm_context.h: In function `r128_context_switch_complete':
drm_context.h:259: parse error before `)'
drm_context.h: In function `r128_addctx':
drm_context.h:319: parse error before `)'
In file included from r128_drv.c:83:
drm_drv.h: In function `r128_setup':
drm_drv.h:323: parse error before `)'
drm_drv.h: In function `r128_takedown':
drm_drv.h:345: parse error before `)'
drm_drv.h: In function `drm_count_cards':
drm_drv.h:504: parse error before `)'
drm_drv.h: In function `drm_init':
drm_drv.h:537: parse error before `)'
drm_drv.h:595: parse error before `)'
drm_drv.h: In function `drm_cleanup':
drm_drv.h:622: parse error before `)'
drm_drv.h:627: parse error before `)'
drm_drv.h: In function `r128_ioctl':
drm_drv.h:888: parse error before `)'
drm_drv.h: In function `r128_unlock':
drm_drv.h:1043: parse error before `)'
In file included from r128_drv.c:104:
drm_fops.h: In function `r128_read':
drm_fops.h:135: parse error before `)'
drm_fops.h:143: parse error before `)'
drm_fops.h:148: parse error before `)'
drm_fops.h: In function `r128_write_string':
drm_fops.h:206: parse error before `)'
In file included from r128_drv.c:107:
drm_lock.h: In function `r128_block':
drm_lock.h:38: parse error before `)'
drm_lock.h: In function `r128_unblock':
drm_lock.h:45: parse error before `)'
drm_lock.h: In function `r128_flush_queue':
drm_lock.h:120: parse error before `)'
drm_lock.h: In function `r128_flush_unblock_queue':
drm_lock.h:151: parse error before `)'
drm_lock.h: In function `r128_flush_block_and_flush':
drm_lock.h:170: parse error before `)'
drm_lock.h: In function `r128_flush_unblock':
drm_lock.h:189: parse error before `)'
drm_lock.h: In function `r128_finish':
drm_lock.h:212: parse error before `)'
In file included from r128_drv.c:109:
drm_proc.h: In function `r128_proc_init':
drm_proc.h:87: parse error before `)'
In file included from r128_drv.c:111:
drm_stub.h: In function `r128_stub_register':
drm_stub.h:125: parse error before `)'
drm_stub.h:133: parse error before `)'
drm_stub.h:137: parse error before `)'
make[4]: *** [r128_drv.o] Error 1
make[4]: Leaving directory `/usr/src/linux.19rc3-ac4-sk/drivers/char/drm'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux.19rc3-ac4-sk/drivers/char/drm'
make[2]: *** [_subdir_drm] Error 2
make[2]: Leaving directory `/usr/src/linux.19rc3-ac4-sk/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux.19rc3-ac4-sk/drivers'
make: *** [_dir_drivers] Error 2

Bye,  Stefan
