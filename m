Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWJXIgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWJXIgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWJXIgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:36:01 -0400
Received: from [87.201.200.205] ([87.201.200.205]:51589 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S965115AbWJXIgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:36:00 -0400
Message-ID: <453DD01E.9000905@0Bits.COM>
Date: Tue, 24 Oct 2006 12:34:38 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Thunderbird 3.0a1 (X11/20061017)
MIME-Version: 1.0
To: penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org
Subject: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe my compiler. Anyone building with 4.0.3 ?

home /usr/src/sources/kernel/linux-2.6.18% make ARCH=um CC=gcc\ -v
Using built-in specs.
   SYMLINK arch/um/include/kern_constants.h
   CC      arch/um/sys-i386/user-offsets.s
Using built-in specs.
Target: i686-linux
Configured with: ../gcc-4.0.3/configure --disable-static --prefix=/usr 
--disable-nls --with-system-zlib i686-linux
Thread model: posix
gcc version 4.0.3
  /usr/libexec/gcc/i686-linux/4.0.3/cc1 -quiet -v -Iarch/um/include 
-I/usr/src/sources/kernel/linux-2.6.18/arch/um/include/skas 
-D__arch_um__ -DSUBARCH="i386" -Dvmap=kernel_vmap 
-Din6addr_loopback=kernel_in6addr_loopback -D_FILE_OFFSET_BITS=64 
-D_GNU_SOURCE -D_LARGEFILE64_SOURCE -MD 
arch/um/sys-i386/.user-offsets.s.d arch/um/sys-i386/user-offsets.c 
-quiet -dumpbase user-offsets.c -march=i686 -mpreferred-stack-boundary=2 
-auxbase-strip arch/um/sys-i386/user-offsets.s -Os -Wall -Wundef 
-Wstrict-prototypes -Wno-trigraphs -version -fno-strict-aliasing 
-fno-common -ffreestanding -fverbose-asm -o arch/um/sys-i386/user-offsets.s
ignoring nonexistent directory "/usr/local/include"
ignoring nonexistent directory 
"/usr/lib/gcc/i686-linux/4.0.3/../../../../i686-linux/include"
#include "..." search starts here:
#include <...> search starts here:
  arch/um/include
  /usr/src/sources/kernel/linux-2.6.18/arch/um/include/skas
  /usr/lib/gcc/i686-linux/4.0.3/include
  /usr/include
End of search list.
GNU C version 4.0.3 (i686-linux)
         compiled by GNU C version 3.4.6.
GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
arch/um/sys-i386/user-offsets.c: In function 'foo':
arch/um/sys-i386/user-offsets.c:19: warning: implicit declaration of 
function 'offsetof'
arch/um/sys-i386/user-offsets.c:19: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:20: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:21: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:22: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:23: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:24: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:25: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:26: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:27: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:28: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:29: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:30: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:31: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:32: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:33: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:34: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:35: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:36: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:37: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:38: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:39: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:40: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:41: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:42: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:43: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:44: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:45: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:46: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:47: error: syntax error before 'struct'
arch/um/sys-i386/user-offsets.c:48: error: syntax error before 'struct'
make[1]: *** [arch/um/sys-i386/user-offsets.s] Error 1
make: *** [arch/um/sys-i386/user-offsets.s] Error 2
The mail in /var/mail/mitch has been read.
home /usr/src/sources/kernel/linux-2.6.18%




-------- Original Message --------
Subject: Re: [Fwd: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1]
Date: Tue, 24 Oct 2006 11:31:06 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Mitch <Mitch@0bits.com>
CC: linux-kernel@vger.kernel.org, 
user-mode-linux-devel@lists.sourceforge.net
References: <453DCB33.3060607@0Bits.COM>

Hi,

On 10/24/06, Mitch <Mitch@0bits.com> wrote:
> Yup, did do 'make mrproper'. config attached.

Works for me. Perhaps the UML people can figure out what's going on.

                                     Pekka
