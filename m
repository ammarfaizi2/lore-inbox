Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129586AbQKWGW1>; Thu, 23 Nov 2000 01:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132568AbQKWGWT>; Thu, 23 Nov 2000 01:22:19 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:57509 "EHLO
        smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S129586AbQKWGWA>; Thu, 23 Nov 2000 01:22:00 -0500
Message-ID: <3A1CB07C.CEE01F1F@haque.net>
Date: Thu, 23 Nov 2000 00:51:56 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ext2 filesystem corruptions back from dead? 2.4.0-test11
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got these while doing many compiles on my box ....

Nov 23 00:40:06 viper kernel: EXT2-fs warning (device ide0(3,3)):
ext2_unlink: Deleting nonexistent file (622295), 0
Nov 23 00:40:06 viper kernel: = 1
Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
ext2_free_blocks: Freeing blocks not in datazone - block = 540028982,
count = 1
Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
ext2_free_blocks: Freeing blocks not in datazone - block = 540024880,
count = 1
Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
ext2_free_blocks: Freeing blocks not in datazone - block = 170926128,
count = 1


What else should I provide?

[mhaque@viper mhaque]$ uname -a
Linux viper.haque.net 2.4.0-test11 #6 Sun Nov 19 22:17:33 EST 2000 i686
unknown

Nov 16 19:03:15 viper kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
Nov 16 19:03:15 viper kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx 
Nov 16 19:03:15 viper kernel: PIIX4: IDE controller on PCI bus 00 dev 39 
Nov 16 19:03:15 viper kernel: PIIX4: chipset revision 1 
Nov 16 19:03:15 viper kernel: PIIX4: not 100%% native mode: will probe
irqs later 
Nov 16 19:03:15 viper kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:DMA 
Nov 16 19:03:15 viper kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:DMA, hdd:DMA 

Nov 16 19:03:15 viper kernel: hda: IBM-DJNA-371350, ATA DISK drive 
Nov 16 19:03:15 viper kernel: hdb: CREATIVEDVD-ROM DVD2240E 12/24/97,
ATAPI CDROM drive 
Nov 16 19:03:15 viper kernel: hdc: Maxtor 82160D2, ATA DISK drive 
Nov 16 19:03:15 viper kernel: hdd: IBM-DTLA-307045, ATA DISK drive 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
