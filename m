Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSFOUsY>; Sat, 15 Jun 2002 16:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSFOUsX>; Sat, 15 Jun 2002 16:48:23 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:23824 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S315536AbSFOUsX>; Sat, 15 Jun 2002 16:48:23 -0400
Subject: Hot swap IDE/CompactFlash - safe?
To: linux-kernel@vger.kernel.org
Date: Sat, 15 Jun 2002 22:48:15 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17JKT1-0005ws-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I searched the web for some information about this, and found that
generally this is not recommended, hardware can be damaged, etc.
But, this was mainly about disks (possible damage if +12V power is
applied before +5V, etc.) - my question is not about disks.

How about a CompactFlash card (which looks like a small IDE disk
to the system) in a CF-IDE adapter?  (not CF-PCMCIA - has connectors
for 40-pin IDE ribbon cable and power, a slot for inserting a CF
card, and is mounted like a 3.5-inch floppy drive in a desktop PC)

I've read that CF cards themselves are designed for hot-swapping
(when not reading or writing, such a card draws very little power,
so it doesn't short the bus lines to ground like disks can do),
so the question is, is this safe with the Linux IDE drivers?
There should be some way to tell the kernel that a device was
connected to the bus, and later that it will be disconnected.

Thanks,
Marek

