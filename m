Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131053AbRCGMwM>; Wed, 7 Mar 2001 07:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131054AbRCGMwD>; Wed, 7 Mar 2001 07:52:03 -0500
Received: from mailgate.FH-Aachen.de ([149.201.10.254]:30136 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S131053AbRCGMvx>; Wed, 7 Mar 2001 07:51:53 -0500
Posted-Date: Wed, 7 Mar 2001 13:51:05 +0100 (MET)
Date: Wed, 7 Mar 2001 13:50:35 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200103071250.NAA07376@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: ac13 and lp related problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ams running xsane to do copy of document to my printer.
The scanner is an usb Epson Perfection 1640SU, the printer a Stylus Color 500.

All is right with 2.2.19pre but with 2.4.2-ac12, after scanning the document,
xsane closed itself and I've the following messages in the system log without
nothing in the spool. The problem does not exist with 2.4.3-pre3.

I use the lpr package together with 'magicfilter'.

Mar  7 11:52:28 debian-f5ibh kernel: scanner.c: USB Scanner support registered.
Mar  7 11:55:55 debian-f5ibh lpd[567]: lp: filter 'f' terminated (termsig=13)
Mar  7 11:55:55 debian-f5ibh lpd[567]: lp: job could not be printed
(cfA106debian-f5ibh)
Mar  7 11:57:58 debian-f5ibh lpd[586]: lp: filter 'f' terminated (termsig=13)
Mar  7 11:57:58 debian-f5ibh lpd[586]: lp: job could not be printed
(cfA107debian-f5ibh)

System is :
AMD K6-2, 128Mb running 2.4.2-ac13 patched for the lm-sensors.

with :

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux debian-f5ibh 2.2.19pre16 #1 lun mar 5 20:28:29 CET 2001 i586 unknown
Kernel modules         2.4.3
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         af_packet scc ax25 scanner adlib_card v_midi opl3 sb uart401 sound soundcore ppp slhc parport_probe parport_pc lp parport mousedev usb-ohci hid input autofs usbcore serial w83781d sensors i2c-isa i2c-core unix

----------
Regards

		Jean-Luc
