Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288194AbSACEUC>; Wed, 2 Jan 2002 23:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288192AbSACETx>; Wed, 2 Jan 2002 23:19:53 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:61387 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S288194AbSACETl>; Wed, 2 Jan 2002 23:19:41 -0500
Message-ID: <3C33DAC8.E6872F16@didntduck.org>
Date: Wed, 02 Jan 2002 23:15:04 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102220333.A26713@thyrsus.com> <Pine.LNX.4.33.0201030420160.6449-100000@Appserv.suse.de> <20020102221845.A27252@thyrsus.com> <3C33D1B0.4DFDF76E@didntduck.org> <20020102223523.A27644@thyrsus.com>
Content-Type: multipart/mixed;
 boundary="------------2EBEDED97DDABE29CB865B5C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2EBEDED97DDABE29CB865B5C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Eric S. Raymond" wrote:
> 
> Brian Gerst <bgerst@didntduck.org>:
> > > Not in this case.  If the DMI read fails, the worst-case result is the
> > > user sees some ISA extra questions.
> >
> > No, the worst case is if the DMI read says no ISA slots when there
> > really are some, and the user misses a driver that he needs.
> 
> Nobody has told me this is a real failure case yet.  To cause a problem,
> the situation would have to be that DMI read fails to detect a card in
> use in an ISA slot.  It's OK if it reports no slots when all slots are
> empty.

Well, I just popped in an old 3com 509TP network card (non-PnP) into my
main box and dmidecode still failed to show the single ISA slot, only 4
PCI and 1 AGP.

-- 

						Brian Gerst
--------------2EBEDED97DDABE29CB865B5C
Content-Type: text/plain; charset=us-ascii;
 name="dmi.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmi.out"

SMBIOS 2.3 present.
DMI 2.3 present.
26 structures occupying 1912 bytes.
DMI table at 0x000F04F0.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information Block
		Vendor: American Megatrends Inc.        
		Version: 62710                           
		Release: 07/15/97                        
		BIOS base: 0xF0000
		ROM size: 192K
		Capabilities:
			Flags: 0x000000007FCBDE90
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information Block
		Vendor:                                 
		Product:                                 
		Version: 0000000                         
		Serial Number:                                 
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor: FIC                             
		Product: SD11                            
		Version: 1.x                             
		Serial Number: 00000000                        
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information Block
		Vendor:                                 
		Chassis Type: Desktop
		Version: 1.0                             
		Serial Number: 0000000                         
		Asset Tag:                                 
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor
		Socket Designation: Slot-A                          
		Processor Type: Central Processor
		Processor Family: K5 Family
		Processor Manufacturer: AMD             
		Processor Version: Athlon(tm)      
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache
		Socket: L1 Cache                        
		L1 Internal Cache: write-back
		L1 Cache Size: 128K
		L1 Cache Maximum: 128K
		L1 Cache Type: Synchronous 
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache
		Socket: L2 Cache                        
		L2 Internal Cache: write-back
		L2 Cache Size: 8192K
		L2 Cache Maximum: 512K
		L2 Cache Type: Synchronous 
Handle 0x0007
	DMI type 5, 22 bytes.
	Memory Controller
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM1                           
		Banks: 0 1
		Speed: 15nS
		Type: 
		Installed Size: 128Mbyte (Double sided)
		Enabled Size: 128Mbyte (Double sided)
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM2                           
		Banks: 2 3
		Speed: 15nS
		Type: 
		Installed Size: 256Mbyte (Double sided)
		Enabled Size: 256Mbyte (Double sided)
Handle 0x000A
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM3                           
		Banks: 4 5
		Speed: 15nS
		Type: 
		Installed Size: 128Mbyte (Double sided)
		Enabled Size: 128Mbyte (Double sided)
Handle 0x000B
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI1                            
		Type: 32bit PCI 
		Status: Available.
		Slot Features: 3.3v Shared 
Handle 0x000C
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI2                            
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 3.3v Shared 
Handle 0x000D
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI3                            
		Type: 32bit PCI 
		Status: Available.
		Slot Features: 3.3v Shared 
Handle 0x000E
	DMI type 9, 13 bytes.
	Card Slot
		Slot: PCI4                            
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 3.3v Shared 
Handle 0x000F
	DMI type 9, 13 bytes.
	Card Slot
		Slot: AGP                             
		Type: 32bit AGP 4x 
		Status: In use.
		Slot Features: 3.3v Shared 
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: COM Port                        
		Internal Connector Type: None
		External Designator: Serial Port A                   
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16650A Compatible
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: COM Port                        
		Internal Connector Type: None
		External Designator: Serial Port B                   
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16650A Compatible
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: LPT Port                        
		Internal Connector Type: None
		External Designator: Parallel Port                   
		External Connector Type: DB-25 pin female
		Port Type: Parallel Port ECP/EPP
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: Keyboard                        
		Internal Connector Type: None
		External Designator: Keyboard                        
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: Mouse                           
		Internal Connector Type: None
		External Designator: PS/2 Mouse                      
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x0015
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: Floppy                          
		Internal Connector Type: On Board Floppy
		External Designator: Floppy                          
		External Connector Type: None
		Port Type: None
Handle 0x0016
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: Primary IDE                     
		Internal Connector Type: On Board IDE
		External Designator: IDE-1                           
		External Connector Type: None
		Port Type: None
Handle 0x0017
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: Secondary IDE                   
		Internal Connector Type: On Board IDE
		External Designator: IDE-2                           
		External Connector Type: None
		Port Type: None
Handle 0x0018
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: USB Port                        
		Internal Connector Type: None
		External Designator: USB                             
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0019
	DMI type 13, 22 bytes.
	BIOS Language Information

--------------2EBEDED97DDABE29CB865B5C--

