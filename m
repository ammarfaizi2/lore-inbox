Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSDWNhK>; Tue, 23 Apr 2002 09:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315206AbSDWNhJ>; Tue, 23 Apr 2002 09:37:09 -0400
Received: from node14760.a2000.nl ([24.132.71.96]:49655 "HELO
	sahara.openoffice.nl") by vger.kernel.org with SMTP
	id <S315202AbSDWNhH>; Tue, 23 Apr 2002 09:37:07 -0400
Date: Tue, 23 Apr 2002 15:37:02 +0200
From: Valentijn Sessink <valentyn+kernellist@nospam.openoffice.nl>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Subject: 2.2.20+ide-patch: ide_set_handler: handler not null
Message-ID: <20020423153702.A5106@openoffice.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Message-Flag: Open Office - Linux for the desktop
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

2.2.20 with Andre's IDE patches, running on Debian 2.2.

Apr 23 14:53:51 cadmium kernel: hda: timeout waiting for DMA
Apr 23 14:53:51 cadmium kernel: hda: ide_dma_timeout: Lets do it again!stat
= 0x58, dma_stat = 0x20
Apr 23 14:53:51 cadmium kernel: hda: DMA disabled
Apr 23 14:53:51 cadmium kernel: hda: irq timeout: status=0x80 { Busy }
Apr 23 14:53:51 cadmium kernel: hda: DMA disabled
Apr 23 14:53:51 cadmium kernel: hda: ide_set_handler: handler not null;
old=c0197f84, new=c0197f84
Apr 23 14:53:51 cadmium kernel: bug: kernel timer added twice at c0197df1.
Apr 23 14:53:51 cadmium kernel: ide0: reset: success

This is the poor man's SMP, a dual Celeron 466 with an Abit BP6 motherboard
- the motherboard not being the most stable on earth. However, the notice
above might still help the quality of the IDE driver. Maxtor 5T030H3.

(Oh, I'm aware of the fact that running the IDE patch is my own
responsibility, i.e. might break things, burn house, steal car).

Feel free to ask additional information.

Best regards,

Valentijn
p.s. "valentyn+kernellist@nospam.openoffice.nl" is a correct and working
e-mail address. No subscription to linux-kernel, so a Cc: is appreciated.
