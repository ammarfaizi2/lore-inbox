Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288964AbSAGHL6>; Mon, 7 Jan 2002 02:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287750AbSAGHLt>; Mon, 7 Jan 2002 02:11:49 -0500
Received: from mta02bw.bigpond.com ([139.134.6.34]:29936 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S288964AbSAGHLn>; Mon, 7 Jan 2002 02:11:43 -0500
Message-Id: <5.1.0.14.0.20020107180918.00b6d5a8@mail.bigpond.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 Jan 2002 18:11:31 +1100
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
From: Dylan Egan <crack_me@bigpond.com.au>
Subject: Re: 2.4.17 - hanging due to usb
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok read this... more info..... :

usb.c: unable to get major 180 for usb devices
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 13:10:52 Jan  7 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c4b76e80, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: d000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c4b76e80
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb-uhci.c: USB UHCI at I/O 0xcc00, IRQ 10
usb-uhci.c: Detected 2 ports
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2 enable change, status 100
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF c4b76c80, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: cc00
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c4b76c80
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 10
usb-uhci.c: Detected 2 ports
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: USB new device connect on bus2/2, assigned device number 2
usb.c: new USB bus registered, assigned bus number 3
usb.c: kmalloc IF c4b76ac0, numif 1
usb.c: new device strings: Mfr=0, Product=1, SerialNumber=0
usb.c: kmalloc IF c4b76980, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: c800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: USB device number 2 default language ID 0x409
Product: USB Host To Host Bridge
usb.c: unhandled interfaces on device
usb.c: USB device 2 (vend/prod 0x5e3/0x502) is not claimed by any active 
driver.
   Length              = 18
   DescriptorType      = 01
   USB version         = 1.00
   Vendor:Product      = 05e3:0502
   MaxPacketSize0      = 8
   NumConfigurations   = 1
   Device version      = 1.80
   Device Class:SubClass:Protocol = 00:00:00
     Per-interface classes
Configuration:
   bLength             =    9
   bDescriptorType     =   02
   wTotalLength        = 0027
   bNumInterfaces      =   01
   bConfigurationValue =   01
   iConfiguration      =   00
   bmAttributes        =   80
   MaxPower            =    8mA

   Interface: 0
   Alternate Setting:  0
     bLength             =    9
     bDescriptorType     =   04
     bInterfaceNumber    =   00
     bAlternateSetting   =   00
     bNumEndpoints       =   03
     bInterface Class:SubClass:Protocol =   ff:00:00
     iInterface          =   01
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   81 (in)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   02 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   83 (in)
       bmAttributes        =   03 (Interrupt)
       wMaxPacketSize      = 0008
       bInterval           =   10
usb.c: kusbd: /sbin/hotplug add 2
usb.c: kusbd policy returned 0xfffffffe
hub.c: port 1 enable change, status 100
usb.c: hub driver claimed interface c4b76980
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: USB new device connect on bus3/2, assigned device number 2
usb.c: kmalloc IF c4b76880, numif 1
usb.c: new device strings: Mfr=1, Product=1, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: ScanLogic USBIDE
Product: ScanLogic USBIDE
usb.c: unhandled interfaces on device
usb.c: USB device 2 (vend/prod 0x4ce/0x2) is not claimed by any active driver.
   Length              = 18
   DescriptorType      = 01
   USB version         = 1.10
   Vendor:Product      = 04ce:0002
   MaxPacketSize0      = 8
   NumConfigurations   = 1
   Device version      = 2.60
   Device Class:SubClass:Protocol = 00:00:00
     Per-interface classes
Configuration:
   bLength             =    9
   bDescriptorType     =   02
   wTotalLength        = 0020
   bNumInterfaces      =   01
   bConfigurationValue =   01
   iConfiguration      =   00
   bmAttributes        =   40
   MaxPower            =    0mA

   Interface: 0
   Alternate Setting:  0
     bLength             =    9
     bDescriptorType     =   04
     bInterfaceNumber    =   00
     bAlternateSetting   =   00
     bNumEndpoints       =   02
     bInterface Class:SubClass:Protocol =   08:06:50
     iInterface          =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   02 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   81 (in)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
usb.c: kusbd: /sbin/hotplug add 2
usb.c: kusbd policy returned 0xfffffffe
hub.c: port 1 enable change, status 100
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
usb-storage: act_altsettting is 0
usb-storage: id_index calculated to be: 52
usb-storage: Array length appears to be: 54
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xcff64154 Out: 0xcff64140 Int: 0x00000000 
(Period 0)
usb-storage: New GUID 04ce00020000000000000000
usb-storage: GetMaxLUN command result is 1, data is 0
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: *** thread sleeping.
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 00 00 00 ff 00 00 00 75 04 1a c0
usb-storage: Bulk command S 0x43425355 T 0x1 Trg 0 LUN 0 L 255 F 128 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 255/255
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x600350 R 159 Stat 0x0
usb-storage: Bulk logical error
usb-storage: Bulk reset requested

and more.... :

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=c800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=04ce ProdID=0002 Rev= 2.60
S:  Manufacturer=ScanLogic USBIDE
S:  Product=ScanLogic USBIDE
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=cc00
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05e3 ProdID=0502 Rev= 1.80
S:  Product=USB Host To Host Bridge
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=  8mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl= 16ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms



