Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129385AbQKVXWm>; Wed, 22 Nov 2000 18:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130162AbQKVXWc>; Wed, 22 Nov 2000 18:22:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12152 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129485AbQKVXWY>; Wed, 22 Nov 2000 18:22:24 -0500
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem?
To: maillist@chello.nl (Igmar Palsenberg)
Date: Wed, 22 Nov 2000 22:52:18 +0000 (GMT)
Cc: schwab@suse.de (Andreas Schwab), middelink@polyware.nl (Pauline Middelink),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011230042420.28000-100000@server.serve.me.nl> from "Igmar Palsenberg" at Nov 23, 2000 12:43:08 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yikV-0006ZQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > |> > > #define __bad_udelay() panic("Udelay called with too large a constant")
> > |> 
> > |> Can't we change that to :
> > |> #error "Udelay..."
> > 
> > No.
> 
> ?? I think I'm missing something here.

preprocessor stuff is done too early for this

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
