Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbUAXExv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 23:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266861AbUAXExv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 23:53:51 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:58836 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S266751AbUAXExs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 23:53:48 -0500
From: Eric <eric@cisu.net>
To: linux-kernel@vger.kernel.org
Subject: Kernels > 2.6.1-mm3 do not boot.
Date: Fri, 23 Jan 2004 22:53:08 -0600
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401232253.08552.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
	I am unable to boot with kernels greater than 2.6.1-mm3. I do not recall if 
mm3 booted or not, but I know for sure that mm4 and rc1-mm1 are broken for 
me. When I try to boot the selected kernel I see uncompressing 
kernel.....then booting kernel.
and then, nothing. It stops all activity. I still see the message 
uncompressing kernel, the screen doesn't go blank or anything. 
	The new CPU options confuse me, (Why multiple CPU's?) Usually that is the 
problem when the kernel cant boot so early. I tried a kernel with ONLY 386 
selected, ONLY athlon selected, and one with all the cpu's athlon and below 
(architecture wise, not below menu-wise)
	I tried setting/unsetting the regparam and booting with acpi=off and 
disabling/enabling PnP in my BIOS. I am 
	What has changed in these later versions?

MSI-K7d Master
2 x Athlon MP 2000
1GB Ram

eric:/home/bot403 # gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/3.3/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info 
--mandir=/usr/share/man --libdir=/usr/lib 
--enable-languages=c,c++,f77,objc,java,ada --disable-checking --enable-libgcj 
--with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib 
--with-system-zlib --enable-shared --enable-__cxa_atexit i486-suse-linux
Thread model: posix
gcc version 3.3 20030226 (prerelease) (SuSE Linux)

eric:/home/bot403 #cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 2000+
stepping        : 1
cpu MHz         : 1667.562
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 1642.49

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP
stepping        : 1
cpu MHz         : 1667.562
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 1662.97


-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
