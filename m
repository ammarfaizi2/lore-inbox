Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292919AbSCDVo6>; Mon, 4 Mar 2002 16:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292920AbSCDVot>; Mon, 4 Mar 2002 16:44:49 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:25901 "EHLO
	tsmtp9.mail.isp") by vger.kernel.org with ESMTP id <S292919AbSCDVoi>;
	Mon, 4 Mar 2002 16:44:38 -0500
Date: Mon, 4 Mar 2002 22:42:11 +0100
From: Diego Calleja <DiegoCG@teleline.es>
To: davej@suse.de, andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre1-aa1 problems
Message-Id: <20020304224211.12c5e271.DiegoCG@teleline.es>
In-Reply-To: <20020303233952.A11129@suse.de>
In-Reply-To: <20020303214135.7fb8f07c.DiegoCG@teleline.es>
	<20020303233952.A11129@suse.de>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another X hangup today, after leaving the machine with screensaver -just as the first report of my previous message-
In the screen there is the image of the screensaver stopped.
Same modules, same 2.4.19-pre1aa1 kernel.


ksymoops 2.4.3 on i686 2.4.19pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19pre1/ (default)
     -m /boot/System.map-2.4.19pre1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Mar  4 21:10:56 localhost kernel: CPU:    0
Mar  4 21:10:56 localhost kernel: EIP:    0010:[__pollwait+108/140]    Tainted: P
Mar  4 21:10:56 localhost kernel: EFLAGS: 00013286
Mar  4 21:10:56 localhost kernel: eax: c15d4000   ebx: c1f52000   ecx: c0206690   edx: ffffffff
Mar  4 21:10:56 localhost kernel: esi: c15d5f68   edi: c15e1ee0   ebp: c1289ebc   esp: c15d5f00
Mar  4 21:10:56 localhost kernel: ds: 0018   es: 0018   ss: 0018
Mar  4 21:10:56 localhost kernel: Process XFree86 (pid: 316, stackpage=c15d5000)
Mar  4 21:10:56 localhost kernel: Stack: c1340740 c15e1ee0 00000000 c15d5f70 c01d7d43 c15e1ee0 c1289ebc c15d5f68
Mar  4 21:10:56 localhost kernel:        c15e1ee0 c01a078f c15e1ee0 c1289ea0 c15d5f68 00000000 c013aec6 c15e1ee0
Mar  4 21:10:56 localhost kernel:        c15d5f68 00000100 00000020 c0a95a20 00000145 00000002 c15d4000 7fffffff
Mar  4 21:10:57 localhost kernel: Call Trace: [unix_poll+35/132] [sock_poll+35/40] [do_select+226/476] [sys_select+820/1156] [system_call+51/64]
Mar  4 21:10:57 localhost kernel: Code: 89 3a 89 6a 14 8d 4a 04 c7 42 04 00 00 00 00 89 41 04 89 ca
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 3a                     mov    %edi,(%edx)
Code;  00000002 Before first symbol
   2:   89 6a 14                  mov    %ebp,0x14(%edx)
Code;  00000004 Before first symbol
   5:   8d 4a 04                  lea    0x4(%edx),%ecx
Code;  00000008 Before first symbol
   8:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)
Code;  0000000e Before first symbol
   f:   89 41 04                  mov    %eax,0x4(%ecx)
Code;  00000012 Before first symbol
  12:   89 ca                     mov    %ecx,%edx


1 warning issued.  Results may not be reliable.
