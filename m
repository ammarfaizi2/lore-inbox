Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275003AbRIYNxg>; Tue, 25 Sep 2001 09:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275004AbRIYNx0>; Tue, 25 Sep 2001 09:53:26 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:9104 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S275003AbRIYNxO>; Tue, 25 Sep 2001 09:53:14 -0400
Posted-Date: Tue, 25 Sep 2001 15:47:05 +0100 (WEST)
Date: Tue, 25 Sep 2001 15:56:58 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200109251356.PAA03536@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20-pre,keyboard and mouse frozen with X
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
My system is a K6-2 500 with 256Mb SDRAM running linux 2.2.20-pre10
I've a ps2 mouse and I run gpm.
The motherboard is an ASUS P5A with an Ali chipset.

Sometimes, when I swith to Xwindow [just at the moement I switch to X],
both the keyboard and the mouse are frozen.
The system itself is still alive and working.

The mouse use (not shared) irq 12

[jean-luc@debian-f5ibh] ~ $ cat /proc/interrupts
CPU0
  0:    1284545          XT-PIC  timer
  1:      29706          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      36925          XT-PIC  usb-ohci, es1371
  7:          3          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:     338910          XT-PIC  AX.25 SCC
 12:     153647          XT-PIC  PS/2 Mouse
 13:          1          XT-PIC  fpu
 14:      40909          XT-PIC  ide0
 15:       8855          XT-PIC  ide1
NMI:          0

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux debian-f5ibh 2.2.20pre10 #1 mer sep 12 11:19:08 CEST 2001 i586 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.27
util-linux             2.11h
modutils               2.4.7
e2fsprogs              tune2fs
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         sr_mod ide-scsi cdrom scsi_mod isofs ppp_deflate
bsd_comp ppp slhc af_packet scc ax25 nfsd serial parport_probe parport_pc lp
parport autofs lockd sunrpc es1371 soundcore usb-ohci usbcore w83781d i2c-proc
i2c-isa i2c-core unix

Any idea ?

-------
Regards
		Jean-Luc

