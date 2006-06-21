Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWFUIlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWFUIlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 04:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWFUIlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 04:41:09 -0400
Received: from www.polish-dvd.com ([69.222.0.225]:43493 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S932486AbWFUIlI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 04:41:08 -0400
Message-ID: <20060621033119.jxslshpug3k0kogc@69.222.0.225>
Date: Wed, 21 Jun 2006 03:31:19 -0500
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: 2.6.17-rt1-64bit-SMP compilation errors - mm/slab.c:...
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.1.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-rt1-64bit-SMP compilation errors - mm/slab.c:3246: error: too  
few arguments to function ?__drain_alien_cache?


mm/slab.o
mm/slab.c: In function ?reap_alien?:
mm/slab.c:1065: warning: implicit declaration of function  
?_raw_spin_trylock_irq ?
mm/slab.c: In function ?drain_alien_cache?:
mm/slab.c:1083: warning: value computed is not used
mm/slab.c: In function ?cpuup_callback?:
mm/slab.c:1147: warning: value computed is not used
mm/slab.c:1181: warning: value computed is not used
mm/slab.c:1234: warning: value computed is not used
mm/slab.c:1278: warning: value computed is not used
mm/slab.c: In function ?init_list?:
mm/slab.c:1309: warning: value computed is not used
mm/slab.c: In function ?kmem_cache_init?:
mm/slab.c:1446: warning: value computed is not used
mm/slab.c:1456: warning: value computed is not used
mm/slab.c: In function ?__node_shrink?:
mm/slab.c:2361: warning: value computed is not used
mm/slab.c: In function ?__cache_shrink?:
mm/slab.c:2379: warning: value computed is not used
mm/slab.c: In function ?cache_grow?:
mm/slab.c:2684: warning: value computed is not used
mm/slab.c:2699: warning: value computed is not used
mm/slab.c: In function ?__cache_alloc?:
mm/slab.c:3026: warning: value computed is not used
mm/slab.c: In function ?__cache_free?:
mm/slab.c:3246: error: too few arguments to function ?__drain_alien_cache?
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
mm/slab.c:3253: error: too few arguments to function ?free_block?
mm/slab.c: In function ?kmem_cache_alloc_node?:
mm/slab.c:3365: warning: value computed is not used
mm/slab.c: In function ?kmem_cache_free?:
mm/slab.c:3512: warning: value computed is not used
mm/slab.c: In function ?kfree?:
mm/slab.c:3535: warning: value computed is not used
mm/slab.c: In function ?alloc_kmemlist?:
mm/slab.c:3607: warning: value computed is not used
mm/slab.c: In function ?do_tune_cpucache?:
mm/slab.c:3721: warning: value computed is not used
mm/slab.c: In function ?drain_array?:
mm/slab.c:3807: warning: value computed is not used
mm/slab.c: In function ?cache_reap?:
mm/slab.c:3892: warning: value computed is not used
mm/slab.c: In function ?s_show?:
mm/slab.c:4000: warning: value computed is not used
   CC      kernel/kexec.o
make[1]: *** [mm/slab.o] Error 1
make[1]: *** Waiting for unfinished jobs....
   CC      kernel/compat.o
kernel/kexec.c: In function ?sys_kexec_load?:
kernel/kexec.c:998: warning: value computed is not used
kernel/kexec.c: In function ?crash_kexec?:
kernel/kexec.c:1066: warning: value computed is not used
   CC      fs/mbcache.o
   CC      kernel/cpuset.o
   CC      fs/posix_acl.o
make: *** [mm] Error 2
   CC      fs/xattr_acl.o
make: *** Waiting for unfinished jobs....
   LD      fs/9p/built-in.o
   CC [M]  fs/9p/trans_fd.o
   CC [M]  fs/9p/mux.o
   CC [M]  fs/9p/fcall.o
   CC [M]  fs/9p/conv.o
   CC [M]  fs/9p/vfs_super.o
   GZIP    kernel/config_data.gz

xboom

art@usfltd.com

