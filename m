Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130764AbQJ1DKM>; Fri, 27 Oct 2000 23:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130773AbQJ1DKC>; Fri, 27 Oct 2000 23:10:02 -0400
Received: from 161-VALL-X6.libre.retevision.es ([62.83.214.161]:32385 "EHLO
	looping.es") by vger.kernel.org with ESMTP id <S130764AbQJ1DJz>;
	Fri, 27 Oct 2000 23:09:55 -0400
Date: Sat, 28 Oct 2000 05:12:11 +0200
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: linux-kernel@vger.kernel.org
Subject: irq probe failed? (2.4.0-latests)
Message-ID: <20001028051211.B474@macula.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
Organization: Mediocrity Naysayers Ltd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On at least test8 onwards on hd[abc] I sometimes get an 

	printk("%s: IRQ probe failed (0x%lx)\n", drive-> name, cookie);

with cookie being ~0

VT82C586 
hda: ST320423A, ATA DISK drive
hdc: SAMSUNG VG34323A (4.32GB), ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
dma and udma off.
-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com

Handle via comment channels only.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
