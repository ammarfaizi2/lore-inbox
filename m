Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129095AbQJ0NwP>; Fri, 27 Oct 2000 09:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQJ0NwE>; Fri, 27 Oct 2000 09:52:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39780 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129084AbQJ0Nvv>; Fri, 27 Oct 2000 09:51:51 -0400
Subject: Re: bind() allowed to non-local addresses
To: mpeterson@calderasystems.com (Matt Peterson)
Date: Fri, 27 Oct 2000 14:52:17 +0100 (BST)
Cc: dwmw2@infradead.org (David Woodhouse), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <39F084F2.6FEBB75F@calderasystems.com> from "Matt Peterson" at Oct 20, 2000 11:46:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13p9vg-0004Ti-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does some one have a copy of the posix 1003.1g draft so this can be
> verified.  This is the kind of ammunition I was talking about earlier

1003.1g isnt what matters - SuS is.

> that I would need to convince Sun to change the compatibility test
> suite.  However, if the 1003.1g draft even mentions failure with errno

The compatibility test is broken from a pedantic point of view as your IP
address can change dynamically between the query for it and the bind.

In general though, bind() is assumed to do the checks and fail if non local
and I agree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
