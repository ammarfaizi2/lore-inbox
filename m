Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSFCIFi>; Mon, 3 Jun 2002 04:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317307AbSFCIFh>; Mon, 3 Jun 2002 04:05:37 -0400
Received: from gateway.jabil.com ([198.51.174.14]:14185 "HELO
	corrly02.jabil.com") by vger.kernel.org with SMTP
	id <S317306AbSFCIFf>; Mon, 3 Jun 2002 04:05:35 -0400
X-Server-Uuid: 492ed892-c84e-11d3-bc9a-0008c7b13976
Message-ID: <86D0D7E1B6BA1049B4D0FDAE456354E3016F039D@livmsgn10b>
From: "Andrew Potter" <Andrew_Potter@Jabil.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.18-6mdk dmesg errors
Date: Mon, 3 Jun 2002 04:05:34 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 10E5FCF7521210-02-02
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Can someone give me a clue as to the following,

	I am running kernel 2.4.18-6mdk on a Digital Hinote Ultra 2000
notebook with a multimedia docking station attached and get the following
errors(?) reported in dmesg during boot. ( The complete output from dmesg is
available {as are some other logs} if it would help.)
	I have enabled some debug options within the kernel to get a bit
more detail reported. Is there anything that I can do to remove/correct the
errors(?) and what do they mean?

<snip>........
PCI: BIOS32 Service Directory structure at 0xc00e8050
PCI: BIOS32 Service Directory entry at 0xeb590
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=00
PCI: PCI BIOS revision 2.10 entry at 0xeb5d0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1066/0001] 000600 00
Found 00:28 [1066/0002] 000680 00
Found 00:30 [102c/00e4] 000300 00
Found 00:38 [104c/ac15] 000607 02
Found 00:39 [104c/ac15] 000607 02
Found 00:40 [1095/0643] 000101 00
PCI: IDE base address fixup for 00:08.0
Found 00:68 [1066/0002] 000680 00
Found 00:70 [104c/ac15] 000607 02
Found 00:71 [104c/ac15] 000607 02
Found 00:78 [1095/0646] 000101 00
PCI: IDE base address fixup for 00:0f.0
Found 00:80 [1095/0670] 000c03 00
Found 00:88 [1066/0003] 00ffff 7f
PCI: device 00:11.0 has unknown header type 7f, ignoring.
<--------------Error(?)
Fixups for bus 00
PCI: Scanning for ghost devices on bus 0
Scanning behind PCI bridge 00:07.0, config 000000, pass 0
Scanning behind PCI bridge 00:07.1, config 000000, pass 0
Scanning behind PCI bridge 00:0e.0, config 000000, pass 0
Scanning behind PCI bridge 00:0e.1, config 000000, pass 0
Scanning behind PCI bridge 00:07.0, config 000000, pass 1
Scanning behind PCI bridge 00:07.1, config 000000, pass 1
Scanning behind PCI bridge 00:0e.0, config 000000, pass 1
Scanning behind PCI bridge 00:0e.1, config 000000, pass 1
Bus scan for 00 returning with max=10
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f2450
00:07 slot=00 0:01/0200 1:02/0400 2:00/0000 3:00/0000
00:0e slot=00 0:01/0200 1:02/0400 2:00/0000 3:00/0000
00:0f slot=00 0:03/8000 1:00/0000 2:00/0000 3:00/0000
00:10 slot=00 0:04/0800 1:00/0000 2:00/0000 3:00/0000
PCI: Attempting to find IRQ router for 8002:1066
PCI: Using IRQ router default [1066/0002] at 00:05.0
PCI: IRQ fixup
IRQ for 00:10.0:0 -> PIRQ 04, mask 0800, excl 0000 -> newirq=0 ... failed
<-----------Error(?)
PCI: Allocating resources
PCI: Resource 0c000000-0cffffff (f=200, d=0, p=0)
PCI: Resource 000001f0-000001ff (f=101, d=0, p=0)
PCI: Resource 000003f6-000003f6 (f=105, d=0, p=0)
PCI: Resource 0000fe00-0000fe0f (f=101, d=0, p=0)
PCI: Resource 00000170-00000177 (f=101, d=0, p=0)
PCI: Resource 00000376-00000376 (f=105, d=0, p=0)
PCI: Resource 0000ff00-0000ff0f (f=101, d=0, p=0)
PCI: Sorting device list... 
....<snip>.................
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD643: IDE controller on PCI bus 00 dev 40
PCI: Device 00:08.0 not available because of resource collisions
<--------------error(?)
CMD643: (ide_setup_pci_device:) Could not enable device.
<--------------error(?)
PCI: Device 00:08.0 not available because of resource collisions
<--------------error(?)
CMD646: IDE controller on PCI bus 00 dev 78
PCI: Device 00:0f.0 not available because of resource collisions
<--------------error(?)
CMD646: (ide_setup_pci_device:) Could not enable device.
<--------------error(?)
PCI: Device 00:0f.0 not available because of resource collisions
<--------------error(?)
hda: HITACHI_DK23BA-20, ATA DISK drive
hdd: MATSHITADVD-ROM SR-8171, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

	Any assistance would be appreciated.
	Many Thanks

	AndyP - Learning Linux one day at a time.


