Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132993AbRAGTmM>; Sun, 7 Jan 2001 14:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132842AbRAGTmB>; Sun, 7 Jan 2001 14:42:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27920 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132993AbRAGTlz>; Sun, 7 Jan 2001 14:41:55 -0500
Subject: Re: Patch (repost): cramfs memory corruption fix
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 7 Jan 2001 19:42:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), adam@yggdrasil.com (Adam J. Richter),
        parsley@roanoke.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101071124540.27944-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 07, 2001 11:26:29 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FLi2-0003Cy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'll take a look at the ramfs one. I may have broken something else when fixing
> > everything else with ramfs (like unlink) crashing
> 
> Ehh.. Plain 2.4.0 ramfs is fine, assuming you add a "UnlockPage()" to
> ramfs_writepage(). So what do you mean by "fixing everything else"?

-ac has the rather extended ramfs with resource limits and stuff. That one
also has rather more extended bugs 8). AFAIK none of those are in the vanilla
ramfs code



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
