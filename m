Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbTFVRdQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 13:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTFVRdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 13:33:16 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:60587 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264770AbTFVRdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 13:33:13 -0400
Date: Sun, 22 Jun 2003 13:47:06 -0400
From: Jeff <jeffpc@optonline.net>
Subject: Re: kswapd 2.4.2? ext3
In-reply-to: <200306212032.09382.jeffpc@optonline.net>
To: john@beyondhelp.co.nz, linux-kernel@vger.kernel.org
Message-id: <200306221347.14106.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz>
 <200306212032.09382.jeffpc@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I almost forgot, here is what ksymoops had to say:

Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod 
file?
Jun 21 06:25:19 raptor kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000028
Jun 21 06:25:19 raptor kernel: c01355d4
Jun 21 06:25:19 raptor kernel: *pde = 00000000
Jun 21 06:25:19 raptor kernel: Oops: 0002
Jun 21 06:25:19 raptor kernel: CPU:    0
Jun 21 06:25:19 raptor kernel: EIP:    0010:[cdput+4/64]    Not tainted
Jun 21 06:25:19 raptor kernel: EFLAGS: 00010202
Jun 21 06:25:19 raptor kernel: eax: 00000020   ebx: c0e43be0   ecx: 00000020   
edx: c0e43bf8
Jun 21 06:25:19 raptor kernel: esi: c10f3f5c   edi: c05dd408   ebp: c10f3f64   
esp: c10f3f28
Jun 21 06:25:19 raptor kernel: ds: 0018   es: 0018   ss: 0018
Jun 21 06:25:19 raptor kernel: Process kswapd (pid: 4, stackpage=c10f3000)
Jun 21 06:25:19 raptor kernel: Stack: c01419c1 00000020 c0e43be0 c0141a24 
c0e43be0 c1588e08 c1588e00 c0141c72
Jun 21 06:25:19 raptor kernel:        c10f3f5c 00000013 000001d0 00000020 
0000035b c0e43a08 c1276468 00000006
Jun 21 06:25:19 raptor kernel:        c0141caf 00000000 c012a429 00000006 
000001d0 00000006 000001d0 00000006
Jun 21 06:25:19 raptor kernel: Call Trace:    [clear_inode+185/212] 
[dispose_list+72/96] [prune_icache+190/224] [shrink_icache_memory+27/48] 
[shrink_caches+109/132]
Jun 21 06:25:19 raptor kernel: Code: ff 49 08 0f 94 c0 84 c0 74 26 8b 51 04 8b 
01 89 50 04 89 02
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c0e43be0 <END_OF_CODE+b4eebc/????>
>>edx; c0e43bf8 <END_OF_CODE+b4eed4/????>
>>esi; c10f3f5c <END_OF_CODE+dff238/????>
>>edi; c05dd408 <END_OF_CODE+2e86e4/????>
>>ebp; c10f3f64 <END_OF_CODE+dff240/????>
>>esp; c10f3f28 <END_OF_CODE+dff204/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 49 08                  decl   0x8(%ecx)
Code;  00000003 Before first symbol
   3:   0f 94 c0                  sete   %al
Code;  00000006 Before first symbol
   6:   84 c0                     test   %al,%al
Code;  00000008 Before first symbol
   8:   74 26                     je     30 <_EIP+0x30> 00000030 Before first 
symbol
Code;  0000000a Before first symbol
   a:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  0000000d Before first symbol
   d:   8b 01                     mov    (%ecx),%eax
Code;  0000000f Before first symbol
   f:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000012 Before first symbol
  12:   89 02                     mov    %eax,(%edx)

Jun 21 06:25:22 raptor kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000028
Jun 21 06:25:22 raptor kernel: c01355d4
Jun 21 06:25:22 raptor kernel: *pde = 00000000
Jun 21 06:25:22 raptor kernel: Oops: 0002
Jun 21 06:25:22 raptor kernel: CPU:    0
Jun 21 06:25:22 raptor kernel: EIP:    0010:[cdput+4/64]    Not tainted
Jun 21 06:25:22 raptor kernel: EFLAGS: 00010202
Jun 21 06:25:22 raptor kernel: eax: 00000020   ebx: c0eb3be0   ecx: 00000020   
edx: c0eb3bf8
Jun 21 06:25:22 raptor kernel: esi: c0b69dbc   edi: c1a79288   ebp: c0b69dc4   
esp: c0b69d88
Jun 21 06:25:22 raptor kernel: ds: 0018   es: 0018   ss: 0018
Jun 21 06:25:22 raptor kernel: Process find (pid: 571, stackpage=c0b69000)
Jun 21 06:25:22 raptor kernel: Stack: c01419c1 00000020 c0eb3be0 c0141a24 
c0eb3be0 c1a790a8 c1a790a0 c0141c72
Jun 21 06:25:22 raptor kernel:        c0b69dbc 00000018 000001f0 00000020 
00000439 c0eb3a08 c0ee0688 00000006
Jun 21 06:25:22 raptor kernel:        c0141caf 00000000 c012a429 00000006 
000001f0 00000006 000001f0 00000006
Jun 21 06:25:22 raptor kernel: Call Trace:    [clear_inode+185/212] 
[dispose_list+72/96] [prune_icache+190/224] [shrink_icache_memory+27/48] 
[shrink_caches+109/132]
Jun 21 06:25:23 raptor kernel: Code: ff 49 08 0f 94 c0 84 c0 74 26 8b 51 04 8b 
01 89 50 04 89 02


>>ebx; c0eb3be0 <END_OF_CODE+bbeebc/????>
>>edx; c0eb3bf8 <END_OF_CODE+bbeed4/????>
>>esi; c0b69dbc <END_OF_CODE+875098/????>
>>edi; c1a79288 <END_OF_CODE+1784564/????>
>>ebp; c0b69dc4 <END_OF_CODE+8750a0/????>
>>esp; c0b69d88 <END_OF_CODE+875064/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 49 08                  decl   0x8(%ecx)
Code;  00000003 Before first symbol
   3:   0f 94 c0                  sete   %al
Code;  00000006 Before first symbol
   6:   84 c0                     test   %al,%al
Code;  00000008 Before first symbol
   8:   74 26                     je     30 <_EIP+0x30> 00000030 Before first 
symbol
Code;  0000000a Before first symbol
   a:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  0000000d Before first symbol
   d:   8b 01                     mov    (%ecx),%eax
Code;  0000000f Before first symbol
   f:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000012 Before first symbol
  12:   89 02                     mov    %eax,(%edx)


2 warnings issued.  Results may not be reliable.

- -- 
Please avoid sending me Word or PowerPoint attachments.
 See http://www.fsf.org/philosophy/no-word-attachments.html 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9eudwFP0+seVj/4RAtMaAKC5aB56bLYk6luT5g0AcfzifPzErgCfaioT
sz4Di9Q7WkJRClkJihPZXlQ=
=/deJ
-----END PGP SIGNATURE-----

