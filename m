Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSKOFpZ>; Fri, 15 Nov 2002 00:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSKOFpZ>; Fri, 15 Nov 2002 00:45:25 -0500
Received: from web41011.mail.yahoo.com ([66.218.93.10]:34411 "HELO
	web41011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265819AbSKOFpY>; Fri, 15 Nov 2002 00:45:24 -0500
Message-ID: <20021115055214.69129.qmail@web41011.mail.yahoo.com>
Date: Thu, 14 Nov 2002 21:52:14 -0800 (PST)
From: Joyce Tan <blutot@yahoo.com>
Subject: oops message when detaching usb device (ohci) of 2.5.47
To: kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this oops message when i detach usb device in
2.5.47 (ohci)

thanks,
joyce

t@Javelina kernel]$hciconfig hci0 up
hci_usb_send_ctrl: hci0 ctrl tx submit failed urb
c6bd76e0 err -90
Can't init device hci0. Connection timed out(110)
[root@Javelina kernel]$drivers/usb/core/usb.c: USB
disconnect on device 2
Unable to handle kernel paging request at virtual
address 5ee3ee84
pgd = c0004000
[5ee3ee84] *pgd=00000000
Internal error: Oops: 5
hci_usb rfcomm l2cap bluetooth ohci-hcd usbcore
CPU: 0
pc : [<c0045108>]    lr : [<c887bb50>]    Not tainted
sp : c6ccbed0  ip : c6ccbeec  fp : c6ccbee8
r10: 00000001  r9 : c6bd5504  r8 : 00000000
r7 : c6bd5000  r6 : a0000013  r5 : ffffff02  r4 :
c6bd7200
r3 : 0013fffb  r2 : c0c06fd8  r1 : 00000000  r0 :
5ee3ee84
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  Segment
user
Control: C000317F  Table: 06CF0000  DAC: 00000015
Process khubd (pid: 60, stack limit = 0xc6cca0d8)
Stack: (0xc6ccbed0 to 0xc6ccc000)
bec0:                                     c6bd7200
c7fffae0 00000000 c6ccbf28
bee0: c6ccbeec c887bb50 c00450dc 00000000 00000104
00000000 00000000 00000000
bf00: c6bd5000 00000002 00000208 0000023c 00000004
c6bd5dfc c7eae248 c6ccbf3c
bf20: c6ccbf2c c887591c c887ba78 c6bd5000 c6ccbf5c
c6ccbf40 c8875ab4 c88758d0
bf40: 00000100 c6bd5c00 00000002 00000001 c6ccbf94
c6ccbf60 c88780a8 c88759d8
bf60: 00000003 c8882a1c c7eae220 00000002 c6bd5c00
c7eae220 40000013 00000001
bf80: 02049230 c7eae248 c6ccbfc4 c6ccbf98 c8878450
c8878018 01000003 00000000
bfa0: c6ccbfc8 c8886430 c8886440 0000004c ffffffea
c6d3e000 c6ccbff4 c6ccbfc8
bfc0: c88786cc c88782f0 00000000 c6e4d080 c0026824
c8886444 c8886444 c88864a0
bfe0: 00000000 c6b52000 00000000 c6ccbff8 c001e0b0
c88786a0 001fe011 001fe411
Backtrace:
Function entered at [<c00450cc>] from [<c887bb50>]
 r6 = 00000000  r5 = C7FFFAE0  r4 = C6BD7200
Function entered at [<c887ba68>] from [<c887591c>]
Function entered at [<c88758c0>] from [<c8875ab4>]
 r4 = C6BD5000
Function entered at [<c88759c8>] from [<c88780a8>]
 r7 = 00000001  r6 = 00000002  r5 = C6BD5C00  r4 =
00000100
Function entered at [<c8878008>] from [<c8878450>]
Function entered at [<c88782e0>] from [<c88786cc>]
Function entered at [<c8878690>] from [<c001e0b0>]
 r6 = C6B52000  r5 = 00000000  r4 = C88864A0
Code: e5922000 e0833103 e0822183 e5920008 (e5904000)

~
~
~
~


__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - Let the expert host your site
http://webhosting.yahoo.com
