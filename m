Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129508AbQKFROe>; Mon, 6 Nov 2000 12:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129519AbQKFRO2>; Mon, 6 Nov 2000 12:14:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16468 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129508AbQKFRON>; Mon, 6 Nov 2000 12:14:13 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: jas88@cam.ac.uk (James A. Sutherland)
Date: Mon, 6 Nov 2000 17:12:30 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik), goemon@anime.net (Dan Hollis),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <00110613370501.01541@dax.joh.cam.ac.uk> from "James A. Sutherland" at Nov 06, 2000 01:35:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13spou-0006P0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So autoload the module with a "dont_screw_with_mixer" option. When the kernel
> first boots, initialise the mixer to suitable settings (load the module with 
> "do_screw_with_mixer" or whatever); thereafter, the driver shouldn't change
> the mixer settings on load.

Which is part of what persistent module data lets you do. And without having
to mess with dont_screw_with_mixer (which if you get it wrong btw can be 
fatal and hang the hardware)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
