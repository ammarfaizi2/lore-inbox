Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRAGWAd>; Sun, 7 Jan 2001 17:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132201AbRAGWAY>; Sun, 7 Jan 2001 17:00:24 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:5524 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S132140AbRAGWAP>;
	Sun, 7 Jan 2001 17:00:15 -0500
Message-ID: <3A58E69D.30005@voicefx.com>
Date: Sun, 07 Jan 2001 16:58:53 -0500
From: "John O'Donnell" <johnod@voicefx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010104
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0:  __alloc_pages: 3-order allocation failed.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What does this message mean in my dmesg output?


__alloc_pages: 3-order allocation failed.
__alloc_pages: 3-order allocation failed.
__alloc_pages: 3-order allocation failed.
__alloc_pages: 3-order allocation failed.
__alloc_pages: 3-order allocation failed.
reset_xmit_timer sk=c5b3a680 1 when=0x2f49, caller=c022a202

I have been using my computer pretty heavily today.
At the same time:
KDE...
Gnapster:  I share a 45Gb IDE drive (filled) - about 10 to 20 transfers happening 
simultaneously - average.
Burning CD-R's:  dumping alot of Old Time Radio programs to CD-R
Browsin the web in Mozilla.
Misc terminals..
xwave:  recording a 1968 Reel to Reel recording of Eugene Ormandy conducting The 
Philadelphia Orchestra playing Tchaikovsky's Swan Lake to eventually burn to 
audio CD and create mp3's.  :-)
Once in a while xingmp3enc for Linux.

I recorded a 200Mb wav file and tried to edit it.  Xwave gobbled up all my swap 
before bringing up a dialog box - out of memory...  My cdburn failed, had to 
start over...
I just closed xwave....  I did not reboot yet and am getting these messages.
My machine is still functioning ok - other than about 27Mb still swapped, so once 
in a while an app feels sluggish as I believe it is getting paged back in.
I was just curious about the message.

About my home system:

866Mhz PIII (Overclocked to 923Mhz)
256Mb RAM - 133Mhz Bus (Overclocked at 142Mhz)
ISA Aztech FM Radio
PCI 3COM 3c905b 100Mbit Ethernet
PCI Trident 4D NX Wave sound card (4-Front drivers)
AGP 3DFX Voodoo 3000
PCI Adaptec 2940U2W SCSI Adapter (80Mb/Sec Bus)
PCI Adaptec 29160 SCSI Adapter (160Mb/Sec Bus)
9Gb Western Digital 80Mb/sec UW SCSI drives x 4
9Gb Seagate 40Mb/sec UW SCSI drives x 4
SCSI Pioneer DVD 303
SCSI Toshiba 32X CDROM
SCSI HP ScanJet 4c
IDE HP CD Writer+ 9100
SCSI HP C1533A 4mm 8Gb SCSI Tape Drive
IDE Superdisk floppy drive 120Mb
IDE Western Digital WD450AA 45Gb Drive (for the MP3's)
ttyS0: Multitech MT5600ZDXV 56K Voice/Data modem (for answering machine software 
I wrote)
ttyS1: Multitech MT2834ZDXb 33.6k Data modem for emergencies
USB Port:  Rio500 MP3 Player (64Mb internal + 64Mb Flash Card)
lp0: OkiData OL400 Laser Printer

It runs Slackware Linux 7.0 with alot hacked up.
It is connected to the Internet via a 384k SDSL connection.

mrlinux:~# cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  261292032 195178496 66113536        0  1331200 130674688
Swap: 131567616 26980352 104587264
MemTotal:       255168 kB
MemFree:         64564 kB
MemShared:           0 kB
Buffers:          1300 kB
Cached:         127612 kB
Active:          32476 kB
Inact_dirty:     85812 kB
Inact_clean:     10624 kB
Inact_target:       24 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255168 kB
LowFree:         64564 kB
SwapTotal:      128484 kB
SwapFree:       102136 kB



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
