Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTA1JPJ>; Tue, 28 Jan 2003 04:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbTA1JPJ>; Tue, 28 Jan 2003 04:15:09 -0500
Received: from pilt.cultus.no ([194.248.142.50]:38299 "EHLO pilt.cultus.no")
	by vger.kernel.org with ESMTP id <S262604AbTA1JPI>;
	Tue, 28 Jan 2003 04:15:08 -0500
Message-ID: <3E364C4A.5080408@cultus.no>
Date: Tue, 28 Jan 2003 10:24:26 +0100
From: Jens-Christian Skibakk <jens@cultus.no>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.21-pre3-ac4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.4.21-pre3-ac4 (root@debian) (gcc version 2.95.4 20011002 (Debian prerelease))

Jan 28 10:11:33 debian kernel:  printing eip:
Jan 28 10:11:33 debian kernel: c012c130
Jan 28 10:11:33 debian kernel: Oops: 0002
Jan 28 10:11:33 debian kernel: CPU:    0
Jan 28 10:11:33 debian kernel: EIP:    0010:[__free_pages_ok+624/652]    Not tainted
Jan 28 10:11:33 debian kernel: EFLAGS: 00010246
Jan 28 10:11:33 debian kernel: eax: 00000000   ebx: c16ea93c   ecx: c16ea93c   edx: c45b0000
Jan 28 10:11:33 debian kernel: esi: 00000000   edi: 00000020   ebp: 00000200   esp: c45b1e48
Jan 28 10:11:33 debian kernel: ds: 0018   es: 0018   ss: 0018
Jan 28 10:11:33 debian kernel: Process ld (pid: 16559, stackpage=c45b1000)
Jan 28 10:11:33 debian kernel: Stack: e83e1580 c16ea93c 00000020 00000200 c0134aae c16ea93c 000001d2 00000020 
Jan 28 10:11:33 debian kernel:        00000200 c013300c e83e1580 e83e1580 e83e1580 c012c763 c012b84c 00000020 
Jan 28 10:11:33 debian kernel:        000001d2 00000020 00000006 00000006 c45b0000 00002834 000001d2 c0253c14 
Jan 28 10:11:33 debian kernel: Call Trace:    [try_to_free_buffers+146/236] [try_to_release_page+68/72] [__free_pages+27/28] [shrink_cache+724/764] [shrink_caches+88/128]
Jan 28 10:11:33 debian kernel:   [try_to_free_pages_zone+58/92] [balance_classzone+80/456] [__alloc_pages+274/352] [generic_file_write+1001/1800] [_alloc_pages+22/24] [generic_file_write+1029/1800]
Jan 28 10:11:33 debian kernel:   [ext3_file_write+35/188] [sys_write+150/240] [system_call+51/56]
Jan 28 10:11:33 debian kernel: 
Jan 28 10:11:33 debian kernel: Code: 89 58 04 89 03 8d 42 5c 89 43 04 89 5a 5c 89 73 0c ff 42 68 
Jan 28 10:11:33 debian kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004



