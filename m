Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSCCNuP>; Sun, 3 Mar 2002 08:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSCCNuG>; Sun, 3 Mar 2002 08:50:06 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:12071 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S284180AbSCCNtw>; Sun, 3 Mar 2002 08:49:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Andre Hedrick <andre@linuxdiskcert.org>,
        john slee <indigoid@higherplane.net>
Subject: Re: Please
Date: Sun, 3 Mar 2002 14:49:07 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hans-Peter Jansen <hpj@urpla.net>, Henrik Lassen <henrik@lassen.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ataraid-list@redhat.com
In-Reply-To: <Pine.LNX.4.10.10203021610330.5944-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10203021610330.5944-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303134908.0D3F71546@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 3. March 2002 01:25, Andre Hedrick wrote:
> On Sun, 3 Mar 2002, john slee wrote:
> > On Sat, Mar 02, 2002 at 04:43:58PM +0100, Hans-Peter Jansen wrote:
> > > The problem is called Andre Hedrick, a guy who is talking in miracles,
> > > but seems to be unable to fix either the issues with:
> > >  - the single TX4 with multiple PDC20270
> > > nor:
> > >  - multiple TX2 with PDC20268
> > >
> > > or at least ignores further communication on that problems, if you
> > > don't use some magic storage peoples language.(*) TM in a parallel
> > > universe, not too far from here...
> >
> > so you're going to fix the problems yourself then?
> >
> > j.
>
> You mean this does not work for you?  Serious question, not being flip.
>
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD7441: IDE controller on PCI bus 00 dev 39
> AMD7441: chipset revision 3
> AMD7441: not 100% native mode: will probe irqs later
> AMD7441: disabling single-word DMA support (revision < C4)
>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
> PDC20270: IDE controller on PCI bus 03 dev 08
> PDC20270: chipset revision 2
> PDC20270: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0x9008-0x900f, BIOS settings: hdg:pio, hdh:pio
> PDC20270: IDE controller on PCI bus 03 dev 10
> PDC20270: chipset revision 2
> PDC20270: not 100% native mode: will probe irqs later
> PDC20270: ROM enabled at 0x000dc000
>     ide4: BM-DMA at 0xa400-0xa407, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0xa408-0xa40f, BIOS settings: hdk:pio, hdl:pio
> hda: IBM-DTLA-307075, ATA DISK drive
> hdc: LTN242, ATAPI CD/DVD-ROM drive
> hde: Maxtor 4G160J8, ATA DISK drive
> hdg: Maxtor 4G160J8, ATA DISK drive
> hdi: Maxtor 4G160J8, ATA DISK drive
> hdk: Maxtor 4G160J8, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0x8000-0x8007,0x8402 on irq 11
> ide3 at 0x8800-0x8807,0x8c02 on irq 11
> ide4 at 0x9400-0x9407,0x9802 on irq 11
> ide5 at 0x9c00-0x9c07,0xa002 on irq 11
> hda: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=9345/255/63,
> UDMA(100) hde: 320173056 sectors (163929 MB) w/2048KiB Cache,
> CHS=19929/255/63, UDMA(100) hdg: 320173056 sectors (163929 MB) w/2048KiB
> Cache, CHS=19929/255/63, UDMA(100) hdi: 320173056 sectors (163929 MB)
> w/2048KiB Cache, CHS=19929/255/63, UDMA(100) hdk: 320173056 sectors (163929
> MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(100) Partition check:
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 >
>  /dev/ide/host2/bus0/target0/lun0: p1
>  /dev/ide/host2/bus1/target0/lun0: p1
>  /dev/ide/host4/bus0/target0/lun0: p1
>  /dev/ide/host4/bus1/target0/lun0: p1
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
>
>
>
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD7441: IDE controller on PCI bus 00 dev 39
> AMD7441: chipset revision 3
> AMD7441: not 100% native mode: will probe irqs later
> AMD7441: disabling single-word DMA support (revision < C4)
>     ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:pio
> PDC20269: IDE controller on PCI bus 00 dev 40
> PDC20269: chipset revision 2
> PDC20269: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:pio
> PDC20269: IDE controller on PCI bus 00 dev 48
> PDC20269: chipset revision 2
> PDC20269: not 100% native mode: will probe irqs later
>     ide4: BM-DMA at 0xe800-0xe807, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0xe808-0xe80f, BIOS settings: hdk:pio, hdl:pio
> hda: IBM-DTLA-307075, ATA DISK drive
> hdc: LTN242, ATAPI CD/DVD-ROM drive
> hde: Maxtor 4G160J8, ATA DISK drive
> hdg: Maxtor 4G160J8, ATA DISK drive
> hdi: Maxtor 4G160J8, ATA DISK drive
> hdk: Maxtor 4G160J8, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xc400-0xc407,0xc802 on irq 10
> ide3 at 0xcc00-0xcc07,0xd002 on irq 10
> ide4 at 0xd800-0xd807,0xdc02 on irq 11
> ide5 at 0xe000-0xe007,0xe402 on irq 11
> hda: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=9345/255/63,
> UDMA(100) hde: 320173056 sectors (163929 MB) w/2048KiB Cache,
> CHS=19929/255/63, UDMA(133) hdg: 320173056 sectors (163929 MB) w/2048KiB
> Cache, CHS=19929/255/63, UDMA(133) hdi: 320173056 sectors (163929 MB)
> w/2048KiB Cache, CHS=19929/255/63, UDMA(133) hdk: 320173056 sectors (163929
> MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133) Partition check:
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 >
>  /dev/ide/host2/bus0/target0/lun0: p1
>  /dev/ide/host2/bus1/target0/lun0: p1
>  /dev/ide/host4/bus0/target0/lun0: p1
>  /dev/ide/host4/bus1/target0/lun0: p1
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
>

Looks promising, indeed. Will try it again, soon...

In general, I fear, that the whole ATA technology commits suiside because 
of it's own inherent complexity and historical development.

> Clearly they work, the obvious point that is missed is the work is not
> being accepted.  Oh and I am human, too, regardless what most think or
> hate about me.

And I understand your point. But light appears on the horizon.
Your work is being accepted for 2.5 and 2.4-ac now, and there is 
hope, that sometimes in the near future a generally accepted, and 
(nearly) flawless version of 2.4 will be released. 

For now, diff/patch seems to remain everyone's favorite tools ;)

> Regards,
>
> Andre Hedrick
> Linux Disk Certification Project                Linux ATA Development

Cheers,
  Hans-Peter
