Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316766AbSGBMYB>; Tue, 2 Jul 2002 08:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316764AbSGBMYA>; Tue, 2 Jul 2002 08:24:00 -0400
Received: from gw.off.ournet.com.au ([202.45.108.10]:14464 "EHLO
	cascade.off.ournet.com.au") by vger.kernel.org with ESMTP
	id <S316756AbSGBMX6>; Tue, 2 Jul 2002 08:23:58 -0400
Message-Id: <5.1.0.14.2.20020702222604.00b1f1a0@mail.off.ournet.com.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 02 Jul 2002 22:26:12 +1000
To: linux-kernel@vger.kernel.org
From: Darryl Harvey <darryl@harvey.net.au>
Subject: SCSI Cards ?!?!?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am using an Initio 9100UW and it is giving me nothing but grief.


bash-2.05a# cat /proc/scsi/INI9100U/0
The driver does not yet support the proc-fs


bash-2.05a# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: HP       Model: 4.26GB A 50-S65A Rev: S65A
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
   Vendor: Seagate  Model: STT20000N        Rev: 6A51
   Type:   Sequential-Access                ANSI SCSI revision: 02



Maybe it is settings, but it is not intuitive.  The old Advansys Cards were 
great, and now you can't get them.  I chose Initio because they took over 
Advansys (or Connectcom).


I cannot use the tape drive properly as the SCSI card keeps resetting it's 
bus and the tape drive locks up..

For completeness, here is my PCI info;

bash-2.05a# cat /proc/pci
PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: VIA Technologies, Inc. VT8367 [KT266] (rev 0).
       Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
   Bus  0, device   1, function  0:
     PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (rev 0).
       Master Capable.  No bursts.  Min Gnt=12.
   Bus  0, device   6, function  0:
     SCSI storage controller: Initio Corporation 360P (rev 2).
       IRQ 10.
       Master Capable.  Latency=64.
       I/O at 0xec00 [0xecff].
       Non-prefetchable 32 bit memory at 0xdffff000 [0xdfffffff].
   Bus  0, device   8, function  0:
     Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 8).
       IRQ 5.
       Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
       Non-prefetchable 32 bit memory at 0xdfffe000 [0xdfffefff].
       I/O at 0xe800 [0xe83f].
       Non-prefetchable 32 bit memory at 0xdfe00000 [0xdfefffff].
   Bus  0, device  17, function  0:
     ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge (rev 0).
   Bus  0, device  17, function  1:
     IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
       Master Capable.  Latency=32.
       I/O at 0xfc00 [0xfc0f].
   Bus  0, device  17, function  5:
     Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio 
Controller (rev 16).
       IRQ 7.
       I/O at 0xe400 [0xe4ff].
   Bus  1, device   0, function  0:
     VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 21).
       IRQ 11.
       Master Capable.  Latency=64.  Min Gnt=5.Max Lat=1.
       Non-prefetchable 32 bit memory at 0xde000000 [0xdeffffff].
       Prefetchable 32 bit memory at 0xda000000 [0xdbffffff].



So if I can't find an Advansys card, what should I use ?
What SCSI cards do you all recommend?

Anyone ??


TIA
Darryl 

