Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUHaQX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUHaQX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUHaQX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:23:59 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:17868 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262071AbUHaQXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:23:22 -0400
Message-ID: <4134A5EE.5090003@blueyonder.co.uk>
Date: Tue, 31 Aug 2004 17:23:10 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm2 nvidia breakage
Content-Type: multipart/mixed;
 boundary="------------010906020307060402010302"
X-OriginalArrivalTime: 31 Aug 2004 16:23:43.0875 (UTC) FILETIME=[E24BD530:01C48F76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010906020307060402010302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Log attached.
Regards
Sid.

-- 
Sid Boyce ... Hamradio G3VBV and Keen Flyer
Linux only shop.

--------------010906020307060402010302
Content-Type: text/plain;
 name="nvidia-installer.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nvidia-installer.log"

nvidia-installer log file '/var/log/nvidia-installer.log'
creation time: Tue Aug 31 17:05:05 2004

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
  X install prefix        : /usr/X11R6
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
   6111).  As part of installing this driver (version: 1.0-6111), the existing 
   driver will be uninstalled.  Are you sure you want to continue? ('no' will a
   bort installation) (Answer: Yes)
-> No precompiled kernel interface was found to match your kernel; would you li
   ke the installer to attempt to download a kernel interface for your kernel f
   rom the NVIDIA ftp site (ftp://download.nvidia.com)? (Answer: Yes)
-> No matching precompiled kernel interface was found on the NVIDIA ftp site;
   this means that the installer will need to compile a kernel interface for
   your kernel.
-> Kernel source path: '/lib/modules/2.6.9-rc1-mm2/build'
-> Performing cc_version_check with CC="cc".
-> Performing rivafb check.
-> Performing rivafb module check.
-> Cleaning kernel module build directory.
   executing: 'cd ./usr/src/nv; make clean'...
   rm -f -f nv.o os-agp.o os-interface.o os-registry.o nv.o os-agp.o os-interfa
   ce.o os-registry.o nvidia.mod.o
   rm -f -f build-in.o nv-linux.o *.d .*.{cmd,flags}
   rm -f -f nvidia.{o,ko,mod.{o,c}} nv_compiler.h *~
-> Building kernel module:
   executing: 'cd ./usr/src/nv; make module SYSSRC=/lib/modules/2.6.9-rc1-mm2/b
   uild SYSOUT=/lib/modules/2.6.9-rc1-mm2/build'...
   
   NVIDIA: calling KBUILD...
   make -C /lib/modules/2.6.9-rc1-mm2/build		\
   KBUILD_SRC=/usr/src/linux-2.6.9-rc1-mm2	     KBUILD_VERBOSE=1	\
   KBUILD_CHECK= KBUILD_EXTMOD="/tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1
   /usr/src/nv"	\
           -f /usr/src/linux-2.6.9-rc1-mm2/Makefile modules
   mkdir -p /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/.tmp_ver
   sions
   make -f /usr/src/linux-2.6.9-rc1-mm2/scripts/Makefile.build obj=/tmp/selfgz1
   2280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv
   echo \#define NV_COMPILER \"`cc -v 2>&1 | tail -n 1`\" > /tmp/selfgz12280/NV
   IDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv_compiler.h
     cc -Wp,-MD,/tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/.nv.
   o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/usr/
   src/linux-2.6.9-rc1-mm2/include  -I/tmp/selfgz12280/NVIDIA-Linux-x86-1.0-611
   1-pkg1/usr/src/nv -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-alias
   ing -fno-common -pipe -msoft-float -mpreferred-stack-boundary=2 -fno-unit-at
   -a-time -march=athlon -mr
   egparm=3 -I/usr/src/linux-2.6.9-rc1-mm2/include/asm-i386/mach-default -Iincl
   ude/asm-i386/mach-default -O2 -g  -I/tmp/selfgz12280/NVIDIA-Linux-x86-1.0-61
   11-pkg1/usr/src/nv -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-s
   ubscripts -Wparentheses -Wpointer-arith -Wno-multichar -Werror -O -fno-commo
   n -MD -Wno-cast-qual -Wno-error -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE 
   -DNTRM -D_GNU_SOURCE -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE -DNV_MAJOR_
   VERSION=1 -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=6111 -DNV_UNIX -DNV_LINUX -DN
   V_INT64_OK -DNVCPU_X86 -UDEBUG -U_DEBUG -DNDEBUG -DNV_CHANGE_PAGE_ATTR_PRESE
   NT -DNV_CLASS_SIMPLE_PRESENT -DMODULE -DKBUILD_BASENAME=nv -DKBUILD_MODNAME=
   nvidia -c -o /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/.tmp
   _nv.o /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c
   In file included from include/linux/list.h:7,
                    from include/linux/wait.h:23,
                    from include/asm/semaphore.h:41,
                    from include/linux/sched.h:19,
                    from include/linux/module.h:10,
                    from /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/sr
   c/nv/nv-linux.h:52,
                    from /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/sr
   c/nv/nv.c:14:
   include/linux/prefetch.h: In function `prefetch_range':
   include/linux/prefetch.h:62: warning: pointer of type `void *' used in arith
   metic
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c: In function
   `nvos_find_agp_by_class':
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c:642: warning
   : implicit declaration of function `pci_find_class'
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c:642: warning
   : assignment makes pointer from integer without a cast
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c:653: warning
   : assignment makes pointer from integer without a cast
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c: In function
   `nvos_count_devices':
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c:3486: warnin
   g: assignment makes pointer from integer without a cast
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c:3491: warnin
   g: assignment makes pointer from integer without a cast
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c: In function
   `nv_acpi_event':
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c:3697: error:
   `PM_SAVE_STATE' undeclared (first use in this function)
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c:3697: error:
   (Each undeclared identifier is reported only once
   /tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.c:3697: error:
   for each function it appears in.)
   make[4]: *** [/tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/nv.
   o] Error 1
   make[3]: *** [_module_/tmp/selfgz12280/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/sr
   c/nv] Error 2
   make[2]: *** [modules] Error 2
   NVIDIA: left KBUILD.
   nvidia.ko failed to build!
   make[1]: *** [module] Error 1
   make: *** [module] Error 2
-> Error.
ERROR: Unable to build the NVIDIA kernel module.
ERROR: Installation has failed.  Please see the file
       '/var/log/nvidia-installer.log' for details.  You may find suggestions
       on fixing installation problems in the README available on the Linux
       driver download page at www.nvidia.com.

--------------010906020307060402010302--
