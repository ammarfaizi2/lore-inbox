Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUELP2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUELP2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 11:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbUELP2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 11:28:30 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:62419 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265106AbUELP2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 11:28:01 -0400
Message-ID: <40A2427F.4060003@blueyonder.co.uk>
Date: Wed, 12 May 2004 16:27:59 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.6-mm1
Content-Type: multipart/mixed;
 boundary="------------020800070102090402050200"
X-OriginalArrivalTime: 12 May 2004 15:28:03.0468 (UTC) FILETIME=[B767ECC0:01C43835]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020800070102090402050200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Second rebuild is OK.
barrabas:/usr/src/linux-2.6.6-mm1 # nm -n vmlinux | grep -5 locks_alloc_lock
c0163250 T sys_poll
c01634a0 t wait_for_partner
c01634e0 t wake_up_partner
c0163510 t fifo_open
c01637c6 t .text.lock.fifo
c01637f0 t locks_alloc_lock
c0163810 T locks_init_lock
c0163890 t init_once
c01638b0 T locks_copy_lock
c0163920 t flock_make_lock
c01639c0 t assign_type

The nvidia 5336 driver fails to build.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.


--------------020800070102090402050200
Content-Type: text/plain;
 name="nvidia-installer.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nvidia-installer.log"

nvidia-installer log file '/var/log/nvidia-installer.log'
creation time: Wed May 12 16:20:05 2004

option status:
  license pre-accepted    : false
  update                  : false
  force update            : false
  expert                  : false
  uninstall               : false
  driver info             : false
  no precompiled interface: false
  no ncurses color        : false
  query latest driver ver : false
  OpenGL header files     : false
  no questions            : false
  silent                  : false
  XFree86 install prefix  : /usr/X11R6
  OpenGL install prefix   : /usr
  Installer install prefix: /usr
  kernel source path      : (not specified)
  kernel install path     : (not specified)
  proc mount point        : /proc
  ui                      : (not specified)
  tmpdir                  : /tmp
  ftp site                : ftp://download.nvidia.com

Using: nvidia-installer ncurses user interface
-> License accepted.
-> There appears to already be a driver installed on your system (version: 1.0-
   5336).  As part of installing this driver (version: 1.0-5336), the existing 
   driver will be uninstalled.  Are you sure you want to continue? ('no' will a
   bort installation) (Answer: Yes)
-> No precompiled kernel interface was found to match your kernel; would you li
   ke the installer to attempt to download a kernel interface for your kernel f
   rom the NVIDIA ftp site (ftp://download.nvidia.com)? (Answer: Yes)
-> No matching precompiled kernel interface was found on the NVIDIA ftp site;
   this means that the installer will need to compile a kernel interface for
   your kernel.
-> Kernel source path: '/lib/modules/2.6.6-mm1/build'
-> Performing cc_version_check with CC="cc".
-> Cleaning kernel module build directory.
   executing: 'cd ./usr/src/nv; make clean'...
   rm -f -f nv.o os-agp.o os-interface.o os-registry.o nv.o os-agp.o os-interfa
   ce.o os-registry.o nvidia.mod.o
   rm -f -f build-in.o nv-linux.o *.d .*.{cmd,flags}
   rm -f -f nvidia.{o,ko,mod.{o,c}} nv_compiler.h *~
-> Building kernel module:
   executing: 'cd ./usr/src/nv; make module SYSSRC=/lib/modules/2.6.6-mm1/build
   '...
   echo \#define NV_COMPILER \"`cc -v 2>&1 | tail -n 1`\" > /tmp/selfgz19415/NV
   IDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv_compiler.h
     CC [M]  /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.o
   In file included from include/linux/list.h:7,
                    from include/linux/wait.h:14,
                    from include/asm/semaphore.h:41,
                    from include/linux/sched.h:18,
                    from include/linux/module.h:10,
                    from /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/sr
   c/nv/nv-linux.h:52,
                    from /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/sr
   c/nv/nv.c:14:
   include/linux/prefetch.h: In function `prefetch_range':
   include/linux/prefetch.h:62: warning: pointer of type `void *' used in arith
   metic
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: In function
   `nvos_malloc_pages':
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:385: warning
   : use of cast expressions as lvalues is deprecated
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: In function
   `nvos_create_alloc':
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:513: warning
   : use of cast expressions as lvalues is deprecated
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:523: warning
   : use of cast expressions as lvalues is deprecated
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: At top leve
   l:
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:1185: warnin
   g: initialization from incompatible pointer type
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: In function
   `nv_alloc_file_private':
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:1193: warnin
   g: use of cast expressions as lvalues is deprecated
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:1204: warnin
   g: use of cast expressions as lvalues is deprecated
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: In function
   `nv_kern_open':
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:1265: warnin
   g: use of cast expressions as lvalues is deprecated
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: In function
   `nv_kern_ctl_open':
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:1914: warnin
   g: use of cast expressions as lvalues is deprecated
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c: At top leve
   l:
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2010: error:
   conflicting types for `nv_set_hotkey_occurred_flag'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:350: error: 
   previous declaration of `nv_set_hotkey_occurred_flag'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2197: error:
   conflicting types for `nv_find_nv_mapping'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:339: error: 
   previous declaration of `nv_find_nv_mapping'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2269: error:
   conflicting types for `nv_find_agp_kernel_mapping'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:341: error: 
   previous declaration of `nv_find_agp_kernel_mapping'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2345: error:
   conflicting types for `nv_get_kern_phys_address'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:342: error: 
   previous declaration of `nv_get_kern_phys_address'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2375: error:
   conflicting types for `nv_get_user_phys_address'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:343: error: 
   previous declaration of `nv_get_user_phys_address'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2406: error:
   conflicting types for `nv_alloc_pages'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:353: error: 
   previous declaration of `nv_alloc_pages'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2594: error:
   conflicting types for `nv_free_pages'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:354: error: 
   previous declaration of `nv_free_pages'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2692: error:
   conflicting types for `nv_lock_rm'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:345: error: 
   previous declaration of `nv_lock_rm'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2712: error:
   conflicting types for `nv_unlock_rm'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:346: error: 
   previous declaration of `nv_unlock_rm'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2726: error:
   conflicting types for `nv_lock_heap'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:347: error: 
   previous declaration of `nv_lock_heap'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2736: error:
   conflicting types for `nv_unlock_heap'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:348: error: 
   previous declaration of `nv_unlock_heap'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2752: error:
   conflicting types for `nv_post_event'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:363: error: 
   previous declaration of `nv_post_event'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2790: error:
   conflicting types for `nv_get_event'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:364: error: 
   previous declaration of `nv_get_event'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2833: error:
   conflicting types for `nv_agp_init'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:356: error: 
   previous declaration of `nv_agp_init'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2895: error:
   conflicting types for `nv_agp_teardown'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:357: error: 
   previous declaration of `nv_agp_teardown'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2936: error:
   conflicting types for `nv_agp_translate_address'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:358: error: 
   previous declaration of `nv_agp_translate_address'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2968: error:
   conflicting types for `nv_int10h_call'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:351: error: 
   previous declaration of `nv_int10h_call'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2977: error:
   conflicting types for `nv_start_rc_timer'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:360: error: 
   previous declaration of `nv_start_rc_timer'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.c:2998: error:
   conflicting types for `nv_stop_rc_timer'
   /tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.h:361: error: 
   previous declaration of `nv_stop_rc_timer'
   make[3]: *** [/tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv/nv.
   o] Error 1
   make[2]: *** [/tmp/selfgz19415/NVIDIA-Linux-x86-1.0-5336-pkg1/usr/src/nv] Er
   ror 2
   nvidia.ko failed to build!
   make[1]: *** [module] Error 1
   make: *** [module] Error 2
-> Error.
ERROR: Unable to build the NVIDIA kernel module.
ERROR: Installation has failed.  Please see the file
       '/var/log/nvidia-installer.log' for details.  You may find suggestions
       on fixing installation problems in the README available on the Linux
       driver download page at www.nvidia.com.

--------------020800070102090402050200--
