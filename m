Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUBYRIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUBYRIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:08:30 -0500
Received: from mailsrv.internetpro.net ([208.35.149.110]:179 "HELO
	mail.internetpro.net") by vger.kernel.org with SMTP id S261439AbUBYRIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:08:15 -0500
Subject: Kernel 2.4.24 #1 SMP Oops
From: Jeremy S Lowery <jlowery@internetpro.net>
Reply-To: jlowery@internetpro.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Internet Solutions
Message-Id: <1077728894.8142.8.camel@mythbox.internetpro.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 11:08:14 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sudden death of this server. Console locked, network went down. hard
crash, had to reset.

On the distro ML, said that quite possibly one of the cpu's was going
down but to run this through lkml to be sure.
relevant info

#ksymoops kern.log
ksymoops 2.4.9 on i686 2.4.24.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24/ (default)
     -m /boot/System.map-2.4.24 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid
lsmod file?
Feb 25 07:26:21 mail3 kernel: CPU 0: Machine Check Exception:
0000000000000004
Feb 25 07:26:21 mail3 kernel: Bank 4: b200000000040151
Feb 25 07:26:21 mail3 kernel: Kernel panic: CPU context corrupt
Feb 25 08:02:39 mail3 kernel: cpu: 0, clocks: 1002267, slice: 334089
Feb 25 08:02:39 mail3 kernel: cpu: 1, clocks: 1002267, slice: 334089
Feb 25 08:02:39 mail3 kernel: 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html

2 warnings issued.  Results may not be reliable.

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 801.827
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1599.07

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 801.827
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1602.35

Please CC to jlowery@internetpro.net

Jeremy Lowery

