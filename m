Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSIBNaT>; Mon, 2 Sep 2002 09:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318297AbSIBNaS>; Mon, 2 Sep 2002 09:30:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9176 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318295AbSIBNaS>;
	Mon, 2 Sep 2002 09:30:18 -0400
Date: Mon, 2 Sep 2002 15:36:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0208301822200.2042-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.44.0209021535330.5160-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Sep 2002, Tobias Ringstrom wrote:

> While the O(1) scheduler has performed very well for me in most
> situations, I have one big problem with it.  When running a
> Counter-Strike game server on Linux 2.4.19 with the sched-2.4.19-rc2-A4
> patch applied, the server process is niced from the default value of 15
> (interactive) to 25 (background).  This means that every time crond
> wakes up or a mail arrives the game latency becomes extremely bad and
> the users experience lag.

does the same problem happen if you renice the game server to -10 or -15?

	Ingo

