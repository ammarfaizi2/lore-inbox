Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVDKAGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVDKAGH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 20:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVDKAGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 20:06:07 -0400
Received: from front3.netvisao.pt ([213.228.128.91]:15320 "EHLO
	front3.netvisao.pt") by vger.kernel.org with ESMTP id S261488AbVDKAGD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 20:06:03 -0400
From: =?iso-8859-1?q?Z=E9?= <mmodem00@netvisao.pt>
To: linux-kernel@vger.kernel.org
Subject: very high temperatures in Asus notebook
Date: Sun, 10 Apr 2005 19:31:42 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504101931.45772.mmodem00@netvisao.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to understand why using linux, my notebook gets much higher 
temperatures than using windows, in linux i get about 67º celcius grades.

For what i have compared to other notebooks, the drive made for my notebook, 
an Asus A2h, you can see specifications in 
http://www.asus.com/products/notebook/a2series/a2000h/a2000h_overview.htm

I dont see other notebooks get so high temperatures like mine, and im also 
talking about Asus notebooks.

Im pasting here the sensors output:
]# sensors
it87-isa-0800
Adapter: ISA adapter
VCore 1:   +0.00 V  (min =  +1.42 V, max =  +1.57 V)   ALARM
VCore 2:   +0.00 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
+3.3V:     +0.00 V  (min =  +3.14 V, max =  +3.46 V)   ALARM
+5V:       +0.00 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
+12V:      +0.00 V  (min = +11.39 V, max = +12.61 V)   ALARM
-12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:      -13.64 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
Stdby:     +0.00 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
VBat:      +3.28 V
fan1:     135000 RPM  (min =    0 RPM, div = 2)
fan2:        0 RPM  (min = 2657 RPM, div = 2)
fan3:        0 RPM  (min = 2657 RPM, div = 2)
M/B Temp:    +67°C  (low  =   +15°C, high =   +40°C)   sensor = diode
CPU Temp:    +67°C  (low  =   +15°C, high =   +45°C)   sensor = diode
Temp3:       +67°C  (low  =   +15°C, high =   +45°C)   sensor = diode

Here is also the output of lspcidrake:
]# lspcidrake
sis-agp         : Silicon Integrated System|SiS 650 Host-to-PCI Bridge 
[BRIDGE_HOST]
unknown         : Silicon Integrated Systems [SiS]|5591/5592 AGP [BRIDGE_PCI]
unknown         : Silicon Integrated Systems [SiS]|SiS962 [MuTIOL Media IO] 
[BRIDGE_ISA]
i2c-sis96x      : Silicon Integrated System|SiS961/962 SMBus Controller 
[SERIAL_SMBUS]
ohci1394        : Silicon Integrated Systems [SiS]|OHCI Compliant FireWire 
Controller [SERIAL_FIREWIRE]
sis5513         : Silicon Integrated Systems [SiS]|5513 [IDE] [STORAGE_IDE]
slamr           : Silicon Integrated System|SiS7013 56k Modem 
[COMMUNICATION_MODEM]
snd-intel8x0    : Silicon Integrated Systems [SiS]|SiS7012 PCI Audio 
Accelerator [MULTIMEDIA_AUDIO]
usb-ohci        : Silicon Integrated Systems [SiS]|7001 USB [SERIAL_USB]
usb-ohci        : Silicon Integrated Systems [SiS]|7001 USB [SERIAL_USB]
usb-ohci        : Silicon Integrated Systems [SiS]|7001 USB [SERIAL_USB]
ehci-hcd        : Silicon Integrated Systems [SiS]|7002 USB 2.0 Controller 
[SERIAL_USB]
sis900          : Silicon Integrated Systems [SiS]|SiS900 10/100 Ethernet 
[NETWORK_ETHERNET]
yenta_socket    : Texas Instruments|PCI1410 PC card Cardbus Controller 
[BRIDGE_CARDBUS]
unknown         : Broadcom Corp.|BCM4301 802.11b [NETWORK_OTHER]
Card:SiS 650    : Silicon Integrated System|SiS650/651/740 GUI 2D/3D 
Accelerator [DISPLAY_VGA]
hub             : Linux 2.6.11-6mdk ehci_hcd|EHCI Host Controller [Hub|Unused]
hub             : Linux 2.6.11-6mdk ohci_hcd|OHCI Host Controller [Hub|Unused]
hub             : Linux 2.6.11-6mdk ohci_hcd|OHCI Host Controller [Hub|Unused]
usbhid          : Microsoft Corp.|Notebook Optical Mouse [Human Interface 
Devices|Boot Interface Subclass|Mouse]
hub             : Linux 2.6.11-6mdk ohci_hcd|OHCI Host Controller [Hub|Unused]

Any help?
-- 
Zé
Linux user #378762
