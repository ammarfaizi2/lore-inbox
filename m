Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311672AbSCNQ41>; Thu, 14 Mar 2002 11:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311671AbSCNQ4T>; Thu, 14 Mar 2002 11:56:19 -0500
Received: from [151.17.201.167] ([151.17.201.167]:1296 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S311675AbSCNQ4F>;
	Thu, 14 Mar 2002 11:56:05 -0500
Message-ID: <3C90D695.8AB6F03B@teamfab.it>
Date: Thu, 14 Mar 2002 17:57:57 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Martin Dalecki <martin@dalecki.de>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Basic 2.5.x IDE tests
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've some i386 machine to make IDE tests and collect data.

if ( !needed ) exit(1);

What's the best way to make some basic tests ?

..I'm planing to write a simple shell script
that perform tests, collects data and results.

I'll do these tests during my lunch time ;) so
no cerberus or hitec labs tests but really basic
low profile tests please.

Kernel configuration
--------------------
- 2.5.x-pre-Dalecki-Vojtech : which version ???
- build kernel platform: Stock RH 7.1
- basic network
- no apm
- ext2 only
- ide + ide-scsi
- monolithic
- UP or SMP
- other options ???

chipset recognition
-------------------
- dmesg and /proc/ide/ data collect
- others ???

speed/stability
---------------
- cdrecord (-dummy)
- cdrdao
- cdda2wav
- hdparm
- bonnie++
- dd
- others ???
:

ciao,
luca


> Hardware <

(1) IBM Netfinity 3500 dual PII (only cdrw)
-------------------------------------------
00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:02.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
00:02.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:02.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:02.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
00:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 02)
00:09.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 03)
00:09.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 03)
01:00.0 VGA compatible controller: S3 Inc. ViRGE/GX2 (rev 04)

(2) UP PII on soyo MB (cdrom and HD)
------------------------------------
00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev
01)                                                                                    
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev
01)                                                                                           
00:10.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev
74)                                                                       
01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev
02)                                                                                 
                                                                                                                                                        
(3) UP Celeron on intel i810 MB (cdrom and
HD)                                                                                                          
----------------------------------------------                                                                                                          
00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev
02)                                                                                    
00:02.0 VGA compatible controller: Intel Corporation: Unknown device 1132 (rev
02)                                                                      
00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev
02)                                                                                     
00:1f.0 ISA bridge: Intel Corporation: Unknown device 2440 (rev
02)                                                                                     
00:1f.1 IDE interface: Intel Corporation: Unknown device 244b (rev
02)                                                                                  
00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev
02)                                                                                 
00:1f.3 SMBus: Intel Corporation: Unknown device 2443 (rev
02)                                                                                          
00:1f.4 USB Controller: Intel Corporation: Unknown device 2444 (rev
02)                                                                                 
00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev
02)                                                                    
01:08.0 Ethernet controller: Intel Corporation: Unknown device 2449 (rev
01)                                                                            
                                                                                                                                                        
(4) UP PIII on soyo MB (cdrom and
HD)                                                                                                                   
-------------------------------------                                                                                                                   
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev
03)                                                                       
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
03)                                                                         
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev
02)                                                                                        
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev
01)                                                                                     
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev
01)                                                                                    
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev
02)                                                                                           
00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev
01)                                                                     
00:0e.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev
01)                                                                     
00:0f.0 SCSI storage controller: Adaptec 7892A (rev
02)                                                                                                 
00:10.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev
74)                                                                       
01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev
02)                                                                                 
                                                                                                                                                        
(5) Dual PIII on Intel MB ( cdrom and HD
)                                                                                                              
------------------------------------------                                                                                                              
00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host
bridge                                                                                      
00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP
bridge                                                                                        
00:0c.0 SCSI storage controller: Adaptec
7896                                                                                                           
00:0c.1 SCSI storage controller: Adaptec
7896                                                                                                           
00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
08)                                                                        
00:12.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev
02)                                                                                        
00:12.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev
01)                                                                                     
00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev
01)                                                                                    
00:12.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev
02)                                                                                           
00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev
23)                                                                                        
01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06)    

(6) Old 330 P100 IBM ( cdrom and HD )
-------------------------------------
00:00.0 Host bridge: Intel Corporation 430FX - 82437FX TSC [Triton I] (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
00:11.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)
00:13.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)

(7) K6 400 ( cdrw and HD )
--------------------------
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev b4)
00:08.0 Network controller: Elsa AG QuickStep 1000 (rev 01)
00:09.0 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 04)
00:0a.0 Multimedia audio controller: Trident Microsystems 4DWave DX (rev 02)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100 [Productiva] AGP (rev 02)

-----------
end of list
