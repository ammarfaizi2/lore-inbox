Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289422AbSAJM1n>; Thu, 10 Jan 2002 07:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289421AbSAJM1d>; Thu, 10 Jan 2002 07:27:33 -0500
Received: from blueberrysolutions.com ([195.165.170.195]:10112 "EHLO
	blueberrysolutions.com") by vger.kernel.org with ESMTP
	id <S289422AbSAJM1Y>; Thu, 10 Jan 2002 07:27:24 -0500
Date: Thu, 10 Jan 2002 14:27:18 +0200 (EET)
From: Tony Glader <Tony.Glader@blueberrysolutions.com>
X-X-Sender: <teg@blueberrysolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.17 Kernel Oops
Message-ID: <Pine.LNX.4.33.0201101419280.3939-100000@blueberrysolutions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running Kernel 2.4.17 in a classic Pentium 75MHz and I have problems 
with it (with 2.2 series it works fine). After a while from boot I get lot 
of kernel oops like this (if I have big load oops's will come more often):

--- 8< ---
Jan  9 17:23:34 firewall kernel: Unable to handle kernel paging request at 
virtual address 00001200
Jan  9 17:23:34 firewall kernel:  printing eip:
Jan  9 17:23:34 firewall kernel: 00001200
Jan  9 17:23:34 firewall kernel: *pde = 00000000
Jan  9 17:23:34 firewall kernel: Oops: 0000
Jan  9 17:23:34 firewall kernel: CPU:    0
Jan  9 17:23:34 firewall kernel: EIP:    0010:[<00001200>]    Not tainted
Jan  9 17:23:34 firewall kernel: EFLAGS: 00013202
Jan  9 17:23:34 firewall kernel: eax: 00000001   ebx: c024ce60   ecx: 
c380b000   edx: 00000012
Jan  9 17:23:34 firewall kernel: esi: 00000012   edi: 00000018   ebp: 
00000361   esp: c11f7f28
Jan  9 17:23:34 firewall kernel: ds: 0018   es: 0018   ss: 0018
Jan  9 17:23:34 firewall kernel: Process kswapd (pid: 4, 
stackpage=c11f7000)
Jan  9 17:23:34 firewall kernel: Stack: c109eec0 c0126983 c024ce60 
00000197 c11f6000 00000051 000001d0 c01fd4c8 
Jan  9 17:23:34 firewall kernel:        c0265ee0 c11e35a0 c10c7590 
00000000 00000020 000001d0 00000006 00002946 
Jan  9 17:23:34 firewall kernel:        c0126af6 00000006 0000000e 
c01fd4c8 00000006 000001d0 c01fd4c8 00000000 
Jan  9 17:23:34 firewall kernel: Call Trace: [shrink_cache+691/752] 
[shrink_caches+86/128] [try_to_free_pages+48
/80] [kswapd_balance_pgdat+68/144] [kswapd_balance+22/48] 
Jan  9 17:23:34 firewall kernel:    [kswapd+161/192] [kswapd+0/192] 
[kernel_thread+43/64] 

--- 8< ---

Isn't 2.4 series compatible with Pentium Classic?

