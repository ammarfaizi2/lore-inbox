Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280395AbRKESgv>; Mon, 5 Nov 2001 13:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281273AbRKESgl>; Mon, 5 Nov 2001 13:36:41 -0500
Received: from adsl-216-102-162-162.dsl.snfc21.pacbell.net ([216.102.162.162]:63375
	"EHLO janus") by vger.kernel.org with ESMTP id <S280395AbRKESgY>;
	Mon, 5 Nov 2001 13:36:24 -0500
Content-Transfer-Encoding: 7BIT
Subject: Oops when syncing Sony Clie 760 with USB cradle
To: linux-kernel@vger.kernel.org
X-Originating-IP: [217.224.158.54]
Date: Mon, 05 Nov 2001 10:36:16 -800
MIME-Version: 1.0
From: Stephan Gutschke <stephan@gutschke.com>
Content-Type: text/plain; charset=US-ASCII
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Message-Id: <E160obZ-0001bO-00@janus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
if anything else is needed, let me know.

Stephan

P.S.:
Tainted, because vfat taints the kernel:
Using /lib/modules/2.4.14-pre8/kernel/fs/vfat/vfat.o
Warning: loading /lib/modules/2.4.14-pre8/kernel/fs/vfat/vfat.o will taint the kernel: no license


ksymoops 2.4.3 on i686 2.4.14-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14-pre8/ (default)
     -m /boot/System.map-2.4.14-pre8 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.14-pre8 failed
ksymoops: No such file or directory
Nov  5 19:58:36 yvette kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000014
Nov  5 19:58:36 yvette kernel: c01f2193
Nov  5 19:58:36 yvette kernel: *pde = 00000000
Nov  5 19:58:36 yvette kernel: Oops: 0002
Nov  5 19:58:36 yvette kernel: CPU:    0
Nov  5 19:58:36 yvette kernel: EIP:    0010:[visor_open+163/276]    Tainted: P 
Nov  5 19:58:36 yvette kernel: EFLAGS: 00210202
Nov  5 19:58:36 yvette kernel: eax: c1848800   ebx: df40ec94   ecx: df40ecf0   edx: 00000000
Nov  5 19:58:36 yvette kernel: esi: df40ec00   edi: 00000000   ebp: df40ecf0   esp: dbbd9eb0
Nov  5 19:58:36 yvette kernel: ds: 0018   es: 0018   ss: 0018
Nov  5 19:58:36 yvette kernel: Process jpilot (pid: 430, stackpage=dbbd9000)
Nov  5 19:58:36 yvette kernel: Stack: dc07b000 dbb25ae0 dedfd460 c180e2e0 c01f0864 df40ec94 dbb25ae0 00000000 
Nov  5 19:58:36 yvette kernel:        00000000 c018b98b dc07b000 dbb25ae0 00000000 dbb25ae0 dedfd460 c180e2e0 
Nov  5 19:58:36 yvette kernel:        4c99880a 08020007 dc07b000 c18094a0 dbbd9f38 dbbd9f38 dee019c0 00000000 
Nov  5 19:58:36 yvette kernel: Call Trace: [serial_open+152/168] [tty_open+511/872] [link_path_walk+1553/1752] [permission+43/48] [chrdev_open+62/76] 
Nov  5 19:58:36 yvette kernel: Code: 89 42 14 8b 4e 04 0f b6 43 24 c1 e0 0f 8b 11 c1 e2 08 09 c2 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 42 14                  mov    %eax,0x14(%edx)
Code;  00000002 Before first symbol
   3:   8b 4e 04                  mov    0x4(%esi),%ecx
Code;  00000006 Before first symbol
   6:   0f b6 43 24               movzbl 0x24(%ebx),%eax
Code;  0000000a Before first symbol
   a:   c1 e0 0f                  shl    $0xf,%eax
Code;  0000000c Before first symbol
   d:   8b 11                     mov    (%ecx),%edx
Code;  0000000e Before first symbol
   f:   c1 e2 08                  shl    $0x8,%edx
Code;  00000012 Before first symbol
  12:   09 c2                     or     %eax,%edx


1 warning and 1 error issued.  Results may not be reliable.

