Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSDXJPq>; Wed, 24 Apr 2002 05:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSDXJPp>; Wed, 24 Apr 2002 05:15:45 -0400
Received: from [211.101.180.198] ([211.101.180.198]:51205 "EHLO croot.com")
	by vger.kernel.org with ESMTP id <S293680AbSDXJPn>;
	Wed, 24 Apr 2002 05:15:43 -0400
Message-ID: <3CC677B4.6AB79408@croot.com>
Date: Wed, 24 Apr 2002 17:15:32 +0800
From: "Pan,Gaoyong" <gypan@croot.com>
Reply-To: gypan@croot.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: zh-CN
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug report
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

yestoday, my system crashed , bug report to you.

ksymoops >> kmsg  &  part of cat /var/log/messages in the fowling :

Thx

_____________________________________________________


Apr 23 19:55:01 web kernel: Unable to handle kernel paging request at
virtual address 2e72656a
Apr 23 19:55:01 web kernel:  printing eip:
Apr 23 19:55:01 web kernel: c0114e62
Apr 23 19:55:01 web kernel: *pde = 00000000
Apr 23 19:55:01 web kernel: Oops: 0000
Apr 23 19:55:01 web kernel: CPU:    0
Apr 23 19:55:01 web kernel: EIP:    0010:[__wake_up+34/160]
Apr 23 19:55:01 web kernel: EFLAGS: 00010003
Apr 23 19:55:01 web kernel: eax: c0ff97e4   ebx: 2e72656e   ecx:
00000001   edx: 00000001
Apr 23 19:55:01 web kernel: esi: cd64ee00   edi: 00000001   ebp:
cc639ef4   esp: cc639edc
Apr 23 19:55:01 web kernel: ds: 0018   es: 0018   ss: 0018
Apr 23 19:55:01 web kernel: Process python (pid: 21112,
stackpage=cc639000)
Apr 23 19:55:01 web kernel: Stack: 00000282 00000001 c0ff97e0 c0ff97e0
cd64ee00 cd64ee00 ced18860 c013f021
Apr 23 19:55:01 web kernel:        cc8d0de0 c17211e0 c013f04e cd64ee00
00000001 00000000 c0136089 cd64ee00
Apr 23 19:55:01 web kernel:        cc8d0de0 c85f4bfc 00000001 00000000
c1723c14 cc8d0de0 00000000 00000001
Apr 23 19:55:01 web kernel: Call Trace: [pipe_release+113/144]
[pipe_read_release+14/32] [fput+57/192] [filp_close+83/96]
[put_files_struct+76/208]
Apr 23 19:55:01 web kernel:    [do_exit+209/496] [do_softirq+75/144]
[do_page_fault+0/1168] [system_call+51/56]
Apr 23 19:55:01 web kernel:
Apr 23 19:55:01 web kernel: Code: 8b 4b fc 8b 01 85 45 ec 74 4e 31 c0 9c
5e fa c7 01 00 00 00
Apr 23 19:55:01 web kernel:  <1>Unable to handle kernel paging request
at virtual address 2e72656a
Apr 23 19:55:01 web kernel:  printing eip:
Apr 23 19:55:01 web kernel: c0114e62
Apr 23 19:55:01 web kernel: *pde = 00000000
Apr 23 19:55:01 web kernel: Oops: 0000
Apr 23 19:55:01 web kernel: CPU:    0
Apr 23 19:55:01 web kernel: EIP:    0010:[__wake_up+34/160]
Apr 23 19:55:01 web kernel: EFLAGS: 00010003
Apr 23 19:55:01 web kernel: eax: c0ff97e4   ebx: 2e72656e   ecx:
00000001   edx: 00000001
Apr 23 19:55:01 web kernel: esi: c833b2c0   edi: 00000001   ebp:
c9219ef4   esp: c9219edc
Apr 23 19:55:01 web kernel: ds: 0018   es: 0018   ss: 0018
Apr 23 19:55:01 web kernel: Process python (pid: 21113,
stackpage=c9219000)
Apr 23 19:55:01 web kernel: Stack: 00000282 00000001 c0ff97e0 c0ff97e0
c833b2c0 c833b2c0 ced18360 c013f021
Apr 23 19:55:01 web kernel:        c5a069c0 c17211e0 c013f04e c833b2c0
00000001 00000000 c0136089 c833b2c0
Apr 23 19:55:01 web kernel:        c5a069c0 c333fbfc 00000001 00000000
c1723c14 c5a069c0 00000000 00000001
Apr 23 19:55:02 web kernel: Call Trace: [pipe_release+113/144]
[pipe_read_release+14/32] [fput+57/192] [filp_close+83/96]
[put_files_struct+76/208]
Apr 23 19:55:02 web kernel:    [do_exit+209/496] [do_softirq+75/144]
[do_page_fault+0/1168] [system_call+51/56]
Apr 23 19:55:02 web kernel:
Apr 23 19:55:02 web kernel: Code: 8b 4b fc 8b 01 85 45 ec 74 4e 31 c0 9c
5e fa c7 01 00 00 00
Apr 23 20:00:00 web kernel:  <1>Unable to handle kernel paging request
at virtual address 2e72656a
Apr 23 20:00:00 web kernel:  printing eip:
Apr 23 20:00:00 web kernel: c0114e62
Apr 23 20:00:00 web kernel: *pde = 00000000
Apr 23 20:00:00 web kernel: Oops: 0000
Apr 23 20:00:00 web kernel: CPU:    0
Apr 23 20:00:00 web kernel: EIP:    0010:[__wake_up+34/160]
Apr 23 20:00:00 web kernel: EFLAGS: 00010003
Apr 23 20:00:00 web kernel: eax: c0ff97e4   ebx: 2e72656e   ecx:
00000001   edx: 00000001
Apr 23 20:00:00 web kernel: esi: c5dbb860   edi: 00000001   ebp:
cea81ef4   esp: cea81edc
Apr 23 20:00:00 web kernel: ds: 0018   es: 0018   ss: 0018
Apr 23 20:00:00 web kernel: Process python (pid: 21131,
stackpage=cea81000)
Apr 23 20:00:00 web kernel: Stack: 00000282 00000001 c0ff97e0 c0ff97e0
c5dbb860 c5dbb860 ca669540 c013f021
Apr 23 20:00:00 web kernel:        c3a430c0 c17211e0 c013f04e c5dbb860
00000001 00000000 c0136089 c5dbb860
Apr 23 20:00:00 web kernel:        c3a430c0 c8be7bfc 00000001 00000000
c1723c14 c3a430c0 00000000 00000001
Apr 23 20:00:00 web kernel: Call Trace: [pipe_release+113/144]
[pipe_read_release+14/32] [fput+57/192] [filp_close+83/96]
[put_files_struct+76/208]
Apr 23 20:00:00 web kernel:    [do_exit+209/496] [do_softirq+75/144]
[do_page_fault+0/1168] [system_call+51/56]
Apr 23 20:00:00 web kernel:
Apr 23 20:00:00 web kernel: Code: 8b 4b fc 8b 01 85 45 ec 74 4e 31 c0 9c
5e fa c7 01 00 00 00
Apr 23 20:00:00 web kernel:  <1>Unable to handle kernel paging request
at virtual address 77656e5b
Apr 23 20:00:00 web kernel:  printing eip:
Apr 23 20:00:00 web kernel: c0114e62
Apr 23 20:00:00 web kernel: *pde = 00000000
Apr 23 20:00:00 web kernel: Oops: 0000
Apr 23 20:00:00 web kernel: CPU:    0
Apr 23 20:00:00 web kernel: EIP:    0010:[__wake_up+34/160]
Apr 23 20:00:00 web kernel: EFLAGS: 00010887
Apr 23 20:00:00 web kernel: eax: c0ff97e4   ebx: 77656e5f   ecx:
00000001   edx: 00000001
Apr 23 20:00:00 web kernel: esi: c5dbb040   edi: 00000001   ebp:
c3c95ef4   esp: c3c95edc
Apr 23 20:00:00 web kernel: ds: 0018   es: 0018   ss: 0018
Apr 23 20:00:00 web kernel: Process python (pid: 21132,
stackpage=c3c95000)
Apr 23 20:00:00 web kernel: Stack: 00000282 00000001 c0ff97e0 c0ff97e0
c5dbb040 c5dbb040 ca669640 c013f021
Apr 23 20:00:00 web kernel:        c24175c0 c17211e0 c013f04e c5dbb040
00000001 00000000 c0136089 c5dbb040
Apr 23 20:00:00 web kernel:        c24175c0 c28e7bfc 00000001 00000000
c1723c14 c24175c0 00000000 00000001
Apr 23 20:00:00 web kernel: Call Trace: [pipe_release+113/144]
[pipe_read_release+14/32] [fput+57/192] [filp_close+83/96]
[put_files_struct+76/208]
Apr 23 20:00:00 web kernel:    [do_exit+209/496] [do_softirq+75/144]
[do_page_fault+0/1168] [system_call+51/56]
Apr 23 20:00:00 web kernel:




