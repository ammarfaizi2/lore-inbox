Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131194AbQK1W25>; Tue, 28 Nov 2000 17:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131273AbQK1W2i>; Tue, 28 Nov 2000 17:28:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19002 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S131194AbQK1W20>; Tue, 28 Nov 2000 17:28:26 -0500
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
To: baggins@sith.mimuw.edu.pl (Jan Rekorajski)
Date: Tue, 28 Nov 2000 21:58:14 +0000 (GMT)
Cc: schwab@suse.de (Andreas Schwab), linux-kernel@vger.kernel.org
In-Reply-To: <20001128222040.H2680@sith.mimuw.edu.pl> from "Jan Rekorajski" at Nov 28, 2000 10:20:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140slT-000565-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > AFAICS, _all_ resource limits are equally applied to root processes. =
>  Why
> > should NPROC be different?
> 
> Because you want to be able to `kill <pid>`?
> And if you are over-limits you can't?

Wrong. limit is a shell built in

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
