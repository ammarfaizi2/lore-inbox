Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQLMRYk>; Wed, 13 Dec 2000 12:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQLMRYa>; Wed, 13 Dec 2000 12:24:30 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:845 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129464AbQLMRYQ>; Wed, 13 Dec 2000 12:24:16 -0500
Date: Wed, 13 Dec 2000 17:53:22 +0100
From: Rainer Wiener <rainer@konqui.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.0-test12 crash
Message-ID: <20001213175322.A2501@mulder.konqui.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-GPG-Fingerprint: 8F30 218F 1353 F984 1242  6FD3 3569 E885 C53E 61DA
X-Operating-System: Linux 2.4.0-test12
X-Homepage: http://www.konqui.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after 4 h the new kernel crash with the this output:

Dec 13 17:35:05 localhost kernel:  printing eip:
Dec 13 17:35:05 localhost kernel: c012812e
Dec 13 17:35:05 localhost kernel: Oops: 0000
Dec 13 17:35:05 localhost kernel: CPU:    0
Dec 13 17:35:05 localhost kernel: EIP:    0010:[page_launder+494/2144]
Dec 13 17:35:05 localhost kernel: EFLAGS: 00210202
Dec 13 17:35:05 localhost kernel: eax: 00000000   ebx: c10c998c   ecx:
0008e000                                   edx: 00000000
Dec 13 17:35:05 localhost kernel: esi: c10c99a8   edi: 00000000   ebp:
00001b42                                   esp: c12e7fb4
Dec 13 17:35:05 localhost kernel: ds: 0018   es: 0018   ss: 0018
Dec 13 17:35:05 localhost kernel: Process bdflush (pid: 6, stackpage=c12e7000)
Dec 13 17:35:05 localhost kernel: Stack: 00200206 00000000 c12e6000 0008e000
002                                00206 00000000 00000000 00000000 
Dec 13 17:35:05 localhost kernel:        00000000 c0130eaf 00000003 00000000
000                                10f00 c12f9f88 c12f9fc4 c01075e8 
Dec 13 17:35:05 localhost kernel:        c12f9fc4 00000078 c12f9fc4 
Dec 13 17:35:05 localhost kernel: Call Trace: [bdflush+143/288]
[kernel_thread+4                                0/64] 
Dec 13 17:35:05 localhost kernel: Code: 8b 40 0c 8b 10 85 d2 0f 84 ba 04 00
00 8                                3 7c 24 14 00 75 73 
Dec 13 17:35:05 localhost kernel:  printing eip:
Dec 13 17:35:05 localhost kernel: c012812e
Dec 13 17:35:05 localhost kernel: Oops: 0000
Dec 13 17:35:05 localhost kernel: CPU:    0
Dec 13 17:35:05 localhost kernel: EIP:    0010:[page_launder+494/2144]
Dec 13 17:35:05 localhost kernel: EFLAGS: 00210202
Dec 13 17:35:05 localhost kernel: eax: 00000000   ebx: c10d51e4   ecx:
c10d5244                                   edx: c10d5200
Dec 13 17:35:05 localhost kernel: esi: c10d5200   edi: 00000000   ebp:
00001ae4                                   esp: c12ebf98
Dec 13 17:35:05 localhost kernel: ds: 0018   es: 0018   ss: 0018
Dec 13 17:35:05 localhost kernel: Process kswapd (pid: 4, stackpage=c12eb000)
Dec 13 17:35:05 localhost kernel: Stack: 00200206 00000004 00000000 00000000
000                                00000 00000004 00000000 00000040 
Dec 13 17:35:05 localhost kernel:        00000000 c0128b24 00000004 00000000
002                                00206 c0209657 c12ea239 0008e000 
Dec 13 17:35:05 localhost kernel:        c0128bfd 00000004 00000000 00010f00
c12                                f9fb8 00000000 c01075e8 00000000 
Dec 13 17:35:05 localhost kernel: Call Trace: [do_try_to_free_pages+52/144]
[tve                                cs+6671/112216] [kswapd+125/336]
[kernel_thread+40/64] 
Dec 13 17:35:05 localhost kernel: Code: 8b 40 0c 8b 10 85 d2 0f 84 ba 04 00
00 8                                3 7c 24 14 00 75 73 

I hope this would help you. I have a Athlon 800 MHz with 128 MB RAM. And a
30 GB IBM Harddisk. The Kernel 2.4.0-test11 runs good. The only thing I can
do after this is to boot the computer to use the Magic Sysrq key.

cu
Rainer
-- 
Mulder: I think it's remotely plausible that someone might
	think you're hot.

	"The X-Files: E.B.E"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
