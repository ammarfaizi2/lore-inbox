Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316982AbSFAD2g>; Fri, 31 May 2002 23:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316983AbSFAD2f>; Fri, 31 May 2002 23:28:35 -0400
Received: from 66-75-142-198.san.rr.com ([66.75.142.198]:2308 "EHLO
	mushworld.dnsart.com") by vger.kernel.org with ESMTP
	id <S316982AbSFAD2e>; Fri, 31 May 2002 23:28:34 -0400
Date: Fri, 31 May 2002 20:31:05 -0700 (PDT)
From: <hogger@mushworld.dnsart.com>
Reply-To: <hogger@mushworld.dnsart.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: bttv recording problems with kernel 2.2.21
Message-ID: <Pine.LNX.4.33.0205312021180.729-100000@mushworld.dnsart.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. bttv recording problems with kernel 2.2.21
2. I upgraded my kernel from 2.2.19 to 2.2.21, and I lost the ability to
record tv from my bt878 card using realproducer 8.5 for linux.  The
program starts, but does not capture or process any data.  I remember
having this same problem when I upgraded from 2.2.17 to 2.2.19.  My
solution in both cases is to copy the bt848.h, bttv.h and bttv.c file from
my 2.2.17 kernel tree and recompile the kernel with those.  REcording
works in this case.  There are no console messages, nor are there any
messages in any of the logs.
3. BTTV, kernel, video4linux
4. Linux Version 2.2.21
5.
6. Realproducer 8.5, see real.com to download it.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

7. Linux mushworld 2.2.21 #5 Fri May 31 20:12:23 PDT 2002 i586 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux
util-linux             Note: /usr/bin/fdformat is obsolete and is no longer available.
util-linux             Please use /usr/bin/superformat instead (make sure you have the
util-linux             fdutils package installed first).  Also, there had been some
util-linux             major changes from version 4.x.  Please refer to the documentation.
util-linux
mount                  2.10f
modutils               2.3.11
e2fsprogs              1.18
isdn4k-utils           3.0beta2
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         vmnet vmppuser vmmon parport_pc lp parport nls_cp437 vfat fat appletalk mod_quickcam usb-uhci usbcore au8830 sb uart401 sound soundcore

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 232.674
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 463.66

	7.2

7.3
vmnet                  17376   1
vmppuser                5508   0 (unused)
vmmon                  18480   0 (unused)
parport_pc              7556   1 (autoclean) [vmppuser]
lp                      5284   0 (autoclean)
parport                 7696   1 (autoclean) [vmppuser parport_pc lp]
nls_cp437               3904   2 (autoclean)
vfat                    9700   1
fat                    30976   1 [vfat]
appletalk              18336   0
mod_quickcam           35884   0 (unused)
usb-uhci               18752   0 (unused)
usbcore                51208   1 [mod_quickcam usb-uhci]
au8830                138008   0
sb                     34740   0
uart401                 6352   0 [sb]
sound                  58284   0 [sb uart401]
soundcore               2788  10 [au8830 sb sound]



Fix.  Copy bttv.h, bttv,c, vt848.h from 2.2.17 tree and replace the
respective files in the 2.2.21 tree

If you need more info, please contact me.


-Greg
If you'd like to leave a  message, you may do so by hitting the reply
button after the beep. BEEEEPPPPP!!!!

