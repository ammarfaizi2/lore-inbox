Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279022AbRJVWjW>; Mon, 22 Oct 2001 18:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279025AbRJVWi7>; Mon, 22 Oct 2001 18:38:59 -0400
Received: from femail7.sdc1.sfba.home.com ([24.0.95.87]:16336 "EHLO
	femail7.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S279022AbRJVWic>; Mon, 22 Oct 2001 18:38:32 -0400
Subject: 2.4.12 w/ preempt patch
From: steve <sdroemen@home.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-+Mhsu00qvfWFfNm0mKf1"
X-Mailer: Evolution/0.15 (Preview Release)
Date: 22 Oct 2001 17:43:14 -0500
Message-Id: <1003790595.3536.9.camel@lws01>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+Mhsu00qvfWFfNm0mKf1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


I got a bug error in my syslog  My machine had been running about 1 day.
it is the 2.4.12 kernel with the preempt-kernel-rml-2.4.12-1.patch 
patch from http://www.tech9.net/rml/linux

anybody know what went wrong, and how to fix it?

thanks,
steve


--=-+Mhsu00qvfWFfNm0mKf1
Content-Type: text/plain
Content-Disposition: attachment; filename=kernel-2.4.12-preempt.log-bug
Content-Transfer-Encoding: 7bit


Oct 21 06:30:05 lws01 kernel: kernel BUG at slab.c:1241!
Oct 21 06:30:05 lws01 kernel: invalid operand: 0000
Oct 21 06:30:05 lws01 kernel: CPU:    0
Oct 21 06:30:05 lws01 kernel: EIP:    0010:[kmem_cache_alloc+331/472]    Tainted: P 
Oct 21 06:30:05 lws01 kernel: EFLAGS: 00010086
Oct 21 06:30:05 lws01 kernel: eax: 0000001b   ebx: caf58094   ecx: ffffffe2   edx: c2c74000
Oct 21 06:30:05 lws01 kernel: esi: c1407148   edi: 00000044   ebp: 00000246   esp: c2c75f24
Oct 21 06:30:05 lws01 kernel: ds: 0018   es: 0018   ss: 0018
Oct 21 06:30:05 lws01 kernel: Process mandb (pid: 4633, stackpage=c2c75000)
Oct 21 06:30:05 lws01 kernel: Stack: c02806cf 000004d9 caf58e8c fffffff4 caf58e98 c2c74000 00000044 caf58098 
Oct 21 06:30:05 lws01 kernel:        c01122d3 c1407148 000003f0 cd45c000 c1ef4a64 cd9a3fc4 c15f91dc cfd8c810 
Oct 21 06:30:05 lws01 kernel:        c8741a38 caf58e98 cfd8c7f4 cfd8c404 c0112ccb 00000011 cd45c000 c2c74000 
Oct 21 06:30:05 lws01 kernel: Call Trace: [copy_mm+435/812] [do_fork+1107/1796] [sys_fork+19/24] [system_call+51/64] 
Oct 21 06:30:05 lws01 kernel: 
Oct 21 06:30:05 lws01 kernel: Code: 0f 0b 83 c4 08 f6 46 1d 04 74 55 b8 a5 c2 0f 17 87 03 3d 71 
Oct 21 06:30:05 lws01 kernel:  kernel BUG at slab.c:1241!
Oct 21 06:30:05 lws01 kernel: invalid operand: 0000
Oct 21 06:30:05 lws01 kernel: CPU:    0
Oct 21 06:30:05 lws01 kernel: EIP:    0010:[kmem_cache_alloc+331/472]    Tainted: P 
Oct 21 06:30:05 lws01 kernel: EFLAGS: 00010082
Oct 21 06:30:05 lws01 kernel: eax: 0000001b   ebx: caf58094   ecx: ffffffe5   edx: c25c8000
Oct 21 06:30:05 lws01 kernel: esi: c1407148   edi: 00000044   ebp: 00000246   esp: c25c9f38
Oct 21 06:30:05 lws01 kernel: ds: 0018   es: 0018   ss: 0018
Oct 21 06:30:05 lws01 kernel: Process mgetty (pid: 6276, stackpage=c25c9000)
Oct 21 06:30:05 lws01 kernel: Stack: c02806cf 000004d9 40093000 c27b5610 40091000 c1549934 00000044 caf58098 
Oct 21 06:30:05 lws01 kernel:        c0126ccd c1407148 000003f0 40093000 c27b5610 40091000 c25c9fbc 00000002 
Oct 21 06:30:05 lws01 kernel:        c0ca8c24 c25c9fb8 000000a0 c0127051 c1549934 c25c9fb8 40091000 40093000 
Oct 21 06:30:05 lws01 kernel: Call Trace: [mprotect_fixup+677/1268] [sys_mprotect+309/548] [system_call+51/64] 
Oct 21 06:30:05 lws01 kernel: 
Oct 21 06:30:05 lws01 kernel: Code: 0f 0b 83 c4 08 f6 46 1d 04 74 55 b8 a5 c2 0f 17 87 03 3d 71 


--=-+Mhsu00qvfWFfNm0mKf1--

