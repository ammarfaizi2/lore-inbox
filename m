Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262114AbREPWZH>; Wed, 16 May 2001 18:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262123AbREPWY5>; Wed, 16 May 2001 18:24:57 -0400
Received: from mail.gcecisp.com ([208.14.31.3]:49166 "HELO mail.gcecisp.com")
	by vger.kernel.org with SMTP id <S262114AbREPWYk>;
	Wed, 16 May 2001 18:24:40 -0400
Message-ID: <3B02FE4D.2F7A8E8F@gcecisp.com>
Date: Wed, 16 May 2001 17:25:18 -0500
From: virii <virii@gcecisp.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cmpci sound chip lockup 
Content-Type: multipart/mixed;
 boundary="------------8A14DC51FAF7AD027283183A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8A14DC51FAF7AD027283183A
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The attatched file is the format for reporting bugs.

--------------8A14DC51FAF7AD027283183A
Content-Type: text/plain; charset=iso-8859-15;
 name="cmpci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmpci"

1) While playing mp3's on mpg123 it'll lock up for 3/4 seconds, and XMMS just stops all together

2) May 16 05:46:10 virii kernel: cmpci: dma timed out??
   May 16 06:05:43 virii kernel: cmpci: write: chip lockup? dmasz 65536 fragsz 1024 count 65536 hwptr 40576 swptr 40576 

3) cmpci.o soundcore.o happens when compiled into kernel or as modules

4) Linux version 2.2.19 (root@virii) (gcc version 2.95.3 20010315 (release)) #2 SMP Sat Apr 21 13:51:28 CDT 2001
   note [this happend with all the 2.4.* as well.]

6) just while playing music with mpg123 or xmms, or any other mp3 player.

7) using Slackware-current

8) Gnu C                  2.95.3
   Gnu make               3.79.1
   binutils               2.10.1.0.4
   util-linux             2.11b
   modutils               2.4.6
   e2fsprogs              1.19
   reiserfsprogs          3.x.0j
   pcmcia-cs              3.1.25
   PPP                    2.4.1
   Linux C Library        2.2.2
   Dynamic linker (ldd)   2.2.2
   Procps                 2.0.7
   Net-tools              1.59
   Kbd                    1.04
   Sh-utils               2.0
   Modules Loaded         bsd_comp ppp slhc

9) processor       : 0
   vendor_id       : AuthenticAMD
   cpu family      : 5
   model           : 8
   model name      : AMD-K6(tm) 3D processor
   stepping        : 12
   cpu MHz         : 522.818
   cache size      : 64 KB
   fdiv_bug        : no
   hlt_bug         : no
   sep_bug         : no
   f00f_bug        : no
   coma_bug        : no
   fpu             : yes
   fpu_exception   : yes
   cpuid level     : 1
   wp              : yes
   flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
   bogomips        : 1042.02

10) bsd_comp                4080   1
    ppp                    21680   2 [bsd_comp]
    slhc                    4496   1 [ppp]

11) Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: E-IDE    Model: CD-ROM 50X       Rev: 33
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IDE-CD   Model: R/RW 4x4x24      Rev: 1.04
  Type:   CD-ROM                           ANSI SCSI revision: 02

12) 
root@virii:~# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 530 Host (rev 03)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b3)
00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 11)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0c.1 Communication controller: C-Media Electronics Inc CM8738 (rev 10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 3D-AGP
(rev a3)




--------------8A14DC51FAF7AD027283183A--

