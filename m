Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136481AbRA1OHH>; Sun, 28 Jan 2001 09:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137070AbRA1OG6>; Sun, 28 Jan 2001 09:06:58 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:40200 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S136481AbRA1OGv>; Sun, 28 Jan 2001 09:06:51 -0500
From: Norbert Preining <preining@logic.at>
Date: Sun, 28 Jan 2001 15:06:36 +0100
To: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: sandisk sddr31 or scsi problems, double occurence
Message-ID: <20010128150636.A26992@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I have a problem with my sandisk sddr31 occuring 2 times while only
one is installed. My configuration:

linux-2.4.1-pre10
hotplug-scripts (newest)
ohci

I attach the output of cat /proc/bus/usb/devices, here only one
sddr is occuring, and various cat's from my /proc/scsi dir

Please, tell me how I can try to debug this problem.

-- 
ciao
norb

+-------------------------------------------------------------------+
| Norbert Preining              http://www.logic.at/people/preining |
| University of Technology Vienna, Austria        preining@logic.at |
| DSA: 0x09C5B094 (RSA: 0xCF1FA165) mail subject: get [DSA|RSA]-key |
+-------------------------------------------------------------------+

--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb.devices"

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=129/900 us (14%), #Int=  2, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=c8e7a000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c002 Rev= 1.20
S:  Manufacturer=Logitech
S:  Product=USB-PS/2 Mouse M-BA47
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl= 10ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 4
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03eb ProdID=3301 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  4 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c207 Rev= 1.04
S:  Manufacturer=Logitech Inc.
S:  Product=WingMan Extreme Digital 3D
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr= 20mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl= 10ms
T:  Bus=01 Lev=02 Prnt=03 Port=01 Cnt=02 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0781 ProdID=0002 Rev= 0.09
S:  Manufacturer=SanDisk Corporation
S:  Product=ImageMate CompactFlash USB
S:  SerialNumber=000000000005
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=02 Prnt=03 Port=02 Cnt=03 Dev#=  7 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0471 ProdID=0308 Rev= 0.06
S:  SerialNumber=02130211A0101AB1
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=ff Prot=00 Driver=Philips webcam
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=100ms
E:  Ad=84(I) Atr=01(Isoc) MxPS=   0 Ivl=  1ms
I:  If#= 0 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=ff Prot=00 Driver=Philips webcam
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=100ms
E:  Ad=84(I) Atr=01(Isoc) MxPS= 196 Ivl=  1ms
I:  If#= 0 Alt= 2 #EPs= 2 Cls=0a(data ) Sub=ff Prot=00 Driver=Philips webcam
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=100ms
E:  Ad=84(I) Atr=01(Isoc) MxPS= 292 Ivl=  1ms
I:  If#= 0 Alt= 3 #EPs= 2 Cls=0a(data ) Sub=ff Prot=00 Driver=Philips webcam
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=100ms
E:  Ad=84(I) Atr=01(Isoc) MxPS= 448 Ivl=  1ms
I:  If#= 0 Alt= 4 #EPs= 2 Cls=0a(data ) Sub=ff Prot=00 Driver=Philips webcam
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=100ms
E:  Ad=84(I) Atr=01(Isoc) MxPS= 592 Ivl=  1ms
I:  If#= 0 Alt= 5 #EPs= 2 Cls=0a(data ) Sub=ff Prot=00 Driver=Philips webcam
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=100ms
E:  Ad=84(I) Atr=01(Isoc) MxPS= 704 Ivl=  1ms
I:  If#= 0 Alt= 6 #EPs= 2 Cls=0a(data ) Sub=ff Prot=00 Driver=Philips webcam
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=100ms
E:  Ad=84(I) Atr=01(Isoc) MxPS= 776 Ivl=  1ms
I:  If#= 0 Alt= 7 #EPs= 2 Cls=0a(data ) Sub=ff Prot=00 Driver=Philips webcam
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=100ms
E:  Ad=84(I) Atr=01(Isoc) MxPS= 840 Ivl=  1ms
I:  If#= 0 Alt= 8 #EPs= 2 Cls=0a(data ) Sub=ff Prot=00 Driver=Philips webcam
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=100ms
E:  Ad=84(I) Atr=01(Isoc) MxPS= 896 Ivl=  1ms
I:  If#= 0 Alt= 9 #EPs= 2 Cls=0a(data ) Sub=ff Prot=00 Driver=Philips webcam
E:  Ad=82(I) Atr=03(Int.) MxPS=   1 Ivl=100ms
E:  Ad=84(I) Atr=01(Isoc) MxPS= 960 Ivl=  1ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
I:  If#= 2 Alt= 0 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=85(I) Atr=05(Isoc) MxPS=   0 Ivl=  1ms
I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=85(I) Atr=05(Isoc) MxPS=  90 Ivl=  1ms
I:  If#= 2 Alt= 2 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=85(I) Atr=05(Isoc) MxPS=  46 Ivl=  1ms
I:  If#= 2 Alt= 3 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=85(I) Atr=05(Isoc) MxPS=  25 Ivl=  1ms
I:  If#= 2 Alt= 4 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=85(I) Atr=05(Isoc) MxPS=  16 Ivl=  1ms

--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi.txt"

norbert@mandala:
[~] cat /proc/scsi/usb-storage-0/1 
   Host scsi1: usb-storage
       Vendor: SanDisk Corporation
      Product: ImageMate CompactFlash USB
Serial Number: None
     Protocol: Transparent SCSI
    Transport: Bulk
         GUID: 078100020000000000000000
norbert@mandala:
[~] cat /proc/scsi/usb-storage-1/2 
   Host scsi2: usb-storage
       Vendor: SanDisk Corporation
      Product: ImageMate CompactFlash USB
Serial Number: None
     Protocol: Transparent SCSI
    Transport: Bulk
         GUID: 078100020000000000000000
norbert@mandala:
[~] cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: CD-Writer+ 9100  Rev: 1.0a
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: SanDisk  Model: ImageMate II     Rev: 1.30
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: SanDisk  Model: ImageMate II     Rev: 1.30
  Type:   Direct-Access                    ANSI SCSI revision: 02
norbert@mandala:
[~] 

--dTy3Mrz/UPE2dbVg--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
