Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbUDAMCs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 07:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbUDAMCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 07:02:48 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:43272 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262876AbUDAMCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 07:02:42 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: 2.6.5-rc3-mm4
Date: Thu, 1 Apr 2004 14:02:44 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040401020512.0db54102.akpm@osdl.org>
In-Reply-To: <20040401020512.0db54102.akpm@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404011402.44875@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kTAbAADeA/9DWYr"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_kTAbAADeA/9DWYr
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 01 April 2004 12:05, Andrew Morton wrote:

Hi 

>  bk-usb.patch

hmm, did something changed in handling USB mice? starting with 2.6.5-rc3-mm1 
and the included bk-usb.patch my USB mouse won't work anymore. Using 
bk-usb.patch from 2.6.5-rc2-mm5 in 2.6.5-rc3-mm4 all works fine for me.

Attached are 2 files, one from 2.6.5-rc2-mm5 bk-usb and the other one is 
2.6.5-rc3-mm4 bk-usb. Seems the latter one does not proper init hid though 
the module is loaded.

ciao, Marc

--Boundary-00=_kTAbAADeA/9DWYr
Content-Type: text/x-log;
  charset="iso-8859-15";
  name="bk-usb-2.6.5-rc2-mm5.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bk-usb-2.6.5-rc2-mm5.log"

Apr  1 13:52:20 codeman kernel: mice: PS/2 mouse device common for all mice
Apr  1 13:52:20 codeman kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Apr  1 13:52:20 codeman kernel: input: ImPS/2 Generic Wheel Mouse on isa006=
0/serio1
Apr  1 13:52:20 codeman kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Apr  1 13:52:20 codeman kernel: input: AT Translated Set 2 keyboard on isa0=
060/serio0
Apr  1 13:52:20 codeman kernel: usbcore: registered new driver usbfs
Apr  1 13:52:20 codeman kernel: usbcore: registered new driver hub
Apr  1 13:52:20 codeman kernel: usbcore: registered new driver hiddev
Apr  1 13:52:20 codeman kernel: usbcore: registered new driver hid
Apr  1 13:52:20 codeman kernel: drivers/usb/input/hid-core.c: v2.0:USB HID =
core driver
Apr  1 13:52:20 codeman kernel: USB Universal Host Controller Interface dri=
ver v2.2
Apr  1 13:52:20 codeman kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB =
USB (Hub #1)
Apr  1 13:52:20 codeman kernel: PCI: Setting latency timer of device 0000:0=
0:1d.0 to 64
Apr  1 13:52:20 codeman kernel: uhci_hcd 0000:00:1d.0: irq 16, io base 0000=
d800
Apr  1 13:52:20 codeman kernel: uhci_hcd 0000:00:1d.0: new USB bus register=
ed, assigned bus number 1
Apr  1 13:52:20 codeman kernel: hub 1-0:1.0: USB hub found
Apr  1 13:52:20 codeman kernel: hub 1-0:1.0: 2 ports detected
Apr  1 13:52:20 codeman kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB =
USB (Hub #2)
Apr  1 13:52:20 codeman kernel: PCI: Setting latency timer of device 0000:0=
0:1d.1 to 64
Apr  1 13:52:20 codeman kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0000=
d400
Apr  1 13:52:20 codeman kernel: uhci_hcd 0000:00:1d.1: new USB bus register=
ed, assigned bus number 2
Apr  1 13:52:20 codeman kernel: hub 2-0:1.0: USB hub found
Apr  1 13:52:20 codeman kernel: hub 2-0:1.0: 2 ports detected
Apr  1 13:52:20 codeman kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB =
USB (Hub #3)
Apr  1 13:52:20 codeman kernel: PCI: Setting latency timer of device 0000:0=
0:1d.2 to 64
Apr  1 13:52:20 codeman kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0000=
d000
Apr  1 13:52:20 codeman kernel: uhci_hcd 0000:00:1d.2: new USB bus register=
ed, assigned bus number 3
Apr  1 13:52:20 codeman kernel: hub 3-0:1.0: USB hub found
Apr  1 13:52:20 codeman kernel: hub 3-0:1.0: 2 ports detected
Apr  1 13:52:20 codeman kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB =
USB2
Apr  1 13:52:20 codeman kernel: PCI: Setting latency timer of device 0000:0=
0:1d.7 to 64
Apr  1 13:52:20 codeman kernel: ehci_hcd 0000:00:1d.7: irq 23, pci mem f889=
4000
Apr  1 13:52:20 codeman kernel: ehci_hcd 0000:00:1d.7: new USB bus register=
ed, assigned bus number 4
Apr  1 13:52:20 codeman kernel: PCI: cache line size of 128 is not supporte=
d by device 0000:00:1d.7
Apr  1 13:52:20 codeman kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHC=
I 1.00, driver 2003-Dec-29
Apr  1 13:52:20 codeman kernel: hub 4-0:1.0: USB hub found
Apr  1 13:52:20 codeman kernel: hub 4-0:1.0: 6 ports detected
Apr  1 13:52:20 codeman kernel: SCSI subsystem initialized
Apr  1 13:52:20 codeman kernel: Initializing USB Mass Storage driver...
Apr  1 13:52:20 codeman kernel: usbcore: registered new driver usb-storage
Apr  1 13:52:20 codeman kernel: USB Mass Storage support registered.
Apr  1 13:52:20 codeman kernel: usb 2-1: new low speed USB device using add=
ress 2
Apr  1 13:52:20 codeman kernel: input: USB HID v1.00 Mouse [Microsoft Micro=
soft Wheel Mouse Optical=AE] on usb-0000:00:1d.1-1

--Boundary-00=_kTAbAADeA/9DWYr
Content-Type: text/x-log;
  charset="iso-8859-15";
  name="bk-usb-2.6.5-rc3-mm4.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bk-usb-2.6.5-rc3-mm4.log"

Apr  1 13:33:33 codeman kernel: mice: PS/2 mouse device common for all mice
Apr  1 13:33:33 codeman kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Apr  1 13:33:33 codeman kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Apr  1 13:33:33 codeman kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Apr  1 13:33:33 codeman kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  1 13:33:33 codeman kernel: usbcore: registered new driver usbfs
Apr  1 13:33:33 codeman kernel: usbcore: registered new driver hub
Apr  1 13:33:33 codeman kernel: USB Universal Host Controller Interface driver v2.2
Apr  1 13:33:33 codeman kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB USB (Hub #1)
Apr  1 13:33:33 codeman kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Apr  1 13:33:33 codeman kernel: uhci_hcd 0000:00:1d.0: irq 16, io base 0000d800
Apr  1 13:33:33 codeman kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Apr  1 13:33:33 codeman kernel: hub 1-0:1.0: USB hub found
Apr  1 13:33:33 codeman kernel: hub 1-0:1.0: 2 ports detected
Apr  1 13:33:33 codeman kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB USB (Hub #2)
Apr  1 13:33:33 codeman kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Apr  1 13:33:33 codeman kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0000d400
Apr  1 13:33:33 codeman kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Apr  1 13:33:33 codeman kernel: hub 2-0:1.0: USB hub found
Apr  1 13:33:33 codeman kernel: hub 2-0:1.0: 2 ports detected
Apr  1 13:33:33 codeman kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB USB (Hub #3)
Apr  1 13:33:33 codeman kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Apr  1 13:33:33 codeman kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0000d000
Apr  1 13:33:33 codeman kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Apr  1 13:33:33 codeman kernel: hub 3-0:1.0: USB hub found
Apr  1 13:33:33 codeman kernel: hub 3-0:1.0: 2 ports detected
Apr  1 13:33:33 codeman kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB USB2
Apr  1 13:33:33 codeman kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Apr  1 13:33:33 codeman kernel: ehci_hcd 0000:00:1d.7: irq 23, pci mem f8894000
Apr  1 13:33:33 codeman kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
Apr  1 13:33:33 codeman kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Apr  1 13:33:33 codeman kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
Apr  1 13:33:33 codeman kernel: hub 4-0:1.0: USB hub found
Apr  1 13:33:33 codeman kernel: hub 4-0:1.0: 6 ports detected
Apr  1 13:33:33 codeman kernel: SCSI subsystem initialized
Apr  1 13:33:33 codeman kernel: Initializing USB Mass Storage driver...
Apr  1 13:33:33 codeman kernel: usbcore: registered new driver usb-storage
Apr  1 13:33:33 codeman kernel: USB Mass Storage support registered.

--Boundary-00=_kTAbAADeA/9DWYr--
