Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281648AbRLVRkd>; Sat, 22 Dec 2001 12:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281739AbRLVRkT>; Sat, 22 Dec 2001 12:40:19 -0500
Received: from sense-jaxley-158.oz.net ([216.39.151.158]:18560 "EHLO
	manteador.and.stuff") by vger.kernel.org with ESMTP
	id <S281648AbRLVRkB>; Sat, 22 Dec 2001 12:40:01 -0500
Message-ID: <1009042794.3c24c56ad3ea7@manteador.and.stuff>
Date: Sat, 22 Dec 2001 09:39:54 -0800
From: c o r e <core@axley.net>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Strange 2.4 bug:  mysterious hang
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending...

----- Forwarded message from c o r e <core@axley.net> -----
    Date: Tue, 18 Dec 2001 17:36:42 -0800 (PST)
    From: c o r e <core@axley.net>
Reply-To: c o r e <core@axley.net>
 Subject: Strange 2.4 bug:  mysterious hang
      To: linux-kernel@vger.kernel.org

I am not subscribed so if you could cc me on a reply, that would be great.

[1.] Summary:
Kernel 2.4.9-13 from RedHat 7.2, and all previous RedHat 7.2 kernels, will lock
up completely with no error at all.  This is easily reproducable in many
situations and in others, it happens arbitrarily.

[2.] Full description of the problem/report:
The entire system will freeze in its tracks and requires a soft or hard reboot
at arbitrary times or during certain known activities.  This can even occur
right after a fresh boot.  My system has 512 megabytes of memory and is running
a stock redhat 7.2 kernel (latest rpm)

This can easily be reproduced by either:
a) running gimp and attempting to print any image
b) running gimp and pasting an image into a new window and using the mouse to
move the image around before it is anchored.

The system almost without fail will hang shortly after these activities.

[3.] Keywords:  redhat 7.2 kernel hang freeze gimp lock up

[4.] Kernel version:  Linux version 2.4.9-13
(bhcompile@stripples.devel.redhat.com) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-98)) #1 Tue Oct 30 20:05:14 EST 2001

[5.] Output of Oops..:  none occurs

[6.] A small shell script or example program which triggers the
       problem (if possible):  as mentioned above, the gimp is pretty good at
doing this.

[7.] Environment
[7.1.] Software:  not included

[7.2.] Processor information:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 434.327
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat p
se36 mmx fxsr
bogomips        : 865.07

[7.3.] Module information:
nls_iso8859-1           2800   0 (autoclean)
nls_cp437               4320   0 (autoclean)
vfat                    9712   0 (autoclean)
fat                    32096   0 (autoclean) [vfat]
emu10k1                51280   0 (autoclean)
sr_mod                 14912   0 (autoclean)
soundcore               4208   4 (autoclean) [emu10k1]
r128                   90176   1
agpgart                26144   3
binfmt_misc             6064   1
autofs                 11296   0 (autoclean) (unused)
3c59x                  25216   1
ide-scsi                7936   0
scsi_mod               94496   2 [sr_mod ide-scsi]
ide-cd                 26592   0
cdrom                  29536   0 [sr_mod ide-cd]
printer                 5984   1
usb-uhci               20736   0 (unused)
usbcore                49920   1 [printer usb-uhci]
ext3                   59792   6
jbd                    39040   6 [ext3]

[7.4.] SCSI information:  N/A

[7.5.] Other information that might be relevant to the problem
Output of free right now:
             total       used       free     shared    buffers     cached
Mem:        512980     261844     251136       1864      28524     107892
-/+ buffers/cache:     125428     387552
Swap:       136512          0     136512

/proc/ide/piix:

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------

                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------

DMA enabled:    yes              yes             yes               no
UDMA enabled:   yes              yes             no                no
UDMA enabled:   2                2               X                 X
UDMA
DMA
PIO

Thanks,

-core

-------------------------------------------------
This mail sent through IMP: webmail.axley.net

----- End forwarded message -----


