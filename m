Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQKFRGy>; Mon, 6 Nov 2000 12:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQKFRGo>; Mon, 6 Nov 2000 12:06:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58962 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129222AbQKFRGg>; Mon, 6 Nov 2000 12:06:36 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 6 Nov 2000 17:05:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dwmw2@infradead.org (David Woodhouse),
        goemon@anime.net (Dan Hollis), oxymoron@waste.org (Oliver Xymoron),
        kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <3A06A053.56F09ACB@mandrakesoft.com> from "Jeff Garzik" at Nov 06, 2000 07:13:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sphu-0006O4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ...or, give up this silly nonsense about loading and unload modules on
> every open() and close().   A module load modifies the running kernel
> code... why do people do this on such a whim?
> 
> Just load the driver at bootup and forget about it.  Problem solved.

If the sound card is only used some of the time or setup and then used
for TV its nice to get the 60K + 128K DMA buffer back when you dont need it
especially on a low end box

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
