Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132535AbQLVXjb>; Fri, 22 Dec 2000 18:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbQLVXjV>; Fri, 22 Dec 2000 18:39:21 -0500
Received: from DKBH-T-004-p-250-183.tmns.net.au ([203.54.250.183]:2570 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S132486AbQLVXjL>;
	Fri, 22 Dec 2000 18:39:11 -0500
Message-ID: <3A43DED8.5365FD49@eyal.emu.id.au>
Date: Sat, 23 Dec 2000 10:08:08 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: test13-pre4
In-Reply-To: <Pine.LNX.4.10.10012211726060.968-100000@penguin.transmeta.com> <3A43506B.6CEF84BB@eyal.emu.id.au> <20001222153145.A15733@athlon.random> <20001222160150.A28385@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Ok, found it, you can workaround it with:
> 
> CONFIG_LVM_PROC_FS=y

Yes, this fixed it. I do build with proc, and have no idea why
this was off in my config. Anyway, why is there this private proc
option in .config at all? most modules use the global setting for
proc (CONFIG_PROC_FS), only very few have such private options.

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
