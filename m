Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292379AbSBBUWk>; Sat, 2 Feb 2002 15:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292380AbSBBUWa>; Sat, 2 Feb 2002 15:22:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:531 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292379AbSBBUWZ>; Sat, 2 Feb 2002 15:22:25 -0500
Subject: Re: should I trust 'free' or 'top'?
To: david.lang@digitalinsight.com (David Lang)
Date: Sat, 2 Feb 2002 20:35:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), blumpkin@attbi.com,
        adam-dated-1013023458.e87e05@flounder.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202021150370.21319-100000@dlang.diginsite.com> from "David Lang" at Feb 02, 2002 11:58:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16X6sb-0000T0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> tweak them again to fix B anc cause C .... tweak them again to fix J and
> cause A' type circles with nobody (other then possibly rik) understanding
> what was really causing the problems (at least if they did understand them
> they weren't posted here)

Plenty of people understood them. The continual changing was also not 
helped by the fact that at least three totally contradictory sets of
patches were getting applied (Riks, the use once stuff and Linus own
changes)

> the fundamental problem was that while the VM would work well most of the
> time, once in a while it would hit a pathalogical condition that would
> lockup the machine completely, the new VM was seen as not nessasarily
> being quite as good in the best cases, but avoiding the worst lockups (of
> course it had a few problems of it's own, but these seemed to be easier to
> fix without causing additional problems)

The original Andrea vm was faster on light loads, and even less stable on
anything sane. In the -aa patches it does quite well, but those aren't 
merged either.

Alan
