Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129905AbRAaDU0>; Tue, 30 Jan 2001 22:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129992AbRAaDUQ>; Tue, 30 Jan 2001 22:20:16 -0500
Received: from [200.216.82.35] ([200.216.82.35]:19072 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129905AbRAaDUB>; Tue, 30 Jan 2001 22:20:01 -0500
Date: Wed, 31 Jan 2001 01:19:14 -0200
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA VT82C686X
Message-ID: <20010131011914.D160@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
X-Mailer: Mutt/1.3.14i - Linux 2.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Me too. But I couldn't get UDMA 66 after changing my BIOS
settings and booting. With 33 it's very stable (what I used
with 2.4.0). A diff:

-hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=1868/255/63, UDMA(33)
+hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=1868/255/63, UDMA(66)
...
+hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
+hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
VFS: Mounted root (ext2 filesystem) readonly.
-Freeing unused kernel memory: 200k freed
+Freeing unused kernel memory: 204k freed
+hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
+hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
+hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
+hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
+hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
+hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
+hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
+hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
+ide0: reset: success

I know this is a known issue, but I thought testing would be
OK. ASUS K7V with the shipped cable.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
