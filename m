Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbQKNLZk>; Tue, 14 Nov 2000 06:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbQKNLZa>; Tue, 14 Nov 2000 06:25:30 -0500
Received: from ns.tasking.nl ([195.193.207.2]:34834 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S129507AbQKNLZW>;
	Tue, 14 Nov 2000 06:25:22 -0500
Date: Tue, 14 Nov 2000 11:54:31 +0100
From: Frank van Maarseveen <fvm@tasking.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11-pre4: i810_audio: drain_dac, dma timeout?
Message-ID: <20001114115430.A1134@espoo.tasking.nl>
Reply-To: frank_van_maarseveen@tasking.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
Organization: TASKING, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, i810 audio still has problems. No sound at all and kernel says:

Nov 14 11:38:30 espoo kernel: agpgart: Detected an Intel i810 E Chipset. 
Nov 14 11:38:30 espoo kernel: agpgart: detected 4MB dedicated video ram. 
Nov 14 11:38:30 espoo kernel: agpgart: AGP aperture is 64M @ 0x44000000 
Nov 14 11:38:30 espoo kernel: [drm] AGP 0.99 on Intel i810 @ 0x44000000 64MB 
Nov 14 11:38:30 espoo kernel: [drm] Initialized i810 1.1.0 20000928 on minor 63 
Nov 14 11:38:30 espoo kernel: SCSI subsystem driver Revision: 1.00 
Nov 14 11:38:30 espoo kernel: Intel 810 + AC97 Audio, version 0.01, 10:26:18 Nov 14 2000 
Nov 14 11:38:30 espoo kernel: PCI: Setting latency timer of device 00:1f.5 to 64 
Nov 14 11:38:30 espoo kernel: i810: Intel ICH 82801AA found at IO 0x2400 and 0x2000, IRQ 11 
Nov 14 11:38:30 espoo kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5340 (Analog Devices AD1881) 
[...]
Nov 14 11:44:12 espoo kernel: DMA overrun on send 
Nov 14 11:45:46 espoo last message repeated 3 times
Nov 14 11:45:47 espoo kernel: i810_audio: drain_dac, dma timeout? 
Nov 14 11:46:00 espoo kernel: DMA overrun on send 
Nov 14 11:46:00 espoo kernel: i810_audio: drain_dac, dma timeout? 

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
