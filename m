Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbRELOs3>; Sat, 12 May 2001 10:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261259AbRELOsT>; Sat, 12 May 2001 10:48:19 -0400
Received: from gate.alaweb.com ([206.155.114.4]:9491 "EHLO gate")
	by vger.kernel.org with ESMTP id <S261258AbRELOsI>;
	Sat, 12 May 2001 10:48:08 -0400
Date: Sat, 12 May 2001 09:48:16 -0500
Message-ID: <B0032926992@gate>
X-Mailer: Windows Eudora Light Version 1.5.2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
From: Aubrey Kilpatrick <oppaak@alaweb.com>
Subject: Kernel "Oops" output
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a K6-2D 333MHz system with Red Hat 7.0 (with updates) that gives the
following "oops" output when I execute the "shutdown -h now" command.  I
tried to find the "opps" output in the /var/log/messages file but there is
nothing there.  The system hangs at the last line of the oops output to the
screen and will not accept any commands.  The only recourse at this point is
to "CTRL-ALT-DEL" and let the system reboot.

The oops out follows:

Power down
general protection fault: f000
CPU: 0
EIP: 005: [<00008865>]
EFLAGS: 00010046
eax: 00005301   ebx: 00000001   ecx: 00000000   edx: c1239de0

esi: c0258136   edi: c1239e8c   ebp: 67890000   esp: c1239de0

ds: 0058        es: 0000        ss: 0018

Process halt (pid: 869, stackpage=c1239000)
Stack:  9e8c82df   8136c123   0000c025   9e026789   0001c123   00000000
00030000   53070000

        00000000   00000000   81250058   80fa6aac   000080cd   00160000
00488036   bffffcc8
        
        c01118a4   00000010   bffffcc8   c1239e8c   00000018   00000018
00000292   00000000

Call Trace: [<c01118a4>] [<c0111963>] [<c0111991>] [<c01119e7>] [<f000bcd0>]
[<fee1dead>] [<c010741b>]

[<c011f3ed>] [<c020ea40>] [<c011debb>] [<c011df45>] [<c011e1ad>]
[<c011e8b9>] [<c0144fe5>] [<c0133d26>]

[<c0113e4d>] [<c0108fb3>] [<fee1dead>] [<fee1dead>]

Code: Bad EIP value.
/etc/rc0.d/S01halt: line 1:  869 Segmentation fault     halt -i -d -p

end of oops output and system hangs.

More system info:

DFI Motherboard (P5BV3+)
64M RAM
Mitsumi 40X CD-ROM
2.4G hard drive
17" CTX Monitor
4Meg Trident 3D Image 975 Chipset (Video 77/87/L87PCI/AGP (v6.45.5423b.98)
PS2 Mouse
101 Keyboard

If there is additional system/hardware info you need to fix this problem
please let me know and I will be glad to try and get it for you.

Thank you for your help.

Aubrey Kilpatrick

email at:  oppaak@alaweb.com
phone:  USA 1-334-493-4962 

