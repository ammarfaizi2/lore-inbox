Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277496AbRJJWkA>; Wed, 10 Oct 2001 18:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277418AbRJJWjv>; Wed, 10 Oct 2001 18:39:51 -0400
Received: from zeus.hanau.net ([195.88.69.130]:9600 "EHLO zeus.hanau.net")
	by vger.kernel.org with ESMTP id <S277496AbRJJWji>;
	Wed, 10 Oct 2001 18:39:38 -0400
Date: Thu, 11 Oct 2001 00:44:35 +0200
From: Franz Georg =?iso-8859-1?Q?K=F6hler?= <lists@openunix.de>
To: linux-kernel@vger.kernel.org
Subject: crash?
Message-ID: <20011011004435.A1527@fgk.bofh.hanau.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
X-Accept-Language: de en
X-Uptime: 00:41:23 up  8:03, 3 users,  load average: 0.38, 0.12, 0.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I assume, the following crash is hardware related, maybe someone could
point me out some details:

Oct 11 00:10:11 zeus kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000007
Oct 11 00:10:11 zeus kernel:  printing eip:
Oct 11 00:10:11 zeus kernel: c011e567
Oct 11 00:10:11 zeus kernel: *pde = 00000000
Oct 11 00:10:11 zeus kernel: Oops: 0000
Oct 11 00:10:11 zeus kernel: CPU:    0
Oct 11 00:10:11 zeus kernel: EIP:    0010:[__find_lock_page+31/176]
Oct 11 00:10:11 zeus kernel: EFLAGS: 00010286
Oct 11 00:10:11 zeus kernel: eax: c19eb008   ebx: ffffffff   ecx: 00000011   edx: 0001ac02
Oct 11 00:10:11 zeus kernel: esi: dad1bf2c   edi: 00077424   ebp: dcd07104   esp: dad1bed4
Oct 11 00:10:11 zeus kernel: ds: 0018   es: 0018   ss: 0018 Oct 11 00:10:11 zeus kernel: Process innd (pid: 19925, stackpage=dad1b000)
Oct 11 00:10:11 zeus kernel: Stack: 00001000 dad1bf2c 00077424 c19eb008 c012094d dcd07104 00077424 c19eb008 
Oct 11 00:10:11 zeus kernel:        000be2d2 dad1bf74 0000000c 00000000 dcd070bc 00000000 00001000 fffffff4 
Oct 11 00:10:11 zeus kernel:        000225f4 c1300bd4 77424000 00000000 dcd07104 dcd07060 00000000 44d1bf64 
Oct 11 00:10:11 zeus kernel: Call Trace: [generic_file_write+789/1344] [do_readv_writev+438/560] [generic_file_write+0/1344] [net_tx_action+79/168] [ext2_file_lseek+0/164] 
Oct 11 00:10:11 zeus kernel:    [sys_writev+65/84] [system_call+51/56] 
Oct 11 00:10:11 zeus kernel: 
Oct 11 00:10:11 zeus kernel: Code: 39 6b 08 75 f4 39 7b 0c 75 ef b8 02 00 00 00 0f ab 43 18 89 


OS is linux 2.4.9 .


