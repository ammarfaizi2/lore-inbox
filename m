Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287631AbSCCQe6>; Sun, 3 Mar 2002 11:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287425AbSCCQeu>; Sun, 3 Mar 2002 11:34:50 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:58635 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S287421AbSCCQek>; Sun, 3 Mar 2002 11:34:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Stephen Mollett <molletts@yahoo.com>
Organization: Total lack thereof
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Handling of bogus PCI bus numbering - case closed
Date: Sun, 3 Mar 2002 16:35:47 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16hXTe-0004WX-00@the-village.bc.nu>
In-Reply-To: <E16hXTe-0004WX-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hYwY-000I0W-0U@anchor-post-30.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 Mar 2002 15:00, Alan Cox wrote:
> ... Can you run dmidecode on your laptop
> and hopefully we can catch that laptop and automtically do bus assignment
> for it

dmidecode output follows:

SMBIOS 2.3 present.
DMI 2.3 present.
31 structures occupying 876 bytes.
DMI table at 0x000EABC0.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information Block
		Vendor: IBM
		Version: IRET75WW
		Release: 11/30/1999
		BIOS base: 0xEA720
		ROM size: 448K
		Capabilities:
			Flags: 0x0000000000011F90
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information Block
		Vendor: IBM
		Product: 260921G
		Version: Not Available
		Serial Number: BAZAPVF
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor: IBM
		Product: 2609BS1
		Version: Not Available
		Serial Number: PLR-SERIAL#
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information Block
		Vendor: IBM
		Chassis Type: Notebook
		Version: Not Available
		Serial Number: Not Available
		Asset Tag: Not Available
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor
		Socket Designation: MMC 2
		Processor Type: Central Processor
		Processor Family: Celeron processor
		Processor Manufacturer: GenuineIntel
		Processor Version: Celeron(TM)
Handle 0x0005
	DMI type 5, 20 bytes.
	Memory Controller
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: CN24
		Banks: 0 1
		Speed: 15nS
		Type: 
		Installed Size: 64Mbyte (Double sided)
		Enabled Size: 64Mbyte (Double sided)
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: CN25
		Banks: 2 3
		Speed: 15nS
		Type: 
		Installed Size: 128Mbyte (Double sided)
		Enabled Size: 128Mbyte (Double sided)
Handle 0x0008
	DMI type 7, 19 bytes.
	Cache
		Socket: L1 Cache
		L1 socketed Internal Cache: write-back
		L1 Cache Size: 32K
		L1 Cache Maximum: 32K
		L1 Cache Type: Asynchronous 
Handle 0x0009
	DMI type 7, 19 bytes.
	Cache
		Socket: L2 Cache
		L2 socketed External Cache: write-back
		L2 Cache Size: 256K
		L2 Cache Maximum: 128K
		L2 Cache Type: Unknown 
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: CN7
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Designator: COM 1
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16650A Compatible
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: CN1
		Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
		External Designator: Parallel
		External Connector Type: DB-25 pin female
		Port Type: Parallel Port ECP/EPP
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: CN14
		Internal Connector Type: None
		External Designator: Keyboard
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: CN14
		Internal Connector Type: None
		External Designator: PS/2 Mouse
		External Connector Type: Circular DIN-8 male
		Port Type: Mouse Port
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: CN4
		Internal Connector Type: None
		External Designator: USB
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: CN13
		Internal Connector Type: None
		External Designator: Infrared
		External Connector Type: Infrared
		Port Type: Other
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: SM1
		Internal Connector Type: None
		External Designator: Lucent Modem
		External Connector Type: RJ-11
		Port Type: Modem Port
Handle 0x0011
	DMI type 9, 13 bytes.
	Card Slot
		Slot: CardBus Slot 1
		Type: 32bit PCMCIA VLB 
		Status: Available.
		Slot Features: 5v 3.3v PCCard16 CardBus Zoom-Video 
Handle 0x0012
	DMI type 10, 8 bytes.
	On Board Devices Information
		Description: Video (NeoMagic NM2160) : Disabled
		Type: 
		Description: ESS 1946 : Disabled
		Type: 
Handle 0x0013
	DMI type 11, 5 bytes.
	OEM Data
		Intel 440BX NoteBook
		IBM ThinkPad
Handle 0x0014
	DMI type 12, 5 bytes.
	Configuration Information
Handle 0x0015
	DMI type 16, 15 bytes.
	Physical Memory Array
Handle 0x0016
	DMI type 17, 23 bytes.
	Memory Device
Handle 0x0017
	DMI type 17, 23 bytes.
	Memory Device
Handle 0x0018
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
Handle 0x0019
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x001A
	DMI type 21, 7 bytes.
03 04 02                                        	...             
Handle 0x001B
	DMI type 31, 28 bytes.
00 00 00 00 4e 61 bc 00 4e 61 bc 00 00 00 00 00 	....Na..Na......
00 00 00 00 00 00 00 00                         	........        
Handle 0x001C
	DMI type 32, 20 bytes.
	System Boot Information
Handle 0x001D
	DMI type 126, 4 bytes.
	Inactive
Handle 0x001E
	DMI type 127, 4 bytes.
	End-of-Table
