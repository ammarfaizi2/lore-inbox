Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVBCJvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVBCJvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 04:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVBCJvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 04:51:21 -0500
Received: from geezer.digi-net.gr ([62.169.208.176]:29854 "EHLO
	geezer.digi-net.gr") by vger.kernel.org with ESMTP id S262372AbVBCJvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 04:51:06 -0500
Message-ID: <4201F401.7080401@digi-net.gr>
Date: Thu, 03 Feb 2005 11:50:57 +0200
From: Sakellarios Gerakios <s.gerakios@digi-net.gr>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops: 0000
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am not sure if sending you this Oops message form my Kernel is 
politically correct but here you go....

If you can help, I would greatly appreciate it.

Thank you in advance,


Larry


Feb  2 14:37:45 geezer kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000074
Feb  2 14:37:45 geezer kernel:  printing eip:
Feb  2 14:37:45 geezer kernel: c0143c53
Feb  2 14:37:45 geezer kernel: *pde = 00000000
Feb  2 14:37:45 geezer kernel: Oops: 0000
Feb  2 14:37:45 geezer kernel: parport_pc lp parport autofs e100 
iptable_nat ip_conntrack iptable_mangle ipt_REJECT iptable_filter i
p_tables keybdev mousedev hid input usb-uhci usbcore ext3
Feb  2 14:37:45 geezer kernel: CPU:    0
Feb  2 14:37:45 geezer kernel: EIP:    0060:[<c0143c53>]    Not tainted
Feb  2 14:37:45 geezer kernel: EFLAGS: 00010216
Feb  2 14:37:45 geezer kernel:
Feb  2 14:37:45 geezer kernel: EIP is at page_referenced [kernel] 0xe3 
(2.4.20-8)
Feb  2 14:37:45 geezer kernel: eax: c1057788   ebx: 00000818   ecx: 
00000000   edx: 0000aeeb
Feb  2 14:37:45 geezer kernel: esi: c030d24c   edi: c1125c24   ebp: 
00000003   esp: c1afff84
Feb  2 14:37:45 geezer kernel: ds: 0068   es: 0068   ss: 0068
Feb  2 14:37:45 geezer kernel: Process kscand/Normal (pid: 7, 
stackpage=c1aff000)
Feb  2 14:37:45 geezer kernel: Stack: c1afffa0 00000000 00000001 
c1afffb4 c11467f0 c11467f0 c030d24c c1125c24
Feb  2 14:37:45 geezer kernel:        00000003 c013c68e c1afe000 
c0125ba0 00000001 00000003 c1afe000 c030d100
Feb  2 14:37:45 geezer kernel:        c1afe000 c013d564 c030d100 
00000003 00000001 c025ef1b 000009c4 c013d4b0
Feb  2 14:37:45 geezer kernel: Call Trace:   [<c013c68e>] 
scan_active_list [kernel] 0x3e (0xc1afffa8))
Feb  2 14:37:45 geezer kernel: [<c0125ba0>] process_timeout [kernel] 0x0 
(0xc1afffb0))
Feb  2 14:37:45 geezer kernel: [<c013d564>] kscand [kernel] 0xb4 
(0xc1afffc8))
Feb  2 14:37:45 geezer kernel: [<c013d4b0>] kscand [kernel] 0x0 
(0xc1afffe0))
Feb  2 14:37:45 geezer kernel: [<c010742d>] kernel_thread_helper 
[kernel] 0x5 (0xc1affff0))
Feb  2 14:37:45 geezer kernel:
Feb  2 14:37:45 geezer kernel:
Feb  2 14:37:46 geezer kernel: Code: 8b 41 74 39 41 60 b8 01 00 00 00 0f 
43 44 24 04 89 44 24 04
