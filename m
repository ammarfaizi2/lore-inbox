Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131987AbRAJTej>; Wed, 10 Jan 2001 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132041AbRAJTe3>; Wed, 10 Jan 2001 14:34:29 -0500
Received: from mail11.voicenet.com ([207.103.0.37]:40380 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S131987AbRAJTeV>;
	Wed, 10 Jan 2001 14:34:21 -0500
Message-ID: <3A5CB938.9090203@voicefx.com>
Date: Wed, 10 Jan 2001 14:34:16 -0500
From: "John O'Donnell" <johnod@voicefx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [preview] VIA IDE driver v3.11 with vt82c686b UDMA100 support
In-Reply-To: <20010110124524.A2154@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> Hi!
> 
> For all of you who had problems getting the VIA IDE driver to work
> correctly on the 686b, here is a driver that should work with those
> chips, even in UDMA 100 mode. I've not tested it, because I don't have
> the 686b myself. So it may eat your filesystem as well.
> 
> Good luck!

Oops - I did not look close enough.  I have the 686a.
Well, it works the same  :-)

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (cf/cg) IDE UDMA66 controller on pci0:4.1
     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD450AA-00BAA0, ATA DISK drive
hdc: Hewlett-Packard CD-Writer Plus 9100, ATAPI CDROM drive
hdd: LS-120 VER5 00 UHD Floppy, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 87930864 sectors (45021 MB) w/2048KiB Cache, CHS=5473/255/63, UDMA(33)
hdd: 123264kB, 963/8/32 CHS, 533 kBps, 512 sector size, 720 rpm

Timing tests are the same....

-- 
<SomeLamer> what's the difference between chattr and chmod?
<SomeGuru> SomeLamer: man chattr > 1; man chmod > 2; diff -u 1 2 | less
	-- Seen on #linux on irc
=== Never ask a geek why, just nod your head and slowly back away.===
+==============================+====================================+
| John O'Donnell (Sr. Systems Engineer, Net Admin, Webmaster, etc.) |
| Voice FX Corporation (a subsidiary of Student Advantage)          |
| One Plymouth Meeting         |     E-Mail: johnod@voicefx.com     |
| Suite 610                    |           www.voicefx.com          |
| Plymouth Meeting, PA 19462   |         www.campusdirect.com       |
+==============================+====================================+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
