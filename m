Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTLQKVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 05:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTLQKVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 05:21:22 -0500
Received: from smtp02.ya.com ([62.151.11.132]:13468 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S264275AbTLQKVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 05:21:07 -0500
Subject: Re: UHCI-HCD && mosedev on 2.6.0-test11
From: Carlos =?ISO-8859-1?Q?Jim=E9nez?= <lordeath@linuxspain.net>
Reply-To: lordeath@linuxspain.net
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031217005552.GA8753@kroah.com>
References: <1071536070.12406.5.camel@localhost>
	 <20031216174639.GD2716@kroah.com> <1071621227.11193.69.camel@localhost>
	 <20031217005552.GA8753@kroah.com>
Content-Type: text/plain; charset=iso-8859-15
Organization: Torrejon Wireless
Message-Id: <1071656283.10399.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 11:18:04 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The device does not use hid, it was supported on 2.4 with mousedev.
(Mousedev is compiled into my kernel, I can not select it as module, No
tristate at all in menuconfig).

26.0-test11-bk12 fails and print out to messages more info.

When I start computer, and mouse is plugged in.

ehci_hcd: block sizes: qh 128 qtd 96 itd 128 sitd 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2
ordered !ppc ports=6
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64
bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem d18adc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8
period=1024 Reset HALT
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1
period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
ehci_hcd 0000:00:1d.7: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID
0x409
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.0-test11-bk12 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 0ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0000efe0
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:1d.0: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID
0x409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.0-test11-bk12 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
drivers/usb/core/usb.c: usb_hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
ehci_hcd 0000:00:1d.7: GetStatus port 1 status 001403 POWER sig=k  CSC
CONNECT
hub 1-0:1.0: port 1, status 501, change 1, 480 Mb/s
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 0000ef80
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:1d.1: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID
0x409
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.0-test11-bk12 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
drivers/usb/core/usb.c: usb_hotplug
usb usb3: registering 3-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: ganged power switching
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: Port indicators are not supported
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: hub controller current requirement: 0mA
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
hub 3-0:1.0: enabling power on all ports
uhci_hcd 0000:00:1d.2: UHCI Host Controller
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:1d.7: port 1 low speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 1 status 003002 POWER OWNER
sig=se0  CSC
hub 2-0:1.0: port 1, status 301, change 1, 1.5 Mb/s
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0000ef60
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:1d.2: root hub device address 1
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID
0x409
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.0-test11-bk12 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
drivers/usb/core/usb.c: usb_hotplug
usb usb4: registering 4-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: ganged power switching
hub 4-0:1.0: global over-current protection
hub 4-0:1.0: Port indicators are not supported
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: hub controller current requirement: 0mA
hub 4-0:1.0: local power source is good
hub 4-0:1.0: no over-current condition exists
hub 4-0:1.0: enabling power on all ports
hub 2-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 2-0:1.0: new USB device on port 1, assigned address 2
usb 2-1: new device strings: Mfr=0, Product=1, SerialNumber=0
drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status
500000
[ce4b8240] link (0e4b81b2) element (0e512080)
 Element != First TD
  0: [ce512040] link (0e512080) e3 LS Length=7 MaxLen=7 DT0 EndPt=0
Dev=2, PID=2d(SETUP) (buf=0e52a900)
  1: [ce512080] link (0e5120c0) e3 SPD LS Stalled Babble Length=3
MaxLen=3 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0e45d380)
  2: [ce5120c0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1
EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

drivers/usb/core/message.c: error getting string descriptor 0
(error=-75)
drivers/usb/core/usb.c: usb_hotplug
usb 2-1: config 0 descriptor??
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03a2d20(lo)
IPv6 over IPv4 tunneling driver
drivers/usb/host/uhci-hcd.c: ef80: suspend_hc
drivers/usb/host/uhci-hcd.c: ef60: suspend_hc
eth0: no IPv6 routers present
drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status
500000
[ce4b8240] link (0e4b81b2) element (0e512080)
 Element != First TD
  0: [ce512040] link (0e512080) e3 LS Length=7 MaxLen=7 DT0 EndPt=0
Dev=2, PID=2d(SETUP) (buf=01306ce0)
  1: [ce512080] link (0e5120c0) e3 SPD LS Stalled Babble Length=3
MaxLen=3 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0df77680)
  2: [ce5120c0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1
EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

drivers/usb/core/message.c: error getting string descriptor 0
(error=-75)
drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status
500000
[ce4b8240] link (0e4b81b2) element (0e512080)
 Element != First TD
  0: [ce512040] link (0e512080) e3 LS Length=7 MaxLen=7 DT0 EndPt=0
Dev=2, PID=2d(SETUP) (buf=01306ce0)
  1: [ce512080] link (0e5120c0) e3 SPD LS Stalled Babble Length=3
MaxLen=3 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0df77680)
  2: [ce5120c0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1
EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

drivers/usb/core/message.c: error getting string descriptor 0
(error=-75)
drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status
500000
[ce4b8240] link (0e4b81b2) element (0e512080)
 Element != First TD
  0: [ce512040] link (0e512080) e3 LS Length=7 MaxLen=7 DT0 EndPt=0
Dev=2, PID=2d(SETUP) (buf=01306f20)
  1: [ce512080] link (0e5120c0) e3 SPD LS Stalled Babble Length=3
MaxLen=3 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0df77680)
  2: [ce5120c0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1
EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

drivers/usb/core/message.c: error getting string descriptor 0
(error=-75)
drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status
500000
[ce4b8270] link (0e4b81b2) element (0e512140)
 Element != First TD
  0: [ce512100] link (0e512140) e3 LS Length=7 MaxLen=7 DT0 EndPt=0
Dev=2, PID=2d(SETUP) (buf=01306f20)
  1: [ce512140] link (0e512180) e3 SPD LS Stalled Babble Length=3
MaxLen=3 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0df77680)
  2: [ce512180] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1
EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

drivers/usb/core/message.c: error getting string descriptor 0
(error=-75)
drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status
500000
[ce4b8240] link (0e4b81b2) element (0e512080)
 Element != First TD
  0: [ce512040] link (0e512080) e3 LS Length=7 MaxLen=7 DT0 EndPt=0
Dev=2, PID=2d(SETUP) (buf=01306ce0)
  1: [ce512080] link (0e5120c0) e3 SPD LS Stalled Babble Length=3
MaxLen=3 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0df77680)
  2: [ce5120c0] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1
EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

drivers/usb/core/message.c: error getting string descriptor 0
(error=-75)
drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status
500000
[ce4b8270] link (0e4b81b2) element (0e512140)
 Element != First TD
  0: [ce512100] link (0e512140) e3 LS Length=7 MaxLen=7 DT0 EndPt=0
Dev=2, PID=2d(SETUP) (buf=01306ce0)
  1: [ce512140] link (0e512180) e3 SPD LS Stalled Babble Length=3
MaxLen=3 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0df77680)
  2: [ce512180] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1
EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

drivers/usb/core/message.c: error getting string descriptor 0
(error=-75)


#############################EOF######################



Then I listed modules so u can see my enviroment.
Module                  Size  Used by
hid                    32704  0
usbmouse                5760  0
md5                     4096  1
ipv6                  244576  8
uhci_hcd               31112  0
ohci_hcd               29824  0
ehci_hcd               35072  0
ds                     14976  4
rtc                    12072  0
usbcore               114900  7 hid,usbmouse,uhci_hcd,ohci_hcd,ehci_hcd
ntfs                  100884  1
cpufreq_userspace       5924  0
button                  6292  0
battery                 9736  0
ac                      5000  0
thermal                13576  0
processor              14360  1 thermal
toshiba_acpi            5524  0
speedstep_centrino      4740  0
freq_table              4484  1 speedstep_centrino
yenta_socket           17152  1
pcmcia_core            70656  2 ds,yenta_socket
snd_intel8x0           31172  0
snd_ac97_codec         53636  1 snd_intel8x0
snd_mpu401_uart         7424  1 snd_intel8x0
snd_rawmidi            24064  1 snd_mpu401_uart
e100                   61188  0
############## EOF ###################

The state of /proc/bus/usb/devices

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test11-bk12 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test11-bk12 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test11-bk12 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=062a ProdID=0000 Rev= 2.04
C:* #Ifs= 1 Cfg#= 0 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test11-bk12 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms
##########################EOF################################

I not undersand that info so this is output of usbview:

Unknown Device
Speed: 1.5Mb/s (low)
USB Version:  1.10
Device Class: 00(>ifc )
Device Subclass: 00
Device Protocol: 00
Maximum Default Endpoint Size: 8
Number of Configurations: 1
Vendor Id: 062a
Product Id: 0000
Revision Number:  2.04

Config Number: 0
	Number of Interfaces: 1
	Attributes: a0
	MaxPower Needed: 100mA

	Interface Number: 0
		Name: (none)
		Alternate Number: 0
		Class: 03(HID  ) 
		Sub Class: 1
		Protocol: 2
		Number of Endpoints: 1

			Endpoint Address: 81
			Direction: in
			Attribute: 3
			Type: Int.
			Max Packet Size: 4
			Interval: 10ms
##################EOF#########################

Then, when I unplug the device on dmesg I get this:
drivers/usb/core/usb.c: usb_hotplug
usb 2-1: config 0 descriptor??
hub 2-0:1.0: port 1, status 100, change 3, 12 Mb/s
usb 2-1: USB disconnect, address 2
usb 2-1: usb_disable_device nuking all URBs
usb 2-1: unregistering interface
Unable to handle kernel NULL pointer dereference at virtual address
00000008
 printing eip:
c015966f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c015966f>]    Not tainted
EFLAGS: 00010296
EIP is at __lookup_hash+0x1b/0xd0
eax: cf55be98   ebx: 12fd28db   ecx: ffffffff   edx: 01b9ec71
esi: c03a1c18   edi: 00000000   ebp: 00000000   esp: cf55be5c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 2554, threadinfo=cf55a000 task=cf9726a0)
Stack: c036a2c0 cf55be8c 00000000 12fd28db c03a1c18 c033b5bc ceb29728
c0159743
       cf55be98 00000000 00000000 c017a96c cf55be98 00000000 00000282
c033b5b7
       00000005 12fd28db 00000282 ce003694 ceb29600 c017be07 00000000
c033b5b7
Call Trace:
 [<c0159743>] lookup_hash+0x1f/0x23
 [<c017a96c>] sysfs_get_dentry+0x6a/0x70
 [<c017be07>] sysfs_remove_group+0x65/0x6a
 [<c023e536>] dpm_sysfs_remove+0x1a/0x20
 [<c023dfff>] device_pm_remove+0x26/0x71
 [<c023bbd3>] device_del+0x65/0x9b
 [<d1952bf0>] usb_disable_device+0xdb/0x116 [usbcore]
 [<d194cc85>] usb_disconnect+0x9f/0x12f [usbcore]
 [<d194f7a0>] hub_port_connect_change+0x394/0x399 [usbcore]
 [<d194fbac>] hub_events+0x407/0x470 [usbcore]
 [<d194fc42>] hub_thread+0x2d/0xf7 [usbcore]
 [<c0108ffe>] ret_from_fork+0x6/0x14
 [<c011a208>] default_wake_function+0x0/0x12
 [<d194fc15>] hub_thread+0x0/0xf7 [usbcore]
 [<c0107289>] kernel_thread_helper+0x5/0xb

Code: 8b 77 08 89 6c 24 08 c7 44 24 04 01 00 00 00 89 34 24 e8 30
 <7>drivers/usb/host/uhci-hcd.c: efe0: suspend_hc
drivers/usb/host/uhci-hcd.c: efe0: wakeup_hc
drivers/usb/host/uhci-hcd.c: efe0: suspend_hc
drivers/usb/host/uhci-hcd.c: efe0: wakeup_hc   <------------
drivers/usb/host/uhci-hcd.c: efe0: suspend_hc  <------------ this 2
lines are printed forever.
##############################EOF############################

I hope this info will be usefull for u.



El mié, 17-12-2003 a las 01:55, Greg KH escribió:
> On Wed, Dec 17, 2003 at 01:33:48AM +0100, Carlos Jiménez wrote:
> > ok thanx I'll try it, and i'll notify you
> > 
> > Excuse my english (I am from spain, and I not practice english too much
> > :)
> > 
> > On 2.6.0-alltest (not yet probed with bk) all usb devices works good
> > (usb-storage with an aiptek cam, and usbfloppy).
> > 
> > When I plug in that mouse, usbview shows it as an unrecognized device.
> 
> What does /proc/bus/usb/devices show with the mouse plugged in?  Do you
> have the usb hid driver loaded?
> 
> > The device does not work at all, cat /dev/input/mice , cat
> > /dev/input/mouse0 and cat /dev/usbmouse shows anything when I move the
> > usbmouse, (on 2.4.2x kernel device works good, and I was wathcing ascii
> > characters, when I  was moving it).
> > 
> > Then, when I removed the device, or when i try to unload uhci-hcd (while
> > device is plugged) kernel show that info, and all about usb goes down. I
> > cant unload, load, anything about modules, and I have to use sync before
> > poweroff to power off the system whithout breakin filesystems.
> 
> Yeah, there are still some races there.  Hopefully the latest -bk tree
> (or test11) will fix a lot of these.
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

