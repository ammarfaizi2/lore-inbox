Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbRAKAZK>; Wed, 10 Jan 2001 19:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRAKAZA>; Wed, 10 Jan 2001 19:25:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16647 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129584AbRAKAYu>; Wed, 10 Jan 2001 19:24:50 -0500
Subject: Re: Subtle MM bug
To: tao@acc.umu.se (David Weinehall)
Date: Thu, 11 Jan 2001 00:24:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        ebiederm@xmission.com (Eric W. Biederman),
        andrea@suse.de (Andrea Arcangeli),
        dwmw2@infradead.org (David Woodhouse),
        zlatko@iskon.hr (Zlatko Calusic), riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010111005657.B2243@khan.acc.umu.se> from "David Weinehall" at Jan 11, 2001 12:56:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GVXT-0001Js-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The MMU on these systems is a CAM, and the mmu table is thus backwards to
> > convention. (It also means you can notionally map two physical addresses to
> > one virtual but thats undefined in the implementation ;))
> 
> Are there any other (not yet supported) platforms with similar (or other
> unrelated, but hard to support because of the current architecture of
> the kernel) problems?

I believe its uniquely deranged. There are people who have asked for reverse
tables for other purposes (eg cache flush handling) but their mmu is the normal
way around.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
