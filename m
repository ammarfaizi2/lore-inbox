Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314073AbSESAIS>; Sat, 18 May 2002 20:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314075AbSESAIR>; Sat, 18 May 2002 20:08:17 -0400
Received: from grande.dcc.unicamp.br ([143.106.7.8]:44179 "EHLO
	grande.dcc.unicamp.br") by vger.kernel.org with ESMTP
	id <S314073AbSESAIR>; Sat, 18 May 2002 20:08:17 -0400
Date: Sat, 18 May 2002 21:08:10 -0300 (EST)
From: ULISSES FURQUIM FREIRE DA SILVA <ra993482@ic.unicamp.br>
To: linux-kernel@vger.kernel.org
Subject: Hardware, IDE or ext3 problem?
Message-ID: <Pine.GSO.4.10.10205182031540.14231-100000@tigre.dcc.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

	I installed Red Hat 7.3 and the 2.4.18-3 kernel shows some IDE
errors on boot like:

VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.

	I also tried the 2.4.18-4 kernel, but the errors continue. It's
weird cause this happen only on boot and in spite of it the system runs
fine.
	I have a SiS 5513 chipset with a QUANTUM FIREBALLlct15 20 IDE
drive.
	I'm not sure if I have a true hardware problem or if there is a
bug in the kernel. Any ideas?
	(please CC the answers to me)

Thanks,

-- Ulisses

