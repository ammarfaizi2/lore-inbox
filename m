Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132835AbRDIT7B>; Mon, 9 Apr 2001 15:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132836AbRDIT6w>; Mon, 9 Apr 2001 15:58:52 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:24056 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S132835AbRDIT6i>; Mon, 9 Apr 2001 15:58:38 -0400
Posted-Date: Mon, 9 Apr 2001 21:58:36 +0200 (MET DST)
Date: Mon, 9 Apr 2001 21:58:09 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200104091958.VAA21596@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: messages with ide-scsi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

I'm installing a CD burner and I've setup the ide-scsi, while checking 
the setup, I got the following messages.
What does this means, please ?

System is :
-----------
Linux debian-f5ibh 2.2.19 #1 lun avr 9 18:33:18 CEST 2001 i586 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             2.10f
modutils               2.4.5
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         sg ide-scsi ppa scsi_mod parport_pc parport af_packet scc ax25 autofs lockd sunrpc usbcore w83781d sensors i2c-isa i2c-core unix


And here are the messages :
---------------------------
[root@debian-f5ibh] ~ # cdrecord -scanbus
 ALI15X3: MultiWord DMA enabled
 ALI15X3: MultiWord DMA enabled
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
scsi : 2 hosts.
  Vendor: GoldStar  Model: CD-RW CED-8083B   Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: CREATIVE  Model: CD3621E  ZC100    Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Using libscg version 'schily-0.1'
	  
Cdrecord 1.8 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
Using libscg version 'schily-0.1'
scsibus0:
        0,0,0     0) 'GoldStar' 'CD-RW CED-8083B ' '1.05' Removable CD-ROM
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: The scsi wants to send us more data than expected - discarding data
        0,1,0     1) 'CREATIVE' 'CD3621E  ZC100  ' '1.00' Removable CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

----
Regards 
	Jean-Luc
