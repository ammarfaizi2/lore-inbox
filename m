Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbSBGNsB>; Thu, 7 Feb 2002 08:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289159AbSBGNrv>; Thu, 7 Feb 2002 08:47:51 -0500
Received: from [195.141.66.36] ([195.141.66.36]:56499 "EHLO pink.pearsoft.ch")
	by vger.kernel.org with ESMTP id <S286188AbSBGNrj>;
	Thu, 7 Feb 2002 08:47:39 -0500
Subject: 2.4.17 freezes
From: Robin Farine <robin.farine@acn-group.ch>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Feb 2002 14:37:12 +0100
Message-Id: <1013089032.8112.6.camel@halftrack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The mailing-list archive contains some reports of 2.4.17 freezes or
crashes in the context of specific hardware configuration, such as
SCSI+ATA and UDMA66 or RAID. In my office however, I had three PCs
running 2.4.17 from the Debian woody distribution, all of them
PentiumIII 82371AB PIIX4 chipset but otherwise without anything fancy.

One of those PCs has a SCSI DAT connected to its motherboard builtin
Adaptec aic7890 SCSI adapter. This PC runs Amanda to backup the three
PCs 2 times a week on a 10Mbits half-duplex LAN.

Everytime amanda ran (under 2.4.17), at least one of the PCs froze
completely (without any trace in the logs): unreachable through network,
black screen and no keyboard response. And sometimes, one of them froze
during normal day usage.

First, I thought of an ATA DMA or SCSI problem and thus configured one
of the PCs' ATA interface in default PIO, 16 bits transfers mode. It
froze as well.

Hope this can help tracking the problem down or at least save some time
to people with a similar situation,

Robin


