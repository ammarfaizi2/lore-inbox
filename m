Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWDXJP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWDXJP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 05:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWDXJP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 05:15:29 -0400
Received: from pproxy.gmail.com ([64.233.166.178]:46142 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751141AbWDXJP3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 05:15:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UY75f5eHzEhznZdjRnnyLIE0XbKnh6J3PVyy2NYzvL0n15c5B/ZomzR+N32x+ICbiMf//TGbXzSqWIvCwKdHhjwWZspsyo9fCqxbhkv28s0WwusBOdDmLf14b125s0F1090XKPacPI2AkkFubDRH2qOCkR3dqpYgyBYvt7U79i8=
Message-ID: <8bf247760604240215j12af040dk4e695dbe03d89a83@mail.gmail.com>
Date: Mon, 24 Apr 2006 02:15:28 -0700
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SD Card not mounting
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   When i try to mount an generic SD Card on my hardware. i get the error:

mount /dev/mmcblk0 /mnt/mmc -t vfat
mount: Mounting /dev/mmcblk0 on /mnt/mmc failed: Device or resource busy


I have appended a list of boot messages related to the SD.
mmcblk0: mmc0:c3ad SD032 29888KiB
 mmcblk0:<7>MMC: starting cmd 12 arg 00000000 flags 00000009
 p1

The following the the MMC Debug messages (MMC Debug option enabled in
make menuconfig)

/ # dmesg
000000 00000000 00000000
MMC: starting cmd 11 arg 00014600 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00014600, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00014800 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00014800, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00014a00 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00014a00, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00014c00 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00014c00, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00014e00 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00014e00, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00015000 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00015000, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00015200 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00015200, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00015400 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00015400, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00015600 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00015600, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00015800 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00015800, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00015a00 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00015a00, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00015c00 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00015c00, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00015e00 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00015e00, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00016000 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00016000, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00016200 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00016200, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00016400 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00016400, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00016600 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00016600, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00016800 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00016800, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00016a00 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00016a00, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC: starting cmd 11 arg 00016c00 flags 00000009
MMC1: DMA block read, DTO 0 cycles + 15000000 ns, 1 blocks of 512
bytes, 1 segments
MMC1: CMD17, argument 0x00016c00, 32-bit response, CRC
        MMC IRQ 0001 (CMD 17): EOC
MMC1: Response 00000900
        MMC DMA 512 bytes CB 0020 (0 segments to go), c1c81f54
        MMC IRQ 0008 (CMD -1): BRS
MMC: req done (11): 0: 00000900 00000000 00000000 00000000
MMC1: Freeing DMA channel 0
