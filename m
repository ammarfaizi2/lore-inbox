Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292702AbSBUS2a>; Thu, 21 Feb 2002 13:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292703AbSBUS2X>; Thu, 21 Feb 2002 13:28:23 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:16132
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S292702AbSBUS2J>; Thu, 21 Feb 2002 13:28:09 -0500
Subject: Re: [PROBLEM]: 2.4.18-rc1 - Unable to mount CD-ROM/RW
From: Shawn Starr <spstarr@sh0n.net>
To: jss@pacbell.net
Cc: Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <LI5YSPXWYTY04431V32LFIF97042TP.3c7534b4@jss>
In-Reply-To: <LI5YSPXWYTY04431V32LFIF97042TP.3c7534b4@jss>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 21 Feb 2002 13:31:42 -0500
Message-Id: <1014316330.8812.27.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's an LFS distribution i built. The problem is 2.4.17 didn't have this
problem. Something introduced into 2.4.18-pre/rc.

I compile my core devices into kernel.

Shawn.


On Thu, 2002-02-21 at 12:56, J.S.Souza wrote:
> What distro are you using?  If you are using RedHat 7.2 then there are known issues with the installer.   Some of the fixes suggest doing a 'depmod -ae' (this 
> is redhat's fix on their website - I forget the exact URL btw).  Anyways, try 'depmod -ae' and see if that fixes it.
> 
> 2/21/2002 9:40:35 AM, Shawn Starr <spstarr@sh0n.net> wrote:
> 
> >Uniform Multi-Platform E-IDE driver Revision: 6.31
> >ide: Assuming 33MHz system bus speed for PIO modes; override with
> >idebus=xx
> >PIIX3: IDE controller on PCI bus 00 dev 39
> >PIIX3: chipset revision 0
> >PIIX3: not 100% native mode: will probe irqs later
> >    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
> >    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
> >hda: FUJITSU MPE3064AT, ATA DISK drive
> >hdb: WDC AC32500H, ATA DISK drive
> >hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive      <--------------------
> >ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> >ide1 at 0x170-0x177,0x376 on irq 15
> >hda: 12672450 sectors (6488 MB) w/512KiB Cache, CHS=788/255/63, (U)DMA
> >hdb: Disabling (U)DMA for WDC AC32500H
> >hdb: 4999680 sectors (2560 MB) w/128KiB Cache, CHS=620/128/63
> >Partition check:
> > hda: hda1 hda2
> > hdb: hdb1
> >Floppy drive(s): fd0 is 1.44M
> >FDC 0 is a post-1991 82077
> >3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> >00:0c.0: 3Com PCI 3c900 Cyclone 10Mbps TPO at 0xe880. Vers LK1.1.16
> >PPP generic driver version 2.4.1
> >PPP Deflate Compression module registered
> >PPP BSD Compression module registered
> >SCSI subsystem driver Revision: 1.00
> >scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
> >        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
> >        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
> >
> >  Vendor: HP        Model: T4000s            Rev: 1.10
> >  Type:   Sequential-Access                  ANSI SCSI revision: 02
> >scsi1 : SCSI host adapter emulation for IDE ATAPI devices
> >  Vendor: YAMAHA    Model: CRW2100E          Rev: 1.0N <----------------
> >  Type:   CD-ROM                             ANSI SCSI revision: 02
> >st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g
> >segs 16
> >Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
> >
> >When i attempt to mount /dev/cdrom (symlink to /dev/scd0) I get
> >
> >mount: /dev/cdrom is not a valid block device (or /dev/scd0).
> >
> >What broke? :-(
> >
> >Shawn.
> >
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> 
> 
> 


