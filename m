Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132116AbQKZEzb>; Sat, 25 Nov 2000 23:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132200AbQKZEzV>; Sat, 25 Nov 2000 23:55:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13388 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S132116AbQKZEzI>; Sat, 25 Nov 2000 23:55:08 -0500
Subject: Re: [PATCH] removal of "static foo = 0"
To: georgn@home.com
Date: Sun, 26 Nov 2000 04:25:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14880.29022.261932.284497@somanetworks.com> from "Georg Nikodym" at Nov 25, 2000 09:11:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13ztNR-0001ew-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  AB> of changes that yield a negligable advantage and reduce stability
>  AB> a tiny little bit. That is pushing Linux in the direction of this
>  AB> abyss. You notice that the view gets better, and I get nervous.
> 
> Can somebody stop this train load of bunk?
> 
> Uninitialized global variables always have a initial value of
> zero.  Static or otherwise.  Period.

That isnt what Andries is arguing about. Read harder. Its semantic differences
rather than code differences.

	static int a=0;

says 'I thought about this. I want it to start at zero. I've written it this
way to remind of the fact'

Sure it generates the same code

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
