Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129735AbQKXRqe>; Fri, 24 Nov 2000 12:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129904AbQKXRqY>; Fri, 24 Nov 2000 12:46:24 -0500
Received: from waste.org ([209.173.204.2]:33344 "EHLO waste.org")
        by vger.kernel.org with ESMTP id <S129735AbQKXRqO>;
        Fri, 24 Nov 2000 12:46:14 -0500
Date: Fri, 24 Nov 2000 11:15:50 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Igmar Palsenberg <maillist@chello.nl>, Andreas Schwab <schwab@suse.de>,
        Pauline Middelink <middelink@polyware.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem?
In-Reply-To: <E13yikV-0006ZQ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10011241113540.9367-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Alan Cox wrote:

> > > |> > > #define __bad_udelay() panic("Udelay called with too large a constant")
> > > |> 
> > > |> Can't we change that to :
> > > |> #error "Udelay..."
> > > 
> > > No.
> > 
> > ?? I think I'm missing something here.
> 
> preprocessor stuff is done too early for this

You could still change it to
__bug__module_is_using_a_delay_thats_too_large__please_report()..

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
