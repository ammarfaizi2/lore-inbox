Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263224AbREaUwf>; Thu, 31 May 2001 16:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263231AbREaUwZ>; Thu, 31 May 2001 16:52:25 -0400
Received: from dewey.mindlink.net ([204.174.16.4]:41738 "EHLO
	dewey.paralynx.net") by vger.kernel.org with ESMTP
	id <S263228AbREaUwV>; Thu, 31 May 2001 16:52:21 -0400
Subject: 2.4.5 crash on boot, SMP Alpha
From: Jay Thorne <Yohimbe@userfriendly.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-0zs85hodVWw0wy4+jWLY"
X-Mailer: Evolution/0.10 (Preview Release)
Date: 31 May 2001 13:52:18 -0700
Message-Id: <991342339.3807.4.camel@gracie.userfriendly.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0zs85hodVWw0wy4+jWLY
Content-Type: text/plain

Further variations on a theme.
2.4.4-ac15 works like a charm on these machines.
 
--
Jay Thorne Manager, Systems & Technology, UserFriendly Media, Inc.

--=-0zs85hodVWw0wy4+jWLY
Content-ID: 991342115.3610.3.camel@gracie.userfriendly.org
Content-Description: 
Content-Type: text/plain
Content-Disposition: inline; filename=decode
Content-Transfer-Encoding: 7bit

ksymoops 2.4.0 on alpha 2.4.4-ac15.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.5-ac5/ (specified)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 043ffc000069c078
CPU 2 init(1): Oops 0
pc = [<fffffc000034550c>]  ra = [<fffffc00003456ac>]  ps = 0000
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = fffffc0000474238  t0 = 043ffc000069bff8  t1 = 0007ffffffffff85
t2 = fffffc0000200000  t3 = fffffc00006a0150  t4 = 0000000000040305
t5 = fffffc000047fc80  t6 = 0000000000000000  t7 = fffffc000205c000
s0 = 000000012008e068  s1 = fffffc000047fcc8  s2 = fffffc000047fc80
s3 = fffffc000047bdc0  s4 = fffffc0000474238  s5 = f0f0f0f0f0f0f0f1
s6 = 0000000120006940
a0 = fffffc000047fc80  a1 = fffffc000047bdc0  a2 = fffffc0000474238
a3 = 0000000000000001  a4 = 000000012008e068  a5 = 0000000000000000
t8 = 0000000000000000  t9 = 0000000000000000  t10= 0000000000000000
t11= 0000000000000000  pv = fffffc0000345bd0  at = 0000000000000000
gp = fffffc0000546300  sp = fffffc000205fad8
Code: a4830938  ldq t3,2360(t2)
 40410522  subq t1,t0,t1
 4841b682  srl t1,13,t1
 48409721  sll t1,4,t0
 40220401  addq t0,t1,t0
 40240641  s8addq t0,t3,t0
 a4820140  ldq t3,320(t1)
Trace:fffffc00003456ac fffffc0000345920 fffffc000032aa38 fffffc000031041c fffffc00003100b0 fffffc0000310d68 fffffc0000336fd0 fffffc0000310d04 fffffc00003100b0 fffffc00003100b0 fffffc0000310684 fffffc0000310658 fffffc0000310684 
Kernel panic: Attempted to kill init!
Warning (Oops_read): Code line not seen, dumping what data is available

>>PC;  fffffc000034550c <do_anonymous_page+7c/1c0>   <=====
Trace; fffffc00003456ac <do_no_page+5c/1d0>
Trace; fffffc0000345920 <handle_mm_fault+100/1e0>
Trace; fffffc000032aa38 <do_page_fault+258/4a0>
Trace; fffffc000031041c <entMM+9c/c0>
Trace; fffffc00003100b0 <init+0/250>
Trace; fffffc0000310d68 <ret_from_fork+0/10>
Trace; fffffc0000336fd0 <do_softirq+e0/170>
Trace; fffffc0000310d04 <handle_softirq+14/28>
Trace; fffffc00003100b0 <init+0/250>
Trace; fffffc00003100b0 <init+0/250>
Trace; fffffc0000310684 <kernel_thread+2c/70>
Trace; fffffc0000310658 <kernel_thread+0/70>
Trace; fffffc0000310684 <kernel_thread+2c/70>


1 warning issued.  Results may not be reliable.

--=-0zs85hodVWw0wy4+jWLY--

