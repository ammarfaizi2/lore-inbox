Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSF2K11>; Sat, 29 Jun 2002 06:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSF2K10>; Sat, 29 Jun 2002 06:27:26 -0400
Received: from web40305.mail.yahoo.com ([66.218.78.84]:26196 "HELO
	web40305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311752AbSF2K1Z>; Sat, 29 Jun 2002 06:27:25 -0400
Message-ID: <20020629102943.72716.qmail@web40305.mail.yahoo.com>
Date: Sat, 29 Jun 2002 12:29:43 +0200 (CEST)
From: =?iso-8859-1?q?philippe=20philippe?= <philippe_aubry@yahoo.com>
Subject: NEWBIES Need HELP for Oops on a bi P3+2.4.18 
To: linux-kernel@vger.kernel.org
Cc: philippe.aubry1@mageos.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Next,
This Oops is only on the scsi device when i make the
same operation, ( make a tar with big file or
directory or cp a big file to scsi disk, cp big file
from scsi to ide ) on ide disk there is no problem.
The problem is only with heavy I/O on scsi disk. When
i make the same operation with small file it work
correctly without any Oops. 
Is a DMA problem ? Could you help me for undrestand
this problem and you could you give me some
information for testing and debbuging if it's
possible.

I thank you in advance for your help.

philippe.aubry1@mageos.com


hello, 

I have this message when i  try to make a tar from a
big directory. This Oops 
is the same all time i try to make a tar with a big
directory, the file i try 
to compresse are on scsi disk connected by a qlogic
differential scsi card. 
It is normal?, could you give me some information.
The mother is an MSI with a VIA 694 X chipset based
with 2 p3 1Ghz.
I use a 2.4.18 kernel with smp support and different
other module.
 
Message from system :



Unable to handle kernel NULL pointer derenference at
virtual address 00000108
printing eip :
fc81797a
*pde = 00000000
Oops : 0002
CPU: 0
EIP:   0010:[<fc81797a>]         not tainted
EFLAGS: 00010002
eax: 0000fffc ebx: f7aee000 ecx: 00000010 edx:
f7aefc88
esi: f7aee020 edi: 00000108 ebp: 00000000 esp:
c02e7f18
ds: 0018 es: 0018 ss:0018
process swapper ( pid: 0, stackpage=c02e7000 )
stack : 00000001 00000001 f7aefc7c f7aefc00 00000002
00000000 24000001 
0000000b ....
Call trace : [<fc817785>] ... [<c0105000>]
Code : f3 a5 80 3b 03 75 0f 53 e8 a9 00 00 00 89 85 80
01 00 00 5b
<0>Kernel panic: Aiee, killing interrupt handler!
in interrupt handler - not syncing

philippe.aubry1@mageos.com

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
