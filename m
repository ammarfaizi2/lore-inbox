Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263068AbSJBMS6>; Wed, 2 Oct 2002 08:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263070AbSJBMS5>; Wed, 2 Oct 2002 08:18:57 -0400
Received: from smtp1.wlink.com.np ([202.79.32.76]:16863 "HELO
	smtp1.wlink.com.np") by vger.kernel.org with SMTP
	id <S263068AbSJBMS4>; Wed, 2 Oct 2002 08:18:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Vicky Shrestha <mail@vickysh.wlink.com.np>
Reply-To: mail@vickysh.wlink.com.np
Organization: WorldLink Communications
Subject: kernel: Unable to handle kernel NULL pointer
Date: Wed, 2 Oct 2002 18:08:24 +0545
User-Agent: KMail/1.4.1
To: isp-tech@isp-tech.com, isp-linux@isp-linux.com
Cc: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210021808.24014.mail@vickysh.wlink.com.np>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am having the a problem with my squid2.4STABLE7 Machine and squid crashed
once a day. I get the following error in /var/log/kern.log:

Sep 29 12:58:37 proxy3 kernel: sending pkt_too_big to self
Oct  1 12:58:02 proxy3 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000008
Oct  1 12:58:02 proxy3 kernel:  printing eip:
Oct  1 12:58:02 proxy3 kernel: c0139a3f
Oct  1 12:58:02 proxy3 kernel: *pde = 00000000
Oct  1 12:58:02 proxy3 kernel: Oops: 0000
Oct  1 12:58:02 proxy3 kernel: ipt_LOG ipt_REDIRECT iptable_nat ip_conntrack
iptable_filter ip_tables 3c59x u
Oct  1 12:58:02 proxy3 kernel: CPU:    0
Oct  1 12:58:02 proxy3 kernel: EIP:    0010:[<c0139a3f>]    Not tainted
Oct  1 12:58:02 proxy3 kernel: EFLAGS: 00010286
Oct  1 12:58:02 proxy3 kernel:
Oct  1 12:58:02 proxy3 kernel: EIP is at fput [kernel] 0xf (2.4.18-3)
Oct  1 12:58:02 proxy3 kernel: eax: d6933240   ebx: d6933240   ecx: cb9547e4
edx: c2023bdc
Oct  1 12:58:02 proxy3 kernel: esi: 00000000   edi: c2023008   ebp: 00000000
esp: d65cbf50
Oct  1 12:58:02 proxy3 kernel: ds: 0018   es: 0018   ss: 0018
Oct  1 12:58:02 proxy3 kernel: Process squid (pid: 14192, stackpage=d65cb000)
Oct  1 12:58:02 proxy3 kernel: Stack: c02c477c 00000203 ffffffff 00000420
c2023bd8 c2023000 c2023008 00000518
Oct  1 12:58:02 proxy3 kernel:        c0146bf5 d65cbfa8 c3ca1e00 c3ca1e00
c014795d d65cbfa8 d65cbfa8 d65ca000
Oct  1 12:58:02 proxy3 kernel:        00000118 00000002 d65cbfa8 c3ca1e00
00000002 00000002 00000000 ce5b7000
Oct  1 12:58:02 proxy3 kernel: Call Trace: [<c0146bf5>] poll_freewait
 [kernel] 0x35
Oct  1 12:58:02 proxy3 kernel: [<c014795d>] sys_poll [kernel] 0x36d
Oct  1 12:58:02 proxy3 kernel: [<c0108923>] system_call [kernel] 0x33
Oct  1 12:58:02 proxy3 kernel:
Oct  1 12:58:02 proxy3 kernel:
Oct  1 12:58:02 proxy3 kernel: Code: 8b 7d 08 ff 4b 14 0f 94 c0 84 c0 0f 84
 a5 00 00 00 53 e8 7a
Oct  1 12:58:02 proxy3 kernel:  <7>sending pkt_too_big to self

-- 
Best regards,


Vicky Shrestha
System Administrator
WorldLink Communications Pvt.Ltd
Jawalakhel, Kathmandu, Nepal.

