Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270271AbRIEEou>; Wed, 5 Sep 2001 00:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270280AbRIEEob>; Wed, 5 Sep 2001 00:44:31 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:57349 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S270271AbRIEEoZ>; Wed, 5 Sep 2001 00:44:25 -0400
Message-ID: <3B95ADBB.78EAB37F@delusion.de>
Date: Wed, 05 Sep 2001 06:44:43 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: USB device not accepting new address
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have just come across another USB address problem, which happens sporadically
and is not easy to reproduce. It happens sometimes during bootup and is unrelated
to port overpowering, at other times everything works well. Output below.
The USB driver is the JE-driver.

Regards,
-Udo.

uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: USB new device connect on bus1/2, assigned device number 2
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
usb.c: kmalloc IF c14bbe80, numif 1
usb.c: new device strings: Mfr=0, Product=0, SerialNumber=0
hub.c: USB hub found
hub.c: 5 ports detected
hub.c: standalone hub
hub.c: individual port power switching
hub.c: individual port over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 100ms
hub.c: hub controller current requirement: 100mA
hub.c: port removable status: RRRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
uhci.c: root-hub INT complete: port1: 588 port2: 495 data: 2
usb.c: hub driver claimed interface c14bbe80
usb.c: kusbd: /sbin/hotplug add 2
usb.c: kusbd policy returned 0xfffffffe
hub.c: port 1 enable change, status 300
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: USB new device connect on bus1/2/1, assigned device number 3
uhci.c: uhci_result_control() failed with status 440000
[cfee30c0] link (0fee3062) element (0fefa240)
 Element != First TD
  0: [cfefa210] link (0fefa240) e3 Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=014bbf00)
  1: [cfefa240] link (00000001) e0 IOC Stalled CRC/Timeo Length=7ff MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)

usb.c: USB device not accepting new address=3 (error=-84)
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: USB new device connect on bus1/2/1, assigned device number 4
usb.c: kmalloc IF c15a0140, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=4, Product=14, SerialNumber=56
usb.c: USB device number 4 default language ID 0x409
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
Manufacturer: EIZO
Product: EIZO USB HID Monitor
SerialNumber: 23710050
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
hiddev0: USB HID v1.10 Device [EIZO EIZO USB HID Monitor] on usb1:4.0
usb.c: hid driver claimed interface c15a0140
usb.c: kusbd: /sbin/hotplug add 4
usb.c: kusbd policy returned 0xfffffffe
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: USB new device connect on bus2/2, assigned device number 2
usb.c: kmalloc IF c15a0dc0, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: ALCOR
Product: Generic USB Hub
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 44ms
hub.c: hub controller current requirement: 100mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c15a0dc0
usb.c: kusbd: /sbin/hotplug add 2
usb.c: kusbd policy returned 0xfffffffe
uhci.c: root-hub INT complete: port1: 588 port2: 495 data: 2
hub.c: port 1 enable change, status 300
