Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261222AbRELLW6>; Sat, 12 May 2001 07:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261223AbRELLWi>; Sat, 12 May 2001 07:22:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58128 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261222AbRELLWa>; Sat, 12 May 2001 07:22:30 -0400
Subject: Re: 2.4.4 kernel freeze for unknown reason
To: mikeg@wen-online.de (Mike Galbraith)
Date: Sat, 12 May 2001 12:18:33 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linuxkernel@AdvancedResearch.org (Vincent Stemen),
        jq419@my-deja.com (Jacky Liu), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105120709570.479-100000@mikeg.weiden.de> from "Mike Galbraith" at May 12, 2001 08:05:42 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yXPt-00044K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > If I turn swap off all together or turn it off and back on
> > > periodically to clear the swap before it gets full, I do not seem to
> > > experience the lockups.
> 
> Why do I not see this behavior with a heavy swap throughput test load?
> It seems decidedly odd to me that swapspace should remain allocated on
> other folks lightly loaded boxen given that my heavily loaded box does
> release swapspace quite regularly.  What am I missing?

If you swap really hard it seems much happier. If you vaguely swap stuff out 
over time then I too see the description above only I have Rik's dont deadlock
on oom tweak so I see apps die.

Alan

