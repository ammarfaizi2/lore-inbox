Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129454AbQKFVe7>; Mon, 6 Nov 2000 16:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129758AbQKFVet>; Mon, 6 Nov 2000 16:34:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30816 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129454AbQKFVej>; Mon, 6 Nov 2000 16:34:39 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Mon, 6 Nov 2000 21:34:42 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), alonz@usa.net (Alon Ziv),
        dwmw2@infradead.org (David Woodhouse), linux-kernel@vger.kernel.org
In-Reply-To: <200011061949.UAA31584@cave.bitwizard.nl> from "Rogier Wolff" at Nov 06, 2000 08:49:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13stud-0006ez-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	if exists && is from this boot then && is right size
> > 		read data into __persistent ELF section
> > 	endif
> 
> Alan, why are you stating "if it's from this boot"? I can think that
> maybe you want to keep stuff across boots too. Maybe once we're at it,
> have two sections. One that is persistent across boots, the other
> isn't.

Possibly. The cases brought up so far are all 'within one boot'. But I agree
you could add long term persistent data if there was a need

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
