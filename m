Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280931AbRKORuQ>; Thu, 15 Nov 2001 12:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280968AbRKORuA>; Thu, 15 Nov 2001 12:50:00 -0500
Received: from t2.redhat.com ([199.183.24.243]:62716 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S280931AbRKORsi>; Thu, 15 Nov 2001 12:48:38 -0500
Message-ID: <3BF3FFF4.A4768C43@redhat.com>
Date: Thu, 15 Nov 2001 17:48:36 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.>=13 VM/kswapd/shmem/Oracle issue (was Re: Google's mm problems)
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin> <20011109033851.A15099@asooo.flowerfire.com> <20011115184036.D1381@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> loop that can trigger with the -ac VM when all the ZONE_DMA is
> unfreeable (now fixed in mainline with classzone) have nothing to do

Ok I think I've misunderstood classzone then.
As I understand it, it prevents looping in ZONE_NORMAL when ZONE_DMA has
memory free,
and looping in ZONE_HIGHMEM if ZONE_NORMAL or ZONE_DMA have memory free.
Can you please explain how it also solves the ZONE_DMA problem ? 

Greetings,
   Arjan van de Ven
