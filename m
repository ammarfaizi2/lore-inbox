Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130517AbQLEWaq>; Tue, 5 Dec 2000 17:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130803AbQLEWag>; Tue, 5 Dec 2000 17:30:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24836 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130797AbQLEWaU>; Tue, 5 Dec 2000 17:30:20 -0500
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
To: scole@lanl.gov
Date: Tue, 5 Dec 2000 22:02:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <00120510163700.00846@spc.esa.lanl.gov> from "Steven Cole" at Dec 05, 2000 10:16:37 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143QAI-0000GI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Crystal 4280/461x + AC97 Audio, version 0.13, 08:56:46 Dec  5 2000
> cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
> cs461x: Unknown card (1028:0096) at 0xf8ffe000/0xf8e00000, IRQ 18
> ac97_codec: AC97 Audio codec, vendor id1: 0x4352, id2: 0x5914 (Unknown)

This correctly sees the card

> cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
> cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0xf8ffe000/0xf8e00000, IRQ 18

This gets garbage back when it reads the vendor subids. I dont at this point
see it being a sound bug but a pci layer bug


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
