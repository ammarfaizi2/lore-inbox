Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbTBVSOg>; Sat, 22 Feb 2003 13:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbTBVSOg>; Sat, 22 Feb 2003 13:14:36 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:42759 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267315AbTBVSOe> convert rfc822-to-8bit; Sat, 22 Feb 2003 13:14:34 -0500
MIME-Version: 1.0
Message-Id: <3E573A28.000003.92259@cranium>
Date: Sat, 22 Feb 2003 14:21:52 +0530 (India Standard Time)
Content-Type: Text/Plain; charset=US-ASCII
X-Mailer: IncrediMail 2001 (1850908)
From: "Rajesh Kizhuveetil" <rajeshkizhuveetil@yahoo.co.in>
X-FID: FLAVOR00-NONE-0000-0000-000000000000
X-FVER: 3.0
X-CNT: ;
Content-Transfer-Encoding: 7BIT
X-Priority: 3
To: <linux-kernel@vger.kernel.org>
Subject: PROBELM: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
 
            i am currently maintaing the Linux sm56 internal modem driver.
you can download at www.sm56.tk , 
     the file is sm56-gcc3.tar.gz my problem is that with the 2.4.18.24.8.0 
and above kernels i get the below mentioned error .
     but it does not arises when we use the custom build kernel  of the same
version.  please help me  so that i can help lot of others 
     who are using the sm56 modem. the motorola not currently supports the
sm56 internal modem.
 
OUTPUT OF THE dmesg Command
---------------------------------------------------
 
Motorola Softmodem: version SM56 Rel. 5.00 Build 85
Unloading Motorola Softmodem: version SM56 Rel. 5.00 Build 85
Motorola Softmodem: version SM56 Rel. 5.00 Build 85
Unable to handle kernel paging request at virtual address 5a7182c5
 printing eip:
c0117e60
*pde = 00000000
Oops: 0000
sm56 soundcore binfmt_misc autofs ne2k-pci 8390 ipt_REJECT iptable_filter
ip_tables nls_iso8859-1 nls_cp437 vfat fat mousedev keybdev hid input
usb-uhci usbco
CPU:    0
EIP:    0010:[<c0117e60>]    Tainted: P 
EFLAGS: 00010883
 
EIP is at __wake_up [kernel] 0x20 (2.4.18-24.8.0)
eax: c3033280   ebx: 5a7182c9   ecx: 00000200   edx: 00000000
esi: c3033280   edi: 00000000   ebp: c20cbf14   esp: c20cbef8
ds: 0018   es: 0018   ss: 0018
Process wvdial (pid: 1996, stackpage=c20cb000)
Stack: 00000246 c0f40000 00000200 00000282 c0f40000 00000002 c5fc6800
c20cbf44 
       c8ec0038 00000000 c0f40000 c20cbf44 c8e3f048 c3033280 00000000
00000200 
       c0f40000 c0f40000 c0f40000 0000540b c01803f6 c0f40000 00000286
c0f40000 
Call Trace: [<c8ec0038>] Rajesh__wake_up [sm56] 0x14 (0xc20cbf18))
[<c8e3f048>] mot_flushbuffer [sm56] 0x34 (0xc20cbf28))
[<c01803f6>] n_tty_ioctl [kernel] 0x216 (0xc20cbf48))
[<c017c807>] tty_ioctl [kernel] 0x2e7 (0xc20cbf64))
[<c014f3c3>] sys_ioctl [kernel] 0xc3 (0xc20cbf94))
[<c0109147>] system_call [kernel] 0x33 (0xc20cbfc0))
 
 
Code: 8b 53 fc 8b 02 85 c7 75 17 8b 1b 39 f3 75 f1 ff 75 f0 9d 83 
 
OUTPUT OF ver_linux
-------------------------------
 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux Cranium 2.4.18-24.8.0 #1 Fri Jan 31 06:51:30 EST 2003 i686 i686 i386
GNU/Linux
 
Gnu C                  gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7)
Copyright (C) 2002 Free Software Foundation, Inc. This is free software; see
the source for copying conditions. There is NO warranty; not even for
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         sm56 soundcore binfmt_misc autofs ne2k-pci 8390
ipt_REJECT iptable_filter ip_tables nls_iso8859-1 nls_cp437 vfat fat
mousedev keybdev hid input usb-uhci usbcore ext3 jbd
 
Thanks 
Rajesh kizhuveetil.
________________________________________________________________________
Missed your favourite TV serial last night? Try the new, Yahoo! TV.
       visit http://in.tv.yahoo.com
