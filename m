Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266190AbUBJSX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUBJSTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:19:53 -0500
Received: from cabm.rutgers.edu ([192.76.178.143]:37646 "EHLO
	lemur.cabm.rutgers.edu") by vger.kernel.org with ESMTP
	id S266164AbUBJSRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:17:54 -0500
Date: Tue, 10 Feb 2004 13:17:53 -0500 (EST)
From: Ananda Bhattacharya <anandab@cabm.rutgers.edu>
To: Ananda Bhattacharya <anandab@cabm.rutgers.edu>,
       Hunter Moseley <hunter@cabm.rutgers.edu>
cc: linux-kernel@vger.kernel.org
Subject: Kernel Fault 2.4.20 (fwd)
Message-ID: <Pine.LNX.4.58.0402101317360.16489@puma.cabm.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a kernel fault today, I am not quite sure what 
just happened, if anyone has any ideas and can point me in 
the right direction.
Thanks a lot 

	-A

Feb 10 08:04:34 n07 kernel: Unable to handle kernel paging 
request at virtual address b70c1040
Feb 10 08:04:34 n07 kernel:  printing eip:
Feb 10 08:04:34 n07 kernel: c012cf87
Feb 10 08:04:34 n07 kernel: *pde = 00000000
Feb 10 08:04:34 n07 kernel: Oops: 0000 
Feb 10 08:04:34 n07 kernel: nfs lockd sunrpc autofs 3c59x 
bcm5700 ide-cd cdrom usb-ohci usbcore ext3 jbd raid1
Feb 10 08:04:34 n07 kernel: CPU:    0
Feb 10 08:04:34 n07 kernel: EIP:    0010:[<c012cf87>]    Not 
tainted
Feb 10 08:04:34 n07 kernel: EFLAGS: 00010286
Feb 10 08:04:34 n07 kernel: 
Feb 10 08:04:34 n07 kernel: EIP is at find_vma [kernel] 0x37 
(2.4.20-20.7custom)
Feb 10 08:04:34 n07 kernel: eax: f7649540   ebx: 07217a48   
ecx: f7649540   edx: b70c1050
Feb 10 08:04:34 n07 kernel: esi: f7736540   edi: c0116260   
ebp: 07217a48   esp: f7143e10
Feb 10 08:04:34 n07 kernel: ds: 0018   es: 0018   ss: 0018
Feb 10 08:04:34 n07 kernel: Process pbs_mom (pid: 1100, 
stackpage=f7143000)
Feb 10 08:04:34 n07 kernel: Stack: f7736540 00000000 
c01162ef f7736540 07217a48 c012b321 f7217ac0 f7142000
Feb 10 08:04:34 n07 kernel:        f7142000 00000000 
00000000 00030001 7fffffff f6eeb580 c02562d5 f6eeb580
Feb 10 08:04:34 n07 kernel:        00000000 00000018 
f75c0980 f6eeb580 ffffffec c1c40030 00000286 00000282
Feb 10 08:04:34 n07 kernel: Call Trace:   [<c01162ef>] 
do_page_fault [kernel] 0x8f (0xf7143e18))
Feb 10 08:04:34 n07 kernel: [<c012b321>] do_wp_page [kernel] 
0xc1 (0xf7143e24))
Feb 10 08:04:34 n07 kernel: [<c02562d5>] unix_stream_connect 
[kernel] 0x3c5 (0xf7143e48))
Feb 10 08:04:34 n07 kernel: [<c020b57c>] sk_free [kernel] 
0x6c (0xf7143e90))
Feb 10 08:04:34 n07 kernel: [<c012c1f4>] handle_mm_fault 
[kernel] 0x124 (0xf7143ea8))
Feb 10 08:04:34 n07 kernel: [<c0116260>] do_page_fault 
[kernel] 0x0 (0xf7143ebc))
Feb 10 08:04:34 n07 kernel: [<c0108c54>] error_code [kernel] 
0x34 (0xf7143ec4))
Feb 10 08:04:34 n07 kernel: [<c0116260>] do_page_fault 
[kernel] 0x0 (0xf7143ee0))
Feb 10 08:04:34 n07 kernel: [<c012cf87>] find_vma [kernel] 
0x37 (0xf7143ef8))
Feb 10 08:04:34 n07 kernel: [<c01162ef>] do_page_fault 
[kernel] 0x8f (0xf7143f0c))
Feb 10 08:04:34 n07 kernel: [<c0208f70>] sock_release 
[kernel] 0x10 (0xf7143f3c))
Feb 10 08:04:34 n07 kernel: [<c02094df>] sock_close [kernel] 
0x2f (0xf7143f48))
Feb 10 08:04:34 n07 kernel: [<c0143a6a>] filp_open [kernel] 
0x3a (0xf7143f70))
Feb 10 08:04:34 n07 kernel: [<c014eb4d>] getname [kernel] 
0x5d (0xf7143f90))
Feb 10 08:04:34 n07 kernel: [<c0116260>] do_page_fault 
[kernel] 0x0 (0xf7143fb0))
Feb 10 08:04:34 n07 kernel: [<c0108c54>] error_code [kernel] 
0x34 (0xf7143fb8))
Feb 10 08:04:34 n07 kernel: 
Feb 10 08:04:34 n07 kernel: 
Feb 10 08:04:34 n07 kernel: Code: 39 5a f0 8d 42 e8 76 f1 39 
5a ec 89 c1 77 e2 85 c9 74 03 89
Feb 10 09:10:49 n07 syslogd 1.4.1: restart.

