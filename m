Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbUCOEjN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 23:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUCOEjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 23:39:13 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:52125 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262254AbUCOEjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 23:39:12 -0500
Message-ID: <4055335B.30402@cyberone.com.au>
Date: Mon, 15 Mar 2004 15:38:51 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org, riel@redhat.com,
       torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
References: <20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp> <Pine.LNX.4.44.0403141638390.1554-100000@dmt.cyclades> <20040314121503.13247112.akpm@osdl.org> <20040314230138.GV30940@dualathlon.random> <20040314152253.05c58ecc.akpm@osdl.org> <20040315001400.GX30940@dualathlon.random>
In-Reply-To: <20040315001400.GX30940@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>
>I don't see other ways to optimize it (and I never enjoyed too much the
>per-zone lru since it has some downside too with a worst case on 2G
>systems). peraphs a further optimization could be a transient per-cpu
>lru refiled only by the page reclaim (so absolutely lazy while lots of
>ram is free), but maybe that's already what you're doing when you say
>"Adding/removing sixteen pages for one taking of the lock". Though the
>fact you say "sixteen pages" sounds like it's not as lazy as it could
>be.
>

Hi Andrea,
What are the downsides on a 2G system?

