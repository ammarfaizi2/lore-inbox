Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130271AbQKFVat>; Mon, 6 Nov 2000 16:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130256AbQKFVa3>; Mon, 6 Nov 2000 16:30:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26464 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129392AbQKFVaR>; Mon, 6 Nov 2000 16:30:17 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: paulj@itg.ie (Paul Jakma)
Date: Mon, 6 Nov 2000 21:28:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jas88@cam.ac.uk (James A. Sutherland),
        dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik), goemon@anime.net (Dan Hollis),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011061837590.31802-100000@rossi.itg.ie> from "Paul Jakma" at Nov 06, 2000 06:39:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13stoN-0006e8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the sound card case for persistent modules is contentious i think.
> what other good reasons are there for persistent data?

Maintaining TV tuning
Maintaining configuration options for USB
Maintaining radio tuner frequencies
Speeding up module reloading (avoiding expensive re-inits - eg 30 seconds for
i2o_scsi)
Remembering IDE tuning options across ide module unloads
Avoiding rescanning the scsi bus on a scsi module reload
...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
