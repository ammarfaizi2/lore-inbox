Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbRCTGJM>; Tue, 20 Mar 2001 01:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131725AbRCTGJB>; Tue, 20 Mar 2001 01:09:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7178 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129828AbRCTGIp>; Tue, 20 Mar 2001 01:08:45 -0500
Date: Mon, 19 Mar 2001 22:07:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: 3rd version of R/W mmap_sem patch available
In-Reply-To: <Pine.LNX.4.21.0103200113550.8828-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0103192206030.1025-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Mar 2001, Marcelo Tosatti wrote:
>
> Could the IDE one cause corruption ?

Only with broken disks, as far as we know right now. There's been so far
just one report of this problem, and nobody has heard back about which
disk this was.. And it should be noisy about it when it happens -
complaining about lost interrupts and resetting the IDE controller.

So unlikely.

		Linus

