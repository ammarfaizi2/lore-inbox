Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSBJWaT>; Sun, 10 Feb 2002 17:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284970AbSBJWaJ>; Sun, 10 Feb 2002 17:30:09 -0500
Received: from 213-97-137-182.uc.nombres.ttd.es ([213.97.137.182]:11534 "HELO
	iceberg.activanet.net") by vger.kernel.org with SMTP
	id <S284305AbSBJW34>; Sun, 10 Feb 2002 17:29:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Admin <kernel@cideweb.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-xfs oops
Date: Sun, 10 Feb 2002 23:29:54 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020210223003Z284305-13996+20418@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I have received this Oops in 2.4.17-xfs box when I am copying from a cdrw 
disc to /tmp, box has rebooted and I found this in syslog after it. If you 
need more info, request it. 

Feb 10 17:59:34 iceberg kernel: Unable to handle kernel paging request at 
virtual address f29dc26a
Feb 10 17:59:34 iceberg kernel:  printing eip:
Feb 10 17:59:34 iceberg kernel: c01314e4
Feb 10 17:59:34 iceberg kernel: *pde = 00000000
Feb 10 17:59:34 iceberg kernel: Oops: 0002
Feb 10 17:59:34 iceberg kernel: CPU:    0
Feb 10 17:59:34 iceberg kernel: EIP:    0010:[__remove_from_queues+20/48]    
Tainted: PF
Feb 10 17:59:34 iceberg kernel: EFLAGS: 00010246
Feb 10 17:59:34 iceberg kernel: eax: 00000000   ebx: cf38f540   ecx: 
cf38f540   edx: f29dc26a
Feb 10 17:59:34 iceberg kernel: esi: cf38f540   edi: cf38f540   ebp: 
c13e3ac0   esp: c1839f1c
Feb 10 17:59:34 iceberg kernel: ds: 0018   es: 0018   ss: 0018
Feb 10 17:59:34 iceberg kernel: Process kswapd (pid: 5, stackpage=c1839000)
Feb 10 17:59:34 iceberg kernel: Stack: c01337d9 cf38f540 c13e3ac0 000001d0 
0000000b 00000173 c013213c c13e3ac0
Feb 10 17:59:34 iceberg kernel:        000001d0 cf38f540 c13e3ac0 c0129f62 
c13e3ac0 000001d0 00000020 000001d0
Feb 10 17:59:34 iceberg kernel:        00000020 00000006 00000006 c1838000 
00003fc6 000001d0 c03a3d88 c012a1a6
Feb 10 17:59:34 iceberg kernel: Call Trace: [try_to_free_buffers+89/224] 
[try_to_release_page+60/80] [shrink_cache+482/752] [shrink_caches+86/144] 
[try_to_free_pages+60/96]
Feb 10 17:59:34 iceberg kernel:    [kswapd_balance_pgdat+67/144] 
[kswapd_balance+22/48] [kswapd+157/192] [kernel_thread+40/64]
Feb 10 17:59:34 iceberg kernel:
Feb 10 17:59:34 iceberg kernel: Code: 89 02 c7 41 30 00 00 00 00 51 e8 7d ff 
ff ff 83 c4 04 c3 89
