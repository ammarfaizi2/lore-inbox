Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135209AbRDRPhm>; Wed, 18 Apr 2001 11:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135210AbRDRPhc>; Wed, 18 Apr 2001 11:37:32 -0400
Received: from router.ems.chel.su ([195.54.2.222]:38920 "HELO
	router.ems.chel.su") by vger.kernel.org with SMTP
	id <S135209AbRDRPhT>; Wed, 18 Apr 2001 11:37:19 -0400
Date: Wed, 18 Apr 2001 21:12:08 +0600
From: Aleksey I Zavilohin <villain@villain.home.ems.chel.su>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 - Kernel panic
Message-ID: <20010418211208.A1140@villain.home.ems.chel.su>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: villain home
X-Operation-System: Linux 2.4.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oops catced from screen on paper 8-)

ksymoops 2.3.7 on i686 2.4.3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /boot/System.map-2.4.3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

CPU: 0
EIP: 0010: [<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
        eax: b8        ebx: 0 ecx: c122d9dc edx: 0
        esi: 0 edi: 0  ebp: c01f7fa4 esp: c01f7f3c
        ds: 18 es: 18  ss: 18
Stack:  c0119552 0 0 c02265a0 0 c01f7fa4 0 c010ad4c
        c01f7fac v011649f 0 c01163d8 0 1 c02265c0 e
        c01162df c02265c0 0 c0224900 0 c01081b1 c0105120 c01f6000
Call Trace: [<c0119552>] [<c010ad4c>] [<c011649f>] [<c01163d8>] [<c01162df>] [<c01081b1>] [<c0105120>]
        [<c0105120>] [<c0106e14>] [<c0105120>] [<c0105120>] [<c0100018>] [<c0105143>] [<c01051a9>] [<c0105000>]
        [<c0100191>]
Code: Bad EIP value

>>EIP; 00000000 Before first symbol
Trace; c0119552 <timer_bh+222/25c>
Trace; c010ad4c <timer_interrupt+80/e8>
Trace; c011649f <bh_action+1b/60>
Trace; c01163d8 <tasklet_hi_action+3c/60>
Trace; c01162df <do_softirq+3f/64>
Trace; c01081b1 <do_IRQ+a1/b0>
Trace; c0105120 <default_idle+0/28>
Trace; c0105120 <default_idle+0/28>
Trace; c0106e14 <ret_from_intr+0/20>
Trace; c0105120 <default_idle+0/28>
Trace; c0105120 <default_idle+0/28>
Trace; c0100018 <startup_32+18/139>
Trace; c0105143 <default_idle+23/28>
Trace; c01051a9 <cpu_idle+41/54>
Trace; c0105000 <init+0/110>
Trace; c0100191 <L6+0/2>


1 warning issued.  Results may not be reliable.

-- 
You are the only person to ever get this message.
