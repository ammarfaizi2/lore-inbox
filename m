Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287924AbSAPVhU>; Wed, 16 Jan 2002 16:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287947AbSAPVhF>; Wed, 16 Jan 2002 16:37:05 -0500
Received: from blueberrysolutions.com ([195.165.170.195]:5512 "EHLO
	blueberrysolutions.com") by vger.kernel.org with ESMTP
	id <S287924AbSAPVfr>; Wed, 16 Jan 2002 16:35:47 -0500
Date: Wed, 16 Jan 2002 23:35:40 +0200 (EET)
From: Tony Glader <Tony.Glader@blueberrysolutions.com>
X-X-Sender: <teg@blueberrysolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.17 oops
Message-ID: <Pine.LNX.4.33.0201162332010.14511-100000@blueberrysolutions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As I few days ago wrote about 2.2.17 oops's...

I still get them daily and I'm sure that hardware isn't problem - I have 
changed everything in my computer. It is a Pentium 75. After (about) a 24 
hours uptime I will get lot of oops's,but iptables still working. Oops's 
will come shortly after boot, if processor has heavy load or i/o is big.

---- 8< -----

Unable to handle kernel paging request at virtual address 00001200
 00001200
 *pde = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[<00001200>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00013202
 eax: 00000001   ebx: c024ce60   ecx: c380b000   edx: 00000012
 esi: 00000012   edi: 00000018   ebp: 00000361   esp: c11f7f28
 ds: 0018   es: 0018   ss: 0018
 Process kswapd (pid: 4, stackpage=c11f7000)
 Stack: c109eec0 c0126983 c024ce60 00000197 c11f6000 00000051 000001d0 
c01fd4c8
      c0265ee0 c11e35a0 c10c7590 00000000 00000020 000001d0 00000006 
00002946
       c0126af6 00000006 0000000e c01fd4c8 00000006 000001d0 c01fd4c8 
00000000
 Call Trace: [shrink_cache+691/752] [shrink_caches+86/128] 
[try_to_free_pages+48/8
 Code:  Bad EIP value.

---- 8< ----

