Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262755AbSI1JKI>; Sat, 28 Sep 2002 05:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262756AbSI1JKI>; Sat, 28 Sep 2002 05:10:08 -0400
Received: from pop.gmx.de ([213.165.64.20]:36726 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262755AbSI1JKG>;
	Sat, 28 Sep 2002 05:10:06 -0400
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: System very unstable
Date: Sat, 28 Sep 2002 11:15:16 +0200
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209281115.19968.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

Since some days my system is very unstable. I get many crashes with kernel 
panics.

First one app is killed because of a segfault, than it doesn't take a long 
time and the computer is down. What is the problem, is it a memory error ?

thanks
have fun
Felix


P.S. Here is one of this crashes:

hal@hal:~$ ksymoops -m /boot/System.map error.txt
ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map (specified)

 <1>Unable to handle kernel paging request at virtual address f1ec9808
c01468de
Oops: 0002
CPU:    0
EIP:    0010:[get_new_inode+94/368]    Tainted: P
EFLAGS: 00010206
eax: f1ec9808   ebx: 00000000   ecx: c1376130 edx: c3761dc8
esi: f1ec9800   edi: d3f92b90   ebp: d3e82a00 esp: c7ddfe98
ds: 0018   es: 0018   ss: 0018
Process exim (pid: 25555, stackpage=c7ddf000)
Stack: 00000000 d3f92b90 00027e26 d3e82a00 c0146b76 d3e82a00 00027e26 d3f92b90
       00000000 00000000 ccf07840 d3e67ac0 ccf07840 c137a940 c01556c3 d3e82a00
       00027e26 00000000 00000000 fffffff4 d3e67ac0 c013cd93 d3e67ac0 ccf07840
Call Trace:    [iget4+182/208] [ext2_lookup+67/112] [real_lookup+83/192] 
[link_path_walk+1495/2144] [path_walk+26
Code: 89 56 08 c7 40 04 a4 c4 2a c0 a3 a4 c4 2a c0 8b 07 89 70 04
Using defaults from ksymoops -t elf32-i386 -a i386


>>ecx; c1376130 <_end+103e580/194d94b0>
>>edx; c3761dc8 <_end+342a218/194d94b0>
>>edi; d3f92b90 <_end+13c5afe0/194d94b0>
>>ebp; d3e82a00 <_end+13b4ae50/194d94b0>
>>esp; c7ddfe98 <_end+7aa82e8/194d94b0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 56 08                  mov    %edx,0x8(%esi)
Code;  00000003 Before first symbol
   3:   c7 40 04 a4 c4 2a c0      movl   $0xc02ac4a4,0x4(%eax)
Code;  0000000a Before first symbol
   a:   a3 a4 c4 2a c0            mov    %eax,0xc02ac4a4
Code;  0000000f Before first symbol
   f:   8b 07                     mov    (%edi),%eax
Code;  00000011 Before first symbol
  11:   89 70 04                  mov    %esi,0x4(%eax)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9lXMnS0DOrvdnsewRAlhiAJ9bsKSjsQFfYB8I3GinK2+V3PSMGQCZAQR5
bgETND+WX7jzxoWMnMOe1/8=
=Kgow
-----END PGP SIGNATURE-----

