Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274055AbRI0Wzw>; Thu, 27 Sep 2001 18:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274053AbRI0Wzn>; Thu, 27 Sep 2001 18:55:43 -0400
Received: from jalon.able.es ([212.97.163.2]:40645 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S274049AbRI0Wzc>;
	Thu, 27 Sep 2001 18:55:32 -0400
Date: Fri, 28 Sep 2001 00:55:52 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Robert Macaulay <robert_macaulay@dell.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)]
Message-ID: <20010928005552.A16519@werewolf.able.es>
In-Reply-To: <20010926164935.J27945@athlon.random> <Pine.LNX.4.33.0109261310340.23259-100000@ping.us.dell.com> <20010926203651.Q27945@athlon.random> <20010928001321.L14277@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010928001321.L14277@athlon.random>; from andrea@suse.de on Fri, Sep 28, 2001 at 00:13:21 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010928 Andrea Arcangeli wrote:
>
>So the fix is either:
>
>1) to drop the NOHIGHIO logic like my test patch did
>2) or to keep track of what buffers we must not wait while releasing
>   ram
>

This+tweaks-2+softirq already are worth a 11-pre1, aren't ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Vitamin) for i586
Linux werewolf 2.4.10-bw #1 SMP Thu Sep 27 00:32:53 CEST 2001 i686
