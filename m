Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263675AbRFCRiv>; Sun, 3 Jun 2001 13:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263685AbRFCRTp>; Sun, 3 Jun 2001 13:19:45 -0400
Received: from wet.kiss.uni-lj.si ([193.2.98.10]:27917 "EHLO
	wet.kiss.uni-lj.si") by vger.kernel.org with ESMTP
	id <S263673AbRFCQk5>; Sun, 3 Jun 2001 12:40:57 -0400
Message-ID: <3B1A67E3.9060907@kiss.uni-lj.si>
Date: Sun, 03 Jun 2001 18:37:55 +0200
From: Sasa Ostrouska <maja.ostrouska@kiss.uni-lj.si>
Reply-To: maja.ostrouska@kiss.uni-lj.si
Organization: Redos d.o.o.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.5 BUG
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all of you !

I have this problem with the linux-2.4.5. When I want to shutdown the
system I get this error message:

//////

journal_begin called without kernel lock held
kernel BUG at journal.c:423!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0175420>]
EFLAGS: 00010286

eax: 0000001d ebx: c12b3f2c ecx: 00000001 edx: 00000001
esi: c7f41600 edi: c12b3f2c ebp: 0000000a esp: c12b3ec4
ds: 0018  es: 0018  ss: 0018

Process umount (pid: 2861, stackpage = c12b3000)

Stack: c025416c c0254304 000001a7 c017791e c0255321 c12b3f2c c7f41600 
c02996a0
        c7f41644 3b1a4df9 c12b3f98 00000000 3b1a4df9 00000010 c025532f 
c0177b4e
        c12b3f2c c7f41600 0000000a 00000000 c0169d7c c12b3f2c c7f41600 
0000000a

Call Trace: [<c017791e>] [<c0177b4e>] [<c0169d7c>] [<c013722c>] [<c013725f>]
             [<c01365a0>] [<c013c2e8>] [<c0137721>] [<c0137754>] 
[<c0106c6b>]

Code: 0f 0b 83 c4 0c c3 89 f6 31 c0 c3 90 31 c0 c3 90 56 53 31 db

Unmounting any remaining filesystems...

//////

Then the machine stops and I have to switch it off ,
I use the
linux-2.4.5 kernel
with reiserfs compiled in
and glibc-2.2.2

If you can help me solve this would be very apreciated.

Thank you in advance.

Sasa Ostrouska

