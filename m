Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136587AbREIQWk>; Wed, 9 May 2001 12:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136583AbREIQWb>; Wed, 9 May 2001 12:22:31 -0400
Received: from cr481834-a.ktchnr1.on.wave.home.com ([24.102.89.11]:59125 "HELO
	scotch.homeip.net") by vger.kernel.org with SMTP id <S136582AbREIQWY>;
	Wed, 9 May 2001 12:22:24 -0400
Date: Wed, 9 May 2001 12:22:17 -0400 (EDT)
From: God <atm@sdk.ca>
To: Robert Cohen <robert@coorong.anu.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question: Status of VIA chipsets and 2.2 kernels
In-Reply-To: <3AF8EE3A.21932E5D@tltsu.anu.edu.au>
Message-ID: <Pine.LNX.4.21.0105091153560.23642-100000@scotch.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2001, Robert Cohen wrote:

> From: Robert Cohen <robert@coorong.anu.edu.au>
> 
> I am thinking of buying a machine with a via chipset and I wan't to know
> how stable it is likely to be with Linux.
> I would appreciate it if someone who know's whats going on can give a
> report on the state of play
> as regards to all the problems and their current status with 2.2 kernels
> (and 2.4 if their feeling energetic).


Hi Robert,

Right now one of my boxes (gaming box) is running off of :

OS          : Linux 
Distro      : Slackware 7.1
Kernel      : 2.4.3 SMP

Mother Board: MSI KT7 Pro 2-A
Chipset     : VIA KT133
Processor   : AMD Duron 800 Mhz (Not OC'd and not modified) 

Hard disks  : Maxtor 5T060H6 (60 Gigger / 7200 RPM / UDMA100)
            : Quantum Fireball SE2.1A (2.1G / ??? RPM / UDMA33)
RAM         : 128M DIMM, PC133
Video Card  : Geforce2 GTS, 32M DDR
Network Card: I forget what I put in there.. hrmm



VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: User given PCI clock speed impossible (66), using 33 MHz instead.
VP_IDE: Use ide0=ata66 if you want to force UDMA66/UDMA100.
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:DMA
hda: QUANTUM FIREBALL SE2.1A, ATA DISK drive
hdb: Maxtor 5T060H6, ATA DISK drive
hdd: LTN403L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 4124736 sectors (2112 MB) w/80KiB Cache, CHS=1023/64/63, UDMA(33)
hdb: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=7476/255/63,
UDMA(100)
hdd: ATAPI 40X CD-ROM drive, 120kB Cache, UDMA(33)


00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
[Apollo Super AC97/Audio] (rev 50)
00:0c.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine
10/100] (rev 06)
01:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2
GTS) (rev a3)


Module                  Size  Used by
NVdriver              628304  29
via82cxxx_audio        17120   1
ac97_codec              7648   0  [via82cxxx_audio]
parport_pc             22608   1  (autoclean)
lp                      5296   1  (autoclean)
parport                29312   1  (autoclean) [parport_pc lp]
via-rhine              10272   1



All in all .... pretty stable.  I have problems with lock ups but I
believe that to be the on board sound card (AC97 crap) as any time it does
lock (especially under Wine/Half-Life), errors are usually reported to the
effect of the sound card timed out or something.  That and it periodicaly
locked up in windows too (when I was running it).

Hope this answers your question.  Just make sure you have the latest 2.4.x
kernel as things are changing rather fast ... (so much for a feature
freeze .. heh .. :) .....  btw, what ever happened to the idea of creating
a database of what runs with what ?  Personally I think redhat did it
wrong with their update network thingy ... (it has NEVER been able to
login successfully .. heh ...).  But would giving the user an option to
send an email off after an install / upgrade basicaly listing what their
system is, be a good thing?   Something like what pine does? ....






