Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSFXFmt>; Mon, 24 Jun 2002 01:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317367AbSFXFms>; Mon, 24 Jun 2002 01:42:48 -0400
Received: from lsanca2-ar27-4-46-143-199.lsanca2.dsl-verizon.net ([4.46.143.199]:20864
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S317365AbSFXFms>; Mon, 24 Jun 2002 01:42:48 -0400
Date: Sun, 23 Jun 2002 22:42:36 -0700 (PDT)
From: Ben Clifford <benc@hawaga.org.uk>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.24-dj1
In-Reply-To: <20020621025918.GA9415@suse.de>
Message-ID: <Pine.LNX.4.44.0206232236340.1736-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


When I tried to copy around 500Mb of files between two filesystems on the
same hard-drive, I got the following message on the console:

hda: error: DMA in progress...

and the system seems to get stuck - I can't kill the cp with ctrl-c, nor
can I get getty to let me log in on another console.

However, the kernel still forwards IP traffic and I presume is managing to
tickle my hardware watchdog as the system doesn't automatically reboot.

Hopefully, the relevant part of my boot output follows.



ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Intel Corp. 82801BA IDE U100, PCI slot 00:1f.1
ATA: chipset rev.: 17
ATA: non-legacy mode: IRQ probe delayed
PIIX: Intel Corp. 82801BA IDE U100 UDMA100 controller on pci00:1f.1
PCI: Setting latency timer of device 00:1f.1 to 64
    ide0: BM-DMA at 0x2480-0x2487, BIOS settings: hda:DMA, hdb:pio
PCI: Setting latency timer of device 00:1f.1 to 64
    ide1: BM-DMA at 0x2488-0x248f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD200EB-11CSF0, DISK drive
hdc: Compaq CRD-8402B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 39102336 sectors w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [2586/240/63] p1 p2 < p5 p6 p7 
p8 p9 p
10 p11 >



When I am not doing intensive disk activity, it seems to last longer - it
has been up one and a half hours so far and hasn't crashed yet, doing a
mixture of mail reading and running distributed.net.

Ben
- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
http://www.hawaga.org.uk/ben/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9FrFOsYXoezDwaVARApuEAJ9+35KZHMBjLQ53ZPFqLPL+0R5hdACcCOpL
XRiiRiHA6aueKTat0LsHCfE=
=avqK
-----END PGP SIGNATURE-----

