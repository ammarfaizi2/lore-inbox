Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129955AbRBGIxl>; Wed, 7 Feb 2001 03:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbRBGIxb>; Wed, 7 Feb 2001 03:53:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61457 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129955AbRBGIxQ>; Wed, 7 Feb 2001 03:53:16 -0500
Subject: Re: CPU error codes
To: carlos@fisica.ufpr.br (Carlos Carvalho)
Date: Wed, 7 Feb 2001 08:53:24 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <14976.24819.276892.26475@hoggar.fisica.ufpr.br> from "Carlos Carvalho" at Feb 06, 2001 06:39:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QQLw-00087S-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Really? I thought it could be because of RAM. Here's the story:

RAM talks to the chipset so I dont think it could (unless it confused the
chipset)

> CPU 1: Machine Check Exception: 0000000000000004
> Bank 4: b200000000040151<0>Kernel panic: CPU context corrupt

Ok that decodes as:
	Status valid
	Uncorrect Error
	Error Enabled
	Processor Context Corrupt

Memory Heirarchy Error
	Instruction Fetch
	L1 cache

More than that I can't really say. Power and heat problems can certainly
trigger MCE's. I don't know if I/O devices can influence them.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
