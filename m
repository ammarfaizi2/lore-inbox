Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274902AbTHKXCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 19:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274903AbTHKXCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 19:02:43 -0400
Received: from bay1-f7.bay1.hotmail.com ([65.54.245.7]:30986 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S274902AbTHKXC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 19:02:27 -0400
X-Originating-IP: [66.130.253.98]
X-Originating-Email: [n0px90@hotmail.com]
From: "n0p n0p" <n0px90@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Keyboard
Date: Mon, 11 Aug 2003 23:02:23 +0000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_7858_c9c_29da"
Message-ID: <BAY1-F7g07MJJQ873Tl0003371e@hotmail.com>
X-OriginalArrivalTime: 11 Aug 2003 23:02:23.0989 (UTC) FILETIME=[A0581250:01C3605C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_7858_c9c_29da
Content-Type: text/plain; format=flowed

My keyboard is repeating char.

When I type on my usb laptop keyboard, it sometime repeat char and it only
stop if I push the key again. If it's the backspace that repeat, it can
erase an entire text if I don't push the key again fast enought.

Here is what is enable in my kernel that repport to the usb :

# ALSA USB devices
# CONFIG_SND_USB_AUDIO is not set
# USB support
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
# Miscellaneous USB options
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# USB Host Controller Drivers
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# USB Device Class drivers
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_STORAGE is not set
# USB Human Interface Devices (HID)
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y

This is the listening of dmesg about the keyboard :

input: AT Set 2 keyboard on isa0060/serio0

It say "2" keyboard and I own one only...

This is what happen if I type kbdrate :

bash-2.05b# kbdrate


























Typematic Rate set to 10.9 cps (delay = 250 ms)
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#
bash-2.05b#

radeon 115736 2 - Live 0xe1902000
orinoco_cs 7048 1 - Live 0xe18c4000
orinoco 44676 1 orinoco_cs, Live 0xe18d3000
hermes 7936 2 orinoco_cs,orinoco, Live 0xe18c1000

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #03
1400-14ff : PCI CardBus #03
1800-18ff : PCI CardBus #07
1c00-1cff : PCI CardBus #07
7000-70ff : Realtek Semiconducto RTL-8139/8139C/8139C
  7000-70ff : 8139too
8000-801f : Intel Corp. 82801BA/BAM USB (Hub
  8000-801f : uhci-hcd
8060-807f : Intel Corp. 82801BA/BAM USB (Hub
  8060-807f : uhci-hcd
a000-afff : PCI Bus #01
  a000-a0ff : ATI Technologies Inc Radeon Mobility M6 L
b000-b0ff : Intel Corp. 82801BA/BAM AC'97 Au
  b000-b0ff : Intel ICH2
b400-b43f : Intel Corp. 82801BA/BAM AC'97 Au
  b400-b43f : Intel ICH2
b800-b8ff : Intel Corp. 82801BA/BAM AC'97 Mo
bc00-bc7f : Intel Corp. 82801BA/BAM AC'97 Mo
bc90-bc9f : Intel Corp. 82801BA IDE U100
  bc90-bc97 : ide0
  bc98-bc9f : ide1
f300-f30f : Intel Corp. 82801BA/BAM SMBus

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffdffff : System RAM
  00100000-00358838 : Kernel code
  00358839-0044f5ff : Kernel data
1ffe0000-1fff7fff : ACPI Non-volatile Storage
20000000-20000fff : Texas Instruments PCI1250 PC card Card
20001000-20001fff : Texas Instruments PCI1250 PC card Card (#2)
20400000-207fffff : PCI CardBus #03
20800000-20bfffff : PCI CardBus #03
20c00000-20ffffff : PCI CardBus #07
21000000-213fffff : PCI CardBus #07
60000000-60000fff : card services
80100000-801007ff : Texas Instruments TSB43AB21 IEEE-1394a
80100800-801008ff : Realtek Semiconducto RTL-8139/8139C/8139C
  80100800-801008ff : 8139too
80104000-80107fff : Texas Instruments TSB43AB21 IEEE-1394a
80500000-805fffff : PCI Bus #01
  80500000-8050ffff : ATI Technologies Inc Radeon Mobility M6 L
80600000-900fffff : PCI Bus #01
  88000000-8fffffff : ATI Technologies Inc Radeon Mobility M6 L
    88000000-88ffffff : vesafb
e0000000-efffffff : Intel Corp. 82845 845 (Brookdale
ffff0000-ffffffff : reserved

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge 
(rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio 
(rev 05)
00:1f.6 Modem: Intel Corp. Intel 537 [82801BA/BAM AC'97 Modem] (rev 05)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 
LY
02:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 
Controller (PHY/Link)
02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
02:09.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller 
(rev 01)
02:09.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller 
(rev 01)

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.20GHz
stepping	: 4
cpu MHz		: 550.012
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 
clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 1085.44

The real speed of my cpu is 2200.048 but I told you I'm using cpufreq...

P.S. I joined the same text but in the original txt format.

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*.  
http://join.msn.com/?page=features/featuredemail

------=_NextPart_000_7858_c9c_29da
Content-Type: application/octet-stream; name="keyboard"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="keyboard"

TXkga2V5Ym9hcmQgaXMgcmVwZWF0aW5nIGNoYXIuCgpXaGVuIEkgdHlwZSBv
biBteSB1c2IgbGFwdG9wIGtleWJvYXJkLCBpdCBzb21ldGltZSByZXBlYXQg
Y2hhciBhbmQgaXQgb25seQpzdG9wIGlmIEkgcHVzaCB0aGUga2V5IGFnYWlu
LiBJZiBpdCdzIHRoZSBiYWNrc3BhY2UgdGhhdCByZXBlYXQsIGl0IGNhbgpl
cmFzZSBhbiBlbnRpcmUgdGV4dCBpZiBJIGRvbid0IHB1c2ggdGhlIGtleSBh
Z2FpbiBmYXN0IGVub3VnaHQuCgpIZXJlIGlzIHdoYXQgaXMgZW5hYmxlIGlu
IG15IGtlcm5lbCB0aGF0IHJlcHBvcnQgdG8gdGhlIHVzYiA6CgojIEFMU0Eg
VVNCIGRldmljZXMKIyBDT05GSUdfU05EX1VTQl9BVURJTyBpcyBub3Qgc2V0
CiMgVVNCIHN1cHBvcnQKQ09ORklHX1VTQj15CiMgQ09ORklHX1VTQl9ERUJV
RyBpcyBub3Qgc2V0CiMgTWlzY2VsbGFuZW91cyBVU0Igb3B0aW9ucwpDT05G
SUdfVVNCX0RFVklDRUZTPXkKQ09ORklHX1VTQl9CQU5EV0lEVEg9eQojIENP
TkZJR19VU0JfRFlOQU1JQ19NSU5PUlMgaXMgbm90IHNldAojIFVTQiBIb3N0
IENvbnRyb2xsZXIgRHJpdmVycwojIENPTkZJR19VU0JfRUhDSV9IQ0QgaXMg
bm90IHNldAojIENPTkZJR19VU0JfT0hDSV9IQ0QgaXMgbm90IHNldApDT05G
SUdfVVNCX1VIQ0lfSENEPXkKIyBVU0IgRGV2aWNlIENsYXNzIGRyaXZlcnMK
IyBDT05GSUdfVVNCX0FVRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0JM
VUVUT09USF9UVFkgaXMgbm90IHNldAojIENPTkZJR19VU0JfTUlESSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9BQ00gaXMgbm90IHNldAojIENPTkZJR19V
U0JfUFJJTlRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFIGlz
IG5vdCBzZXQKIyBVU0IgSHVtYW4gSW50ZXJmYWNlIERldmljZXMgKEhJRCkK
Q09ORklHX1VTQl9ISUQ9eQpDT05GSUdfVVNCX0hJRElOUFVUPXkKClRoaXMg
aXMgdGhlIGxpc3RlbmluZyBvZiBkbWVzZyBhYm91dCB0aGUga2V5Ym9hcmQg
OgoKaW5wdXQ6IEFUIFNldCAyIGtleWJvYXJkIG9uIGlzYTAwNjAvc2VyaW8w
CgpJdCBzYXkgIjIiIGtleWJvYXJkIGFuZCBJIG93biBvbmUgb25seS4uLgoK
VGhpcyBpcyB3aGF0IGhhcHBlbiBpZiBJIHR5cGUga2JkcmF0ZSA6CgpiYXNo
LTIuMDViIyBrYmRyYXRlIAoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKClR5
cGVtYXRpYyBSYXRlIHNldCB0byAxMC45IGNwcyAoZGVsYXkgPSAyNTAgbXMp
CmJhc2gtMi4wNWIjIApiYXNoLTIuMDViIyAKYmFzaC0yLjA1YiMgCmJhc2gt
Mi4wNWIjIApiYXNoLTIuMDViIyAKYmFzaC0yLjA1YiMgCmJhc2gtMi4wNWIj
IApiYXNoLTIuMDViIyAKYmFzaC0yLjA1YiMgCmJhc2gtMi4wNWIjIApiYXNo
LTIuMDViIyAKYmFzaC0yLjA1YiMgCmJhc2gtMi4wNWIjIApiYXNoLTIuMDVi
IyAKYmFzaC0yLjA1YiMgCmJhc2gtMi4wNWIjIApiYXNoLTIuMDViIyAKYmFz
aC0yLjA1YiMgCmJhc2gtMi4wNWIjIApiYXNoLTIuMDViIyAKYmFzaC0yLjA1
YiMgCmJhc2gtMi4wNWIjIApiYXNoLTIuMDViIyAKYmFzaC0yLjA1YiMgCmJh
c2gtMi4wNWIjIApiYXNoLTIuMDViIyAKYmFzaC0yLjA1YiMgCmJhc2gtMi4w
NWIjIApiYXNoLTIuMDViIyAKCnJhZGVvbiAxMTU3MzYgMiAtIExpdmUgMHhl
MTkwMjAwMApvcmlub2NvX2NzIDcwNDggMSAtIExpdmUgMHhlMThjNDAwMApv
cmlub2NvIDQ0Njc2IDEgb3Jpbm9jb19jcywgTGl2ZSAweGUxOGQzMDAwCmhl
cm1lcyA3OTM2IDIgb3Jpbm9jb19jcyxvcmlub2NvLCBMaXZlIDB4ZTE4YzEw
MDAKCjAwMDAtMDAxZiA6IGRtYTEKMDAyMC0wMDIxIDogcGljMQowMDQwLTAw
NWYgOiB0aW1lcgowMDYwLTAwNmYgOiBrZXlib2FyZAowMDcwLTAwNzcgOiBy
dGMKMDA4MC0wMDhmIDogZG1hIHBhZ2UgcmVnCjAwYTAtMDBhMSA6IHBpYzIK
MDBjMC0wMGRmIDogZG1hMgowMGYwLTAwZmYgOiBmcHUKMDEwMC0wMTNmIDog
b3Jpbm9jb19jcwowMTcwLTAxNzcgOiBpZGUxCjAxZjAtMDFmNyA6IGlkZTAK
MDM3Ni0wMzc2IDogaWRlMQowM2MwLTAzZGYgOiB2ZXNhZmIKMDNmNi0wM2Y2
IDogaWRlMAowM2Y4LTAzZmYgOiBzZXJpYWwKMGNmOC0wY2ZmIDogUENJIGNv
bmYxCjEwMDAtMTBmZiA6IFBDSSBDYXJkQnVzICMwMwoxNDAwLTE0ZmYgOiBQ
Q0kgQ2FyZEJ1cyAjMDMKMTgwMC0xOGZmIDogUENJIENhcmRCdXMgIzA3CjFj
MDAtMWNmZiA6IFBDSSBDYXJkQnVzICMwNwo3MDAwLTcwZmYgOiBSZWFsdGVr
IFNlbWljb25kdWN0byBSVEwtODEzOS84MTM5Qy84MTM5QwogIDcwMDAtNzBm
ZiA6IDgxMzl0b28KODAwMC04MDFmIDogSW50ZWwgQ29ycC4gODI4MDFCQS9C
QU0gVVNCIChIdWIKICA4MDAwLTgwMWYgOiB1aGNpLWhjZAo4MDYwLTgwN2Yg
OiBJbnRlbCBDb3JwLiA4MjgwMUJBL0JBTSBVU0IgKEh1YgogIDgwNjAtODA3
ZiA6IHVoY2ktaGNkCmEwMDAtYWZmZiA6IFBDSSBCdXMgIzAxCiAgYTAwMC1h
MGZmIDogQVRJIFRlY2hub2xvZ2llcyBJbmMgUmFkZW9uIE1vYmlsaXR5IE02
IEwKYjAwMC1iMGZmIDogSW50ZWwgQ29ycC4gODI4MDFCQS9CQU0gQUMnOTcg
QXUKICBiMDAwLWIwZmYgOiBJbnRlbCBJQ0gyCmI0MDAtYjQzZiA6IEludGVs
IENvcnAuIDgyODAxQkEvQkFNIEFDJzk3IEF1CiAgYjQwMC1iNDNmIDogSW50
ZWwgSUNIMgpiODAwLWI4ZmYgOiBJbnRlbCBDb3JwLiA4MjgwMUJBL0JBTSBB
Qyc5NyBNbwpiYzAwLWJjN2YgOiBJbnRlbCBDb3JwLiA4MjgwMUJBL0JBTSBB
Qyc5NyBNbwpiYzkwLWJjOWYgOiBJbnRlbCBDb3JwLiA4MjgwMUJBIElERSBV
MTAwCiAgYmM5MC1iYzk3IDogaWRlMAogIGJjOTgtYmM5ZiA6IGlkZTEKZjMw
MC1mMzBmIDogSW50ZWwgQ29ycC4gODI4MDFCQS9CQU0gU01CdXMKCjAwMDAw
MDAwLTAwMDlmYmZmIDogU3lzdGVtIFJBTQowMDA5ZmMwMC0wMDA5ZmZmZiA6
IHJlc2VydmVkCjAwMGEwMDAwLTAwMGJmZmZmIDogVmlkZW8gUkFNIGFyZWEK
MDAwYzAwMDAtMDAwYzdmZmYgOiBWaWRlbyBST00KMDAwZjAwMDAtMDAwZmZm
ZmYgOiBTeXN0ZW0gUk9NCjAwMTAwMDAwLTFmZmRmZmZmIDogU3lzdGVtIFJB
TQogIDAwMTAwMDAwLTAwMzU4ODM4IDogS2VybmVsIGNvZGUKICAwMDM1ODgz
OS0wMDQ0ZjVmZiA6IEtlcm5lbCBkYXRhCjFmZmUwMDAwLTFmZmY3ZmZmIDog
QUNQSSBOb24tdm9sYXRpbGUgU3RvcmFnZQoyMDAwMDAwMC0yMDAwMGZmZiA6
IFRleGFzIEluc3RydW1lbnRzIFBDSTEyNTAgUEMgY2FyZCBDYXJkCjIwMDAx
MDAwLTIwMDAxZmZmIDogVGV4YXMgSW5zdHJ1bWVudHMgUENJMTI1MCBQQyBj
YXJkIENhcmQgKCMyKQoyMDQwMDAwMC0yMDdmZmZmZiA6IFBDSSBDYXJkQnVz
ICMwMwoyMDgwMDAwMC0yMGJmZmZmZiA6IFBDSSBDYXJkQnVzICMwMwoyMGMw
MDAwMC0yMGZmZmZmZiA6IFBDSSBDYXJkQnVzICMwNwoyMTAwMDAwMC0yMTNm
ZmZmZiA6IFBDSSBDYXJkQnVzICMwNwo2MDAwMDAwMC02MDAwMGZmZiA6IGNh
cmQgc2VydmljZXMKODAxMDAwMDAtODAxMDA3ZmYgOiBUZXhhcyBJbnN0cnVt
ZW50cyBUU0I0M0FCMjEgSUVFRS0xMzk0YQo4MDEwMDgwMC04MDEwMDhmZiA6
IFJlYWx0ZWsgU2VtaWNvbmR1Y3RvIFJUTC04MTM5LzgxMzlDLzgxMzlDCiAg
ODAxMDA4MDAtODAxMDA4ZmYgOiA4MTM5dG9vCjgwMTA0MDAwLTgwMTA3ZmZm
IDogVGV4YXMgSW5zdHJ1bWVudHMgVFNCNDNBQjIxIElFRUUtMTM5NGEKODA1
MDAwMDAtODA1ZmZmZmYgOiBQQ0kgQnVzICMwMQogIDgwNTAwMDAwLTgwNTBm
ZmZmIDogQVRJIFRlY2hub2xvZ2llcyBJbmMgUmFkZW9uIE1vYmlsaXR5IE02
IEwKODA2MDAwMDAtOTAwZmZmZmYgOiBQQ0kgQnVzICMwMQogIDg4MDAwMDAw
LThmZmZmZmZmIDogQVRJIFRlY2hub2xvZ2llcyBJbmMgUmFkZW9uIE1vYmls
aXR5IE02IEwKICAgIDg4MDAwMDAwLTg4ZmZmZmZmIDogdmVzYWZiCmUwMDAw
MDAwLWVmZmZmZmZmIDogSW50ZWwgQ29ycC4gODI4NDUgODQ1IChCcm9va2Rh
bGUKZmZmZjAwMDAtZmZmZmZmZmYgOiByZXNlcnZlZAoKMDA6MDAuMCBIb3N0
IGJyaWRnZTogSW50ZWwgQ29ycC4gODI4NDUgODQ1IChCcm9va2RhbGUpIENo
aXBzZXQgSG9zdCBCcmlkZ2UgKHJldiAwNCkKMDA6MDEuMCBQQ0kgYnJpZGdl
OiBJbnRlbCBDb3JwLiA4Mjg0NSA4NDUgKEJyb29rZGFsZSkgQ2hpcHNldCBB
R1AgQnJpZGdlIChyZXYgMDQpCjAwOjFlLjAgUENJIGJyaWRnZTogSW50ZWwg
Q29ycC4gODI4MDFCQS9DQS9EQiBQQ0kgQnJpZGdlIChyZXYgMDUpCjAwOjFm
LjAgSVNBIGJyaWRnZTogSW50ZWwgQ29ycC4gODI4MDFCQSBJU0EgQnJpZGdl
IChMUEMpIChyZXYgMDUpCjAwOjFmLjEgSURFIGludGVyZmFjZTogSW50ZWwg
Q29ycC4gODI4MDFCQSBJREUgVTEwMCAocmV2IDA1KQowMDoxZi4yIFVTQiBD
b250cm9sbGVyOiBJbnRlbCBDb3JwLiA4MjgwMUJBL0JBTSBVU0IgKEh1YiAj
MSkgKHJldiAwNSkKMDA6MWYuMyBTTUJ1czogSW50ZWwgQ29ycC4gODI4MDFC
QS9CQU0gU01CdXMgKHJldiAwNSkKMDA6MWYuNCBVU0IgQ29udHJvbGxlcjog
SW50ZWwgQ29ycC4gODI4MDFCQS9CQU0gVVNCIChIdWIgIzIpIChyZXYgMDUp
CjAwOjFmLjUgTXVsdGltZWRpYSBhdWRpbyBjb250cm9sbGVyOiBJbnRlbCBD
b3JwLiA4MjgwMUJBL0JBTSBBQyc5NyBBdWRpbyAocmV2IDA1KQowMDoxZi42
IE1vZGVtOiBJbnRlbCBDb3JwLiBJbnRlbCA1MzcgWzgyODAxQkEvQkFNIEFD
Jzk3IE1vZGVtXSAocmV2IDA1KQowMTowMC4wIFZHQSBjb21wYXRpYmxlIGNv
bnRyb2xsZXI6IEFUSSBUZWNobm9sb2dpZXMgSW5jIFJhZGVvbiBNb2JpbGl0
eSBNNiBMWQowMjowMy4wIEZpcmVXaXJlIChJRUVFIDEzOTQpOiBUZXhhcyBJ
bnN0cnVtZW50cyBUU0I0M0FCMjEgSUVFRS0xMzk0YS0yMDAwIENvbnRyb2xs
ZXIgKFBIWS9MaW5rKQowMjowNS4wIEV0aGVybmV0IGNvbnRyb2xsZXI6IFJl
YWx0ZWsgU2VtaWNvbmR1Y3RvciBDby4sIEx0ZC4gUlRMLTgxMzkvODEzOUMv
ODEzOUMrIChyZXYgMTApCjAyOjA5LjAgQ2FyZEJ1cyBicmlkZ2U6IFRleGFz
IEluc3RydW1lbnRzIFBDSTEyNTAgUEMgY2FyZCBDYXJkYnVzIENvbnRyb2xs
ZXIgKHJldiAwMSkKMDI6MDkuMSBDYXJkQnVzIGJyaWRnZTogVGV4YXMgSW5z
dHJ1bWVudHMgUENJMTI1MCBQQyBjYXJkIENhcmRidXMgQ29udHJvbGxlciAo
cmV2IDAxKQoKcHJvY2Vzc29yCTogMAp2ZW5kb3JfaWQJOiBHZW51aW5lSW50
ZWwKY3B1IGZhbWlseQk6IDE1Cm1vZGVsCQk6IDIKbW9kZWwgbmFtZQk6IElu
dGVsKFIpIFBlbnRpdW0oUikgNCBDUFUgMi4yMEdIegpzdGVwcGluZwk6IDQK
Y3B1IE1IegkJOiA1NTAuMDEyCmNhY2hlIHNpemUJOiA1MTIgS0IKZmRpdl9i
dWcJOiBubwpobHRfYnVnCQk6IG5vCmYwMGZfYnVnCTogbm8KY29tYV9idWcJ
OiBubwpmcHUJCTogeWVzCmZwdV9leGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2
ZWwJOiAyCndwCQk6IHllcwpmbGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0c2Mg
bXNyIHBhZSBtY2UgY3g4IHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNl
MzYgY2xmbHVzaCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBzcyBodCB0
bQpib2dvbWlwcwk6IDEwODUuNDQKClRoZSByZWFsIHNwZWVkIG9mIG15IGNw
dSBpcyAyMjAwLjA0OCBidXQgSSB0b2xkIHlvdSBJJ20gdXNpbmcgY3B1ZnJl
cS4uLg==


------=_NextPart_000_7858_c9c_29da--
