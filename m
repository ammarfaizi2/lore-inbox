Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272137AbTHRRKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272142AbTHRRKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:10:49 -0400
Received: from [216.127.70.30] ([216.127.70.30]:19430 "HELO betanetweb.com")
	by vger.kernel.org with SMTP id S272137AbTHRRKq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:10:46 -0400
From: "Miguel A. Rasero" <tecnico@bareacomunicaciones.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel errors with good hardware
Date: Mon, 18 Aug 2003 19:10:37 +0200
Message-ID: <000701c365ab$a6184fd0$0500a8c0@skuda>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i don´t know if this list is the better to post this problems but i
can´t find any better to do it, i have an pc with this hardware:
	QDI PlatiniX 2D/533:	Intel 845E
					North Bridge: Intel 82845E (MCH)
					South Bridge: Intel 82801BA
(ICH2) 
	Intel P4 2.4
	512mb ram Kingston DDR PC2100
	Eicon diva pci isdn
	bttv compatible card

I use it to record and stream videos over internet with mpeg4ip, i have
five machines doing the same without problems, the only thing that is
not the same is that the other machines are using adsl connection so
they don´t need the isdn card, i have tested all the hardware, the ram
and the disk are ok, i think is a problem with the isdn card but i don´t
understand it, i have tried to make work without the isdn and it seems
to work ok but i have not had sufficient time to test it (2 or more
days) because i need this machine always online. The problem is that
after a random number of hours of use this gives me that errors.

Unable to handle kernel paging request at virtual address 3a6f616c
 printing eip:
c012b571
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012b571>]    Tainted: P
EFLAGS: 00010046
eax: d9c67000   ebx: 0000000f   ecx: df4ae000   edx: 3a6f6168
esi: c158be90   edi: 00000202   ebp: c1117350   esp: c15bdf00
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c15bd000)
Stack: df4ae880 df4ae880 df4ae880 c1117350 c013444a c158be90 df4ae880
c0136153
       df4ae880 df4ae880 c1117350 000001d0 0000000a 00000200 c01346ec
df4ae880
       c1117350 c012c3a2 c1117350 000001d0 00000020 000001d0 00000020
00000006
Call Trace:    [<c013444a>] [<c0136153>] [<c01346ec>] [<c012c3a2>]
[<c012c600>]
  [<c012c662>] [<c012c761>] [<c012c7c6>] [<c012c8dd>] [<c0105578>]

Code: 89 42 04 89 10 c7 01 00 00 00 00 c7 41 04 00 00 00 00 8b 46

Unable to handle kernel paging request at virtual address 85848389
 printing eip:
c012b542
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012b542>]    Tainted: P
EFLAGS: 00010046
eax: c582f000   ebx: 0000000e   ecx: cc518000   edx: 85848385
esi: c158a100   edi: 00000246   ebp: 00000023   esp: c15bdf38
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c15bd000)
Stack: d4b14c80 cc518800 de0c2880 00000023 c0142e76 c158a100 cc518800
00000008
       000001d0 00000020 00000006 c15bc000 00000000 c0143173 000000e0
c012c610
       00000006 000001d0 00000006 00000020 000001d0 c02466b4 c02466b4
c012c662
Call Trace:    [<c0142e76>] [<c0143173>] [<c012c610>] [<c012c662>]
[<c012c761>]
  [<c012c7c6>] [<c012c8dd>] [<c0105578>]

Code: 89 42 04 89 10 c7 01 00 00 00 00 c7 41 04 00 00 00 00 8b 46

It is not always the kswapd process, he is the one that usually crash
(80%) but other times is another one like for example mp4live. When i
see this message in dmesg the load average of the machine begins to grow
and to grow until the machine is hung. Anyone can help me with that
problem? Thanks in advance

