Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbRCPCIO>; Thu, 15 Mar 2001 21:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbRCPCIE>; Thu, 15 Mar 2001 21:08:04 -0500
Received: from james.kalifornia.com ([208.179.59.2]:51033 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129478AbRCPCHw>; Thu, 15 Mar 2001 21:07:52 -0500
Message-ID: <3AB17547.9020507@blue-labs.org>
Date: Thu, 15 Mar 2001 18:07:03 -0800
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac4 i686; en-US; 0.8.1) Gecko/20010314
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OOPS] report
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.2-ac4

Mar 15 18:02:49 Huntington-Beach kernel: end_request: I/O error, dev 
16:41 (hdd), sector 9512
Mar 15 18:02:49 Huntington-Beach kernel: hdd: drive not ready for command
Mar 15 18:02:48 Huntington-Beach kernel: hdd: drive not ready for command
Mar 15 18:02:49 Huntington-Beach kernel: hdd: status error: status=0x00 { }
Mar 15 18:02:49 Huntington-Beach kernel: hdd: drive not ready for command
Mar 15 18:02:49 Huntington-Beach kernel: journal-601, buffer write failed
Mar 15 18:02:49 Huntington-Beach kernel: kernel BUG at prints.c:332!
Mar 15 18:02:49 Huntington-Beach kernel: invalid operand: 0000
Mar 15 18:02:49 Huntington-Beach kernel: CPU:    0
Mar 15 18:02:49 Huntington-Beach kernel: EIP:    
0010:[reiserfs_panic+357/440]
Mar 15 18:02:49 Huntington-Beach kernel: EFLAGS: 00010282
Mar 15 18:02:49 Huntington-Beach kernel: eax: 0000001c   ebx: c0420e40   
ecx: cf190000   edx: c03a4008
Mar 15 18:02:49 Huntington-Beach kernel: esi: c39a5ecc   edi: c39a5ebc   
ebp: 00000000   esp: c39a5e90
Mar 15 18:02:49 Huntington-Beach kernel: ds: 0018   es: 0018   ss: 0018
Mar 15 18:02:49 Huntington-Beach kernel: Process sync (pid: 30559, 
stackpage=c39a5000)
Mar 15 18:02:49 Huntington-Beach kernel: Stack: c031a785 c031aa74 
0000014c d1526154 00000002 00000000 cfeb0c00 c0421240
Mar 15 18:02:49 Huntington-Beach kernel:        c39a5ebc c39a5eb8 
c39a4000 00000000 c0193a6f cfeb0c00 c031cd20 00000002
Mar 15 18:02:49 Huntington-Beach kernel:        00000012 00000010 
00000000 d1526188 d152617c 00000003 00000000 00000003
Mar 15 18:02:49 Huntington-Beach kernel: Call Trace: [<d1526154>] 
[flush_commit_list+659/908] [<d1526188>] [<d152617c>] 
[do_journal_end+1935/2652] [<d1526154>] [<d1543000>]
Mar 15 18:02:50 Huntington-Beach kernel:        
[flush_old_commits+391/420] [reiserfs_write_super+21/32] 
[sync_supers+118/172] [fsync_dev+23/48] [sys_sync+7/16] [system_call+51/56]
Mar 15 18:02:50 Huntington-Beach kernel:
Mar 15 18:02:50 Huntington-Beach kernel: Code: 0f 0b 83 c4 0c 83 7c 24 
28 00 74 17 8b 7c 24 28 80 7f 11 00

