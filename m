Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSAGQju>; Mon, 7 Jan 2002 11:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289264AbSAGQjk>; Mon, 7 Jan 2002 11:39:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61703 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289267AbSAGQja>; Mon, 7 Jan 2002 11:39:30 -0500
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade
To: hahn@physics.mcmaster.ca (Mark Hahn)
Date: Mon, 7 Jan 2002 16:50:35 +0000 (GMT)
Cc: znmeb@aracnet.com ("M. Edward (Ed) Borasky"),
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <Pine.LNX.4.33.0201071118440.5017-100000@coffee.psychology.mcmaster.ca> from "Mark Hahn" at Jan 07, 2002 11:21:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Ncyp-0001m9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> non sequitur: Linus would like an adaptive VM, which recognizes
> apps with the properties you describe.  there's no theoretical
> or practical reason this cannot be achieved.

Oh there is. To compute the correct VM behaviour requires knowledge of
what the workload will do in the future. Now if you can solve the halting
problem and/or invent time travel I'm waiting to hear.

There are heuristics, and Linus goal is the right one. Its just useful to
recognize someone will always have a load you get wrong. Most users don't
understand tweaking vm configurations, yet even windows NT boxes let you do
so. For the critical jobs there will be someone who is willing to make the
effort to learn how to tune it.

> you have the source.  whinging about knobs is just whinging.
> all serious knobs require recompilation anyway.

Now that is definitely not the case. I'm not talking 

	Virtual memory system (Andrea, Marcelo, Rik, Rik rmap, Linus) CONFIG_VM

