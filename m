Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264548AbTLEW6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264581AbTLEW6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:58:22 -0500
Received: from relay-2m.club-internet.fr ([194.158.104.41]:46982 "EHLO
	relay-2m.club-internet.fr") by vger.kernel.org with ESMTP
	id S264548AbTLEW5a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:57:30 -0500
From: pinotj@club-internet.fr
To: torvalds@osdl.org, nathans@sgi.com
Cc: neilb@cse.unsw.edu.au, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Fri,  5 Dec 2003 23:57:26 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1070665046.1802.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>De: Linus Torvalds <torvalds@osdl.org>
[...]
>Jerome - can you test Nathan's patch together with my "avoid the
>complicated slab logic"? The slab avoidance thing got ext3 stable for you,
>now with Nathan's patch hopefully XFS will be stable too.
[...]

OK, I will do intensive tests this week-end, I have time. I just want to have some confirmations:

1. Is it still usefull to get all the backtraces of the last xfs oops ?
2. I will test patch-slab and patch-xfs on test11, CONFIG_DEBUG_PAGEALLOC (only). Test on XFS root and ext3 with "small" and "big" kernels.
3. What about patch-bio of Manfred ? I didn't have much time to try it yet but seems to stabilize too. Should I use it alone or with the others patchs ?

Thanks all for your help

Jerome Pinot

